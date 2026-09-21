# Automated Network Discovery

This project runs on **Clio**, an Ubuntu virtual machine used for network
discovery, classification, and visualization within my homelab.

The automation periodically scans the local network, records discovered
systems, classifies devices using a combination of heuristics and clustering,
and generates topology data that can be consumed by visualization tools.

The goal is to reduce the amount of infrastructure documentation that must be
maintained manually as the homelab changes.

---

## Workflow

At a high level, the discovery pipeline operates like this:

```text
Local Network
     │
     ▼
   Nmap
     │
     ▼
discovered_devices.csv
     │
     ▼
Device Classification
     │
     ▼
classified_devices.csv
     │
     ├──────────────► Topology Generator
     │
     └──────────────► Visualization Data
```

A wrapper script runs the individual stages in sequence and can archive
previous topology output when changes are detected.

---

## Components

### `discover.py`

Runs Nmap against a configured subnet and parses the resulting XML.

The script collects information such as:

- IP address
- MAC address
- Vendor information
- Hostname
- OS detection results
- Open ports and detected services

The public version uses a configurable subnet rather than exposing the actual
network used in my homelab.

### `classify.py`

Processes the discovered-device inventory and extracts features that can be
used to group systems.

Current features include:

- Vendor category
- Hostname-based hints
- Number of discovered open ports
- Address-derived features

The script uses **HDBSCAN** clustering to add an additional classification
signal to the discovered inventory.

### `generate_topology.py`

Converts the classified inventory into a browser-viewable topology using
**vis-network**.

Devices are assigned roles such as:

- Gateway
- Hypervisor
- Storage
- DNS / infrastructure
- Other systems

The public version intentionally omits sensitive device details such as MAC
addresses and raw open-port listings from the generated tooltips.

### `update_and_archive.sh`

Runs the discovery and classification pipeline in sequence.

It also:

- Generates updated topology output
- Calls the visualization-data generator when available
- Archives previous topology versions when changes occur
- Retains only a limited number of older diagram versions

---

## Technologies

- Python
- Bash
- Nmap
- XML parsing
- CSV processing
- pandas
- scikit-learn / HDBSCAN
- PyYAML
- vis-network
- Linux
- Cron / scheduled execution

---

## What I'm Learning

This project has helped me build experience with:

- Network discovery
- Nmap automation
- Parsing structured scan output
- Python scripting
- Device classification
- Unsupervised clustering
- Data transformation
- Scheduled automation
- Generating network documentation
- Building tools around a changing infrastructure environment

---

## Limitations

The discovery and classification process is not intended to be a perfect
source of truth.

Nmap OS detection, service detection, vendor information, and automated
classification can all be incomplete or inaccurate depending on the device
and network conditions.

For that reason, automated results can be supplemented with manual role
overrides where needed.

---

## Ongoing Development

This project continues to evolve alongside my homelab.

Current and future improvements include:

- Improving classification accuracy
- Adding better device-role detection
- Reducing dependence on address-based heuristics
- Incorporating additional inventory sources
- Improving topology relationships between hosts and workloads
- Integrating discovery results more closely with the interactive homelab
  visualization
- Automatically identifying meaningful infrastructure changes

---

## Security & Public Source Code

The scripts published here have been sanitized for a public repository.

Internal addressing, MAC addresses, environment-specific paths, and other
unnecessary infrastructure details are removed or replaced with configurable
values.

[Read the Public Repository Sanitization Notice →](../SANITIZATION.md)

---

[← Back to Scripts & Automation](../README.md)
