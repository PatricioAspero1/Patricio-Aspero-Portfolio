#!/usr/bin/env bash
set -u

OUTFILE="${OUTFILE:-/var/log/olympus_check/04_updates.log}"
SSH_USER="${SSH_USER:-admin}"

# Format:
# UPDATE_HOSTS="Icarus=icarus.internal Prometheus=prometheus.internal"
UPDATE_HOSTS="${UPDATE_HOSTS:-}"

mkdir -p "$(dirname "$OUTFILE")"

echo "=== Package Update Check ===" > "$OUTFILE"
echo "Timestamp: $(date)" >> "$OUTFILE"
echo "" >> "$OUTFILE"

if [[ -z "$UPDATE_HOSTS" ]]; then
    echo "No hosts configured. Set UPDATE_HOSTS." >> "$OUTFILE"
    exit 0
fi

for entry in $UPDATE_HOSTS; do
    name="${entry%%=*}"
    host="${entry#*=}"

    echo "--- $name ---" >> "$OUTFILE"

    UPDATES=$(
        ssh -o BatchMode=yes -o ConnectTimeout=5 "${SSH_USER}@${host}" \
          "apt list --upgradable 2>/dev/null | tail -n +2 | wc -l" 2>/dev/null || true
    )

    if [[ "$UPDATES" =~ ^[0-9]+$ ]]; then
        echo "Available updates: $UPDATES" >> "$OUTFILE"
    else
        echo "Check failed (SSH error or unsupported package manager)" >> "$OUTFILE"
    fi
done
