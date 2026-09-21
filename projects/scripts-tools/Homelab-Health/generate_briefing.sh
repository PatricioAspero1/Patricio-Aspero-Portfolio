#!/usr/bin/env bash
set -u

REPORT_DIR="${REPORT_DIR:-/var/log/olympus_check}"
COMBINED="${COMBINED:-/tmp/olympus_briefing_raw.txt}"
OLLAMA_URL="${OLLAMA_URL:-http://127.0.0.1:11434}"
OLLAMA_MODEL="${OLLAMA_MODEL:-qwen2.5:14b}"
DISCORD_WEBHOOK="${DISCORD_WEBHOOK:-}"
MAX_LEN="${MAX_LEN:-1900}"

# Optional comma-separated weather configuration.
WEATHER_CITIES="${WEATHER_CITIES:-}"
WEATHER_LATS="${WEATHER_LATS:-}"
WEATHER_LONS="${WEATHER_LONS:-}"

mkdir -p "$REPORT_DIR"
: > "$COMBINED"

for f in "$REPORT_DIR"/*.log; do
    [[ "$f" == *webhook_errors.log ]] && continue
    [[ -f "$f" ]] || continue

    echo "--- $(basename "$f" .log) ---" >> "$COMBINED"
    cat "$f" >> "$COMBINED"
    echo "" >> "$COMBINED"
done

echo "--- Tech & World News Headlines ---" >> "$COMBINED"

HN=$(curl -fsS --connect-timeout 10 -H "User-Agent: Mozilla/5.0" \
    https://hnrss.org/frontpage 2>/dev/null \
    | xmllint --xpath '//item/title/text()' - 2>/dev/null | head -5 || true)

NPR=$(curl -fsS --connect-timeout 10 -H "User-Agent: Mozilla/5.0" \
    https://feeds.npr.org/1001/rss.xml 2>/dev/null \
    | xmllint --xpath '//item/title/text()' - 2>/dev/null | head -5 || true)

BBC=$(curl -fsS --connect-timeout 10 -H "User-Agent: Mozilla/5.0" \
    https://feeds.bbci.co.uk/news/world/rss.xml 2>/dev/null \
    | xmllint --xpath '//item/title/text()' - 2>/dev/null | head -5 || true)

BC=$(curl -fsS --connect-timeout 10 -H "User-Agent: Mozilla/5.0" \
    https://www.bleepingcomputer.com/feed/ 2>/dev/null \
    | xmllint --xpath '//item/title/text()' - 2>/dev/null | head -5 || true)

[[ -n "$BC" ]] && { echo "Cybersecurity:" >> "$COMBINED"; echo "$BC" | sed 's/^/  - /' >> "$COMBINED"; }
[[ -n "$HN" ]] && { echo "Hacker News:" >> "$COMBINED"; echo "$HN" | sed 's/^/  - /' >> "$COMBINED"; }
[[ -n "$NPR" ]] && { echo "US News:" >> "$COMBINED"; echo "$NPR" | sed 's/^/  - /' >> "$COMBINED"; }
[[ -n "$BBC" ]] && { echo "World News:" >> "$COMBINED"; echo "$BBC" | sed 's/^/  - /' >> "$COMBINED"; }

if [[ -z "$HN" && -z "$NPR" && -z "$BBC" && -z "$BC" ]]; then
    echo "(Could not fetch news feeds)" >> "$COMBINED"
fi

echo "" >> "$COMBINED"

# Optional weather section.
if [[ -n "$WEATHER_CITIES" && -n "$WEATHER_LATS" && -n "$WEATHER_LONS" ]]; then
    IFS=',' read -r -a cities <<< "$WEATHER_CITIES"
    IFS=',' read -r -a lats <<< "$WEATHER_LATS"
    IFS=',' read -r -a lons <<< "$WEATHER_LONS"

    echo "--- Weather ---" >> "$COMBINED"

    for i in "${!cities[@]}"; do
        city="${cities[$i]}"
        lat="${lats[$i]:-}"
        lon="${lons[$i]:-}"

        [[ -z "$lat" || -z "$lon" ]] && continue

        weather_json=$(curl -fsS --connect-timeout 10 \
          "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&hourly=relativehumidity_2m,precipitation_probability&temperature_unit=celsius&windspeed_unit=kmh&timezone=auto" \
          2>/dev/null || true)

        [[ -z "$weather_json" ]] && continue

        temp=$(jq -r '.current_weather.temperature // "n/a"' <<< "$weather_json")
        wind=$(jq -r '.current_weather.windspeed // "n/a"' <<< "$weather_json")
        code=$(jq -r '.current_weather.weathercode // -1' <<< "$weather_json")
        humidity=$(jq -r '.hourly.relativehumidity_2m[0] // "n/a"' <<< "$weather_json")
        rain_prob=$(jq -r '.hourly.precipitation_probability[0] // "n/a"' <<< "$weather_json")

        case "$code" in
            0) cond="Clear" ;;
            1) cond="Mainly clear" ;;
            2) cond="Partly cloudy" ;;
            3) cond="Overcast" ;;
            45) cond="Fog" ;;
            51) cond="Light drizzle" ;;
            61) cond="Slight rain" ;;
            80) cond="Rain showers" ;;
            *) cond="Weather code $code" ;;
        esac

        echo "  - $city: $cond, ${temp} C, wind ${wind} km/h, humidity ${humidity}%, rain chance ${rain_prob}%" >> "$COMBINED"
    done

    echo "" >> "$COMBINED"
fi

CHECK_DATA=$(cat "$COMBINED")

if [[ -z "$CHECK_DATA" ]]; then
    echo "No report data found."
    exit 1
fi

SYSTEM_PROMPT='You are the local AI assistant for a homelab environment.
Below are results from scheduled infrastructure checks and selected public news feeds.
Write a concise morning briefing that summarizes cluster health, service availability,
pending updates, storage concerns, and any notable issues. If weather data is present,
summarize it briefly. Highlight a few important cybersecurity, technology, economic,
or world-news items. Keep the briefing factual and concise.'

ESCAPED_DATA=$(printf '%s' "$CHECK_DATA" | jq -Rs .)

RESPONSE=$(
    curl -fsS "${OLLAMA_URL%/}/api/generate" \
      -H "Content-Type: application/json" \
      -d "{
        \"model\": \"$OLLAMA_MODEL\",
        \"system\": $(printf '%s' "$SYSTEM_PROMPT" | jq -Rs .),
        \"prompt\": $ESCAPED_DATA,
        \"stream\": false,
        \"options\": {\"num_ctx\": 8192}
      }" 2>/dev/null \
      | jq -r '.response // empty'
)

if [[ -z "$RESPONSE" ]]; then
    RESPONSE="The local AI model could not generate a briefing. Please review the collected logs."
fi

printf '%s\n' "$RESPONSE" > "$REPORT_DIR/morning_briefing.txt"

if [[ -z "$DISCORD_WEBHOOK" ]]; then
    echo "DISCORD_WEBHOOK is not configured; briefing saved locally only."
    exit 0
fi

send_chunk() {
    local chunk_text="$1"
    local chunk_num="$2"
    local tmpfile
    local http_code

    tmpfile=$(mktemp)
    printf '%s' "$chunk_text" | jq -Rs '{content: .}' > "$tmpfile"

    http_code=$(
        curl -sS -o /dev/null -w "%{http_code}" \
          -H "Content-Type: application/json" \
          -d @"$tmpfile" \
          "$DISCORD_WEBHOOK"
    )

    rm -f "$tmpfile"

    if [[ "$http_code" != "204" ]]; then
        echo "Webhook chunk $chunk_num failed with HTTP $http_code at $(date)" \
          >> "$REPORT_DIR/webhook_errors.log"
        return 1
    fi

    echo "Webhook chunk $chunk_num sent successfully at $(date)" \
      >> "$REPORT_DIR/webhook_errors.log"
}

if (( ${#RESPONSE} <= MAX_LEN )); then
    send_chunk "$RESPONSE" 1
else
    start=0
    chunk_num=1

    while (( start < ${#RESPONSE} )); do
        end=$((start + MAX_LEN))

        if (( end < ${#RESPONSE} )); then
            snippet="${RESPONSE:start:MAX_LEN}"
            last_nl=$(printf '%s' "$snippet" | grep -bo $'\n' | tail -1 | cut -d: -f1 || true)

            if [[ -n "$last_nl" ]]; then
                end=$((start + last_nl + 1))
            fi
        else
            end=${#RESPONSE}
        fi

        chunk="${RESPONSE:start:end-start}"
        send_chunk "$chunk" "$chunk_num" || break

        start=$end
        ((chunk_num++))
    done
fi
