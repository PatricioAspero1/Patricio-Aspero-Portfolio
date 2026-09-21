#!/usr/bin/env bash
set -u

OUTFILE="${OUTFILE:-/var/log/olympus_check/02_monitoring.log}"
PROMETHEUS_URL="${PROMETHEUS_URL:-}"
GRAFANA_URL="${GRAFANA_URL:-}"
HERMES_HOST="${HERMES_HOST:-}"
SSH_USER="${SSH_USER:-admin}"

mkdir -p "$(dirname "$OUTFILE")"

echo "=== Monitoring Stack Check ===" > "$OUTFILE"
echo "Timestamp: $(date)" >> "$OUTFILE"
echo "" >> "$OUTFILE"

if [[ -n "$PROMETHEUS_URL" ]]; then
    echo "--- Prometheus ---" >> "$OUTFILE"
    if curl -fsS --connect-timeout 5 "${PROMETHEUS_URL%/}/-/healthy" \
        | grep -q "Prometheus Server is Healthy"; then
        echo "Prometheus: UP" >> "$OUTFILE"
    else
        echo "Prometheus: DOWN or unreachable" >> "$OUTFILE"
    fi
else
    echo "Prometheus check skipped: PROMETHEUS_URL not configured." >> "$OUTFILE"
fi

if [[ -n "$GRAFANA_URL" ]]; then
    echo "--- Grafana ---" >> "$OUTFILE"
    if curl -fsS --connect-timeout 5 "${GRAFANA_URL%/}/api/health" \
        | grep -q '"database"[[:space:]]*:[[:space:]]*"ok"\|"message"[[:space:]]*:[[:space:]]*"Database ok"'; then
        echo "Grafana: UP" >> "$OUTFILE"
    else
        echo "Grafana: DOWN or unreachable" >> "$OUTFILE"
    fi
else
    echo "Grafana check skipped: GRAFANA_URL not configured." >> "$OUTFILE"
fi

if [[ -n "$HERMES_HOST" ]]; then
    echo "--- Cloudflare Tunnel ---" >> "$OUTFILE"
    TUNNEL_STATUS=$(
        ssh -o BatchMode=yes -o ConnectTimeout=5 "${SSH_USER}@${HERMES_HOST}" \
          "sudo systemctl is-active cloudflared" 2>/dev/null || true
    )

    if [[ "$TUNNEL_STATUS" == "active" ]]; then
        echo "Cloudflared: ACTIVE" >> "$OUTFILE"
    else
        echo "Cloudflared: INACTIVE or check failed (got: ${TUNNEL_STATUS:-unknown})" >> "$OUTFILE"
    fi
else
    echo "Cloudflare Tunnel check skipped: HERMES_HOST not configured." >> "$OUTFILE"
fi
