# Clio

**Type:** Virtual Machine  
**Host:** Icarus  
**Operating System:** Ubuntu 24.04 LTS  
**Resources:** 4 vCPUs / 8 GB RAM / 50 GB Storage  
**Role:** Network Discovery, Visualization & Homelab Dashboard

## Overview

Clio is an Ubuntu Server virtual machine that acts as the visualization and
network-discovery platform for my homelab.

Rather than maintaining a completely static inventory of my network, Clio
uses automated discovery and classification scripts to identify systems and
generate visual representations of the environment.

## Automated Network Discovery

Clio runs a custom discovery pipeline that:

1. Scans the network for active systems
2. Collects information about discovered devices
3. Classifies discovered systems
4. Generates topology data
5. Updates the visual representation of the homelab
6. Archives previous topology versions when changes occur

The discovery process runs automatically on a scheduled basis.

## Homelab Visualization

Clio hosts my custom interactive homelab visualization.

The interface provides a visual representation of the physical hosts,
virtual machines, containers, and relationships between systems in the
environment.

This project combines infrastructure administration with Python,
network discovery, data processing, and web visualization.

## Scanopy

Clio also hosts Scanopy for additional network discovery and topology
visualization.

## Monitoring

Clio runs Prometheus Node Exporter, allowing system metrics to be collected
by the monitoring infrastructure running on Tartarus and visualized through
Grafana.

## Technologies

- Ubuntu Linux
- Python
- Nmap
- Scanopy
- Nginx
- HTML / JavaScript
- Network discovery
- Automated classification
- Cron automation
- Prometheus Node Exporter
- Grafana

## Skills & Experience

Clio has given me hands-on experience with:

- Automated network discovery
- Python automation
- Network topology generation
- Linux service administration
- Web application hosting
- Infrastructure visualization
- Monitoring and metrics
- Scheduled automation
- Integrating multiple infrastructure tools

---

[← Back to Icarus](README.md)
