#!/usr/bin/env bash
set -u

OUTFILE="${OUTFILE:-/var/log/olympus_check/03_arr.log}"
SONARR_URL="${SONARR_URL:-}"
RADARR_URL="${RADARR_URL:-}"
SONARR_API_KEY="${SONARR_API_KEY:-}"
RADARR_API_KEY="${RADARR_API_KEY:-}"

mkdir -p "$(dirname "$OUTFILE")"

echo "=== Application Stack Check ===" > "$OUTFILE"
echo "Timestamp: $(date)" >> "$OUTFILE"
echo "" >> "$OUTFILE"

if [[ -n "$SONARR_URL" ]]; then
    echo "--- Sonarr ---" >> "$OUTFILE"

    if curl -fsS --connect-timeout 5 "$SONARR_URL" >/dev/null; then
        echo "Sonarr service: UP" >> "$OUTFILE"

        if [[ -n "$SONARR_API_KEY" ]]; then
            MISSING_SONARR=$(
                curl -fsS \
                  -H "X-Api-Key: $SONARR_API_KEY" \
                  "${SONARR_URL%/}/api/v3/wanted/missing?pageSize=1" \
                  | jq -r '.totalRecords // "error"' 2>/dev/null
            )
            echo "Missing episodes: ${MISSING_SONARR:-error}" >> "$OUTFILE"
        else
            echo "Sonarr API detail skipped: SONARR_API_KEY not configured." >> "$OUTFILE"
        fi
    else
        echo "Sonarr service: DOWN" >> "$OUTFILE"
    fi
fi

if [[ -n "$RADARR_URL" ]]; then
    echo "--- Radarr ---" >> "$OUTFILE"

    if curl -fsS --connect-timeout 5 "$RADARR_URL" >/dev/null; then
        echo "Radarr service: UP" >> "$OUTFILE"

        if [[ -n "$RADARR_API_KEY" ]]; then
            MISSING_RADARR=$(
                curl -fsS \
                  -H "X-Api-Key: $RADARR_API_KEY" \
                  "${RADARR_URL%/}/api/v3/movie?monitored=true" \
                  | jq '[.[] | select(.hasFile == false)] | length' 2>/dev/null
            )
            echo "Missing movies: ${MISSING_RADARR:-error}" >> "$OUTFILE"
        else
            echo "Radarr API detail skipped: RADARR_API_KEY not configured." >> "$OUTFILE"
        fi
    else
        echo "Radarr service: DOWN" >> "$OUTFILE"
    fi
fi
