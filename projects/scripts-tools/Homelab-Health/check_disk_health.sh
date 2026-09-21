#!/usr/bin/env bash
set -u

OUTFILE="${OUTFILE:-/var/log/olympus_check/06_disk.log}"
SSH_USER="${SSH_USER:-admin}"
MEDIA_HOST="${MEDIA_HOST:-}"
MEDIA_PATH="${MEDIA_PATH:-/mnt/media}"
ATLAS_HOST="${ATLAS_HOST:-}"
ATLAS_SSH_USER="${ATLAS_SSH_USER:-admin}"

mkdir -p "$(dirname "$OUTFILE")"

echo "=== Disk Health Check ===" > "$OUTFILE"
echo "Timestamp: $(date)" >> "$OUTFILE"
echo "" >> "$OUTFILE"

if [[ -n "$MEDIA_HOST" ]]; then
    echo "--- Media Storage ---" >> "$OUTFILE"
    ssh -o BatchMode=yes -o ConnectTimeout=5 "${SSH_USER}@${MEDIA_HOST}" \
      "df -h '$MEDIA_PATH'" 2>/dev/null >> "$OUTFILE" \
      || echo "Media host check failed" >> "$OUTFILE"
fi

if [[ -n "$ATLAS_HOST" ]]; then
    echo "--- TrueNAS Pool Health ---" >> "$OUTFILE"
    ssh -o BatchMode=yes -o ConnectTimeout=5 "${ATLAS_SSH_USER}@${ATLAS_HOST}" \
      "sudo zpool list -o name,size,alloc,free,health" 2>/dev/null >> "$OUTFILE" \
      || echo "TrueNAS pool check failed" >> "$OUTFILE"
fi
