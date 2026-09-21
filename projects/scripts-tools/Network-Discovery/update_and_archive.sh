#!/usr/bin/env bash
set -euo pipefail

CLASSIFIER_DIR="${CLASSIFIER_DIR:-$HOME/classifier}"
PYTHON="${PYTHON:-$CLASSIFIER_DIR/venv/bin/python3}"
WEB_DIR="${WEB_DIR:-$CLASSIFIER_DIR/public}"
ARCHIVE_DIR="${ARCHIVE_DIR:-$CLASSIFIER_DIR/archive}"
NEW_DIAGRAM="${NEW_DIAGRAM:-network_topology.drawio}"

cd "$CLASSIFIER_DIR"

echo "$(date): Starting network discovery pipeline."

echo "$(date): Running network discovery..."
./discover.py

echo "$(date): Classifying devices..."
"$PYTHON" classify.py

# Optional visualization-data generator.
if [[ -f "$CLASSIFIER_DIR/generate_netmap.py" ]]; then
    echo "$(date): Generating visualization data..."
    "$PYTHON" generate_netmap.py
fi

echo "$(date): Generating topology..."
"$PYTHON" generate_topology.py

mkdir -p "$ARCHIVE_DIR"
mkdir -p "$WEB_DIR"

if [[ -f "$NEW_DIAGRAM" ]]; then
    if [[ -f "$WEB_DIR/$NEW_DIAGRAM" ]]; then
        if cmp -s "$NEW_DIAGRAM" "$WEB_DIR/$NEW_DIAGRAM"; then
            echo "$(date): Diagram unchanged; no archive required."
        else
            echo "$(date): Diagram changed; archiving previous version."

            timestamp=$(date +%Y%m%d-%H%M%S)

            cp "$WEB_DIR/$NEW_DIAGRAM" \
               "$ARCHIVE_DIR/network_topology-$timestamp.drawio"

            cp "$NEW_DIAGRAM" "$WEB_DIR/"

            # Keep the five newest archived diagrams.
            find "$ARCHIVE_DIR" \
                -maxdepth 1 \
                -type f \
                -name "network_topology-*.drawio" \
                -printf "%T@ %p\n" \
                | sort -nr \
                | tail -n +6 \
                | cut -d" " -f2- \
                | xargs -r rm --
        fi
    else
        echo "$(date): First run; copying diagram to web directory."
        cp "$NEW_DIAGRAM" "$WEB_DIR/"
    fi
else
    echo "$(date): No Draw.io topology generated; skipping diagram archive."
fi

echo "$(date): Network discovery pipeline completed successfully."
