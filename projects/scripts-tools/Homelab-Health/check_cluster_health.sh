#!/usr/bin/env bash
set -u

OUTFILE="${OUTFILE:-/var/log/olympus_check/01_health.log}"
SSH_USER="${SSH_USER:-admin}"
CLUSTER_QUERY_HOST="${CLUSTER_QUERY_HOST:-}"
CONTAINER_HOST="${CONTAINER_HOST:-}"
CRITICAL_CTS="${CRITICAL_CTS:-104 105 106 107 108 109}"

mkdir -p "$(dirname "$OUTFILE")"

echo "=== Cluster Health Check ===" > "$OUTFILE"
echo "Timestamp: $(date)" >> "$OUTFILE"
echo "" >> "$OUTFILE"

if [[ -z "$CLUSTER_QUERY_HOST" ]]; then
    echo "CLUSTER_QUERY_HOST is not configured." >> "$OUTFILE"
    exit 1
fi

# Query Proxmox cluster resources.
ssh -o BatchMode=yes -o ConnectTimeout=5 "${SSH_USER}@${CLUSTER_QUERY_HOST}" \
  "sudo pvesh get /cluster/resources --type vm --output-format json" \
  | jq -r '.[] | "\(.name): Status=\(.status), CPU=\(.cpu*100)% (approx), MaxMem=\(.maxmem/1024/1024) MB"' \
  >> "$OUTFILE" 2>/dev/null

# Limited self-healing for explicitly approved containers.
if [[ -n "$CONTAINER_HOST" ]]; then
    for ctid in $CRITICAL_CTS; do
        ct_status=$(
            ssh -o BatchMode=yes -o ConnectTimeout=5 "${SSH_USER}@${CONTAINER_HOST}" \
              "sudo pct status $ctid 2>/dev/null | awk '{print \$2}'" 2>/dev/null
        )

        if [[ "$ct_status" == "stopped" ]]; then
            echo "Container $ctid is stopped. Attempting restart..." >> "$OUTFILE"

            ssh -o BatchMode=yes -o ConnectTimeout=5 "${SSH_USER}@${CONTAINER_HOST}" \
              "sudo pct start $ctid" >> "$OUTFILE" 2>&1

            sleep 2

            new_status=$(
                ssh -o BatchMode=yes -o ConnectTimeout=5 "${SSH_USER}@${CONTAINER_HOST}" \
                  "sudo pct status $ctid 2>/dev/null | awk '{print \$2}'" 2>/dev/null
            )

            echo "New status for $ctid: ${new_status:-unknown}" >> "$OUTFILE"
        fi
    done
fi

ONLINE_COUNT=$(grep -c "Status=running" "$OUTFILE" || true)

echo "" >> "$OUTFILE"
echo "Running VMs/Containers: $ONLINE_COUNT" >> "$OUTFILE"
