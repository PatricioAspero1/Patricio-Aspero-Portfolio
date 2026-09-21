#!/usr/bin/env python3

import csv
import json
import os
from datetime import datetime

import yaml

INPUT_CSV = os.getenv("TOPOLOGY_INPUT", "classified_devices.csv")
OUTPUT_HTML = os.getenv("TOPOLOGY_OUTPUT", "topology.html")
CONFIG_FILE = os.getenv("TOPOLOGY_CONFIG", "roles.yaml")


def load_config():
    """Load optional role overrides."""
    try:
        with open(CONFIG_FILE, encoding="utf-8") as file:
            return yaml.safe_load(file) or {}
    except FileNotFoundError:
        return {}


def detect_role(device, config):
    """Assign a basic infrastructure role to a discovered device."""
    ip = device.get("ip", "")
    hostname = device.get("hostname", "").lower()
    vendor = device.get("vendor", "").lower()
    ports = device.get("ports", "").lower()

    for pattern, role in config.get("roles", {}).items():
        if pattern.lower() in hostname or pattern.lower() in vendor:
            return role

    # Optional gateway matching is controlled through an environment variable.
    gateway_ip = os.getenv("GATEWAY_IP", "")
    if gateway_ip and ip == gateway_ip:
        return {"level": 1, "group": "gateway"}

    if "proxmox" in hostname or "pve" in hostname:
        return {"level": 2, "group": "hypervisor"}

    if "8006" in ports:
        return {"level": 2, "group": "hypervisor"}

    if "truenas" in hostname or "nas" in hostname:
        return {"level": 2, "group": "storage"}

    if "445" in ports or "2049" in ports:
        return {"level": 2, "group": "storage"}

    if "pihole" in hostname or "dns" in hostname:
        return {"level": 2, "group": "dns"}

    return {"level": 3, "group": "other"}


def generate_html(devices, config):
    """Generate a sanitized browser-viewable topology."""
    nodes = []
    edges = []

    for index, device in enumerate(devices):
        node_id = f"node{index}"
        hostname = device.get("hostname", "").strip()
        vendor = device.get("vendor", "").strip()
        os_name = device.get("os", "").strip()

        label = hostname or vendor or f"Device {index + 1}"
        role = detect_role(device, config)

        color_map = {
            "gateway": "#8dd3c7",
            "hypervisor": "#fb8072",
            "storage": "#80b1d3",
            "dns": "#fdb462",
            "other": "#97c2fc",
        }

        # Public output intentionally avoids raw IP, MAC and port details.
        tooltip_parts = [f"Role: {role['group']}"]
        if vendor:
            tooltip_parts.append(f"Vendor: {vendor}")
        if os_name:
            tooltip_parts.append(f"OS: {os_name}")

        nodes.append(
            {
                "id": node_id,
                "label": label,
                "title": "<br>".join(tooltip_parts),
                "color": color_map.get(role["group"], "#97c2fc"),
                "shape": "box",
                "level": role["level"],
                "group": role["group"],
            }
        )

    gateway_id = next(
        (node["id"] for node in nodes if node["group"] == "gateway"),
        None,
    )

    if gateway_id:
        for node in nodes:
            if node["id"] != gateway_id:
                edges.append({"from": gateway_id, "to": node["id"]})

    nodes_json = json.dumps(nodes)
    edges_json = json.dumps(edges)

    html = f"""<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Network Topology</title>
    <script src="https://unpkg.com/vis-network/standalone/umd/vis-network.min.js"></script>
    <style>
        #mynetwork {{
            width: 100%;
            height: 800px;
            border: 1px solid lightgray;
        }}
    </style>
</head>
<body>
    <h1>Network Topology</h1>
    <p>Updated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
    <div id="mynetwork"></div>

    <script>
        const nodes = new vis.DataSet({nodes_json});
        const edges = new vis.DataSet({edges_json});

        const data = {{ nodes, edges }};

        const options = {{
            layout: {{
                hierarchical: {{
                    enabled: true,
                    direction: "UD",
                    sortMethod: "directed",
                    levelSeparation: 150,
                    nodeSpacing: 200,
                    treeSpacing: 200
                }}
            }},
            edges: {{
                smooth: false,
                arrows: {{
                    to: {{ enabled: true, type: "arrow" }}
                }}
            }},
            physics: {{
                enabled: false
            }},
            interaction: {{
                hover: true,
                tooltipDelay: 200,
                navigationButtons: true
            }}
        }};

        new vis.Network(
            document.getElementById("mynetwork"),
            data,
            options
        );
    </script>
</body>
</html>
"""

    with open(OUTPUT_HTML, "w", encoding="utf-8") as file:
        file.write(html)

    print(f"Topology HTML generated at {OUTPUT_HTML}")


def main():
    config = load_config()
    devices = []

    with open(INPUT_CSV, "r", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        devices.extend(reader)

    generate_html(devices, config)


if __name__ == "__main__":
    main()
