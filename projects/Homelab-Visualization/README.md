# Interactive Homelab Visualization

## Overview

My Interactive Homelab Visualization is a customized deployment and ongoing
integration of NetworkBound's open-source **Homelab Galaxy Dashboard**.

The dashboard provides a navigable 3D representation of my homelab, allowing
physical infrastructure, Proxmox nodes, virtual machines, containers, and
supporting services to be represented visually.

My work on the project focuses on deploying the platform within my own
environment, integrating it with my infrastructure and monitoring systems,
and exploring ways to connect it with the custom discovery and automation
tools I am developing elsewhere in the homelab.

The goal is to create a visual operational view of my environment that becomes
increasingly dynamic as the homelab evolves.

---

## Open-Source Foundation & Credit

This project is based on the open-source
[Homelab Galaxy Dashboard](https://github.com/NetworkBound/homelab-galaxy-dashboard)
created by **NetworkBound**.

The original project provides the 3D visualization framework used to represent
Proxmox infrastructure as an interactive galaxy, with virtualization nodes,
guests, infrastructure data, and monitoring information represented visually.

Full credit for the original Homelab Galaxy Dashboard and its core visualization
platform belongs to NetworkBound and the project's contributors.

### My deployment and customization

My work focuses on deploying, configuring, integrating, and adapting the
dashboard for my own homelab environment.

This includes connecting the visualization with my existing infrastructure and
exploring integrations with projects I have built elsewhere in the homelab,
including:

- My three-node Proxmox environment
- Automated network discovery running on Clio
- Generated infrastructure and topology data
- Prometheus-based monitoring
- My locally hosted Ollama environment
- Existing homelab services and infrastructure
- Future automation through Mnemosyne

I am also using the project as an opportunity to learn more about JavaScript,
web-based visualization, APIs, dynamic infrastructure data, and the process of
adapting an existing open-source project to a real environment.


[View the original Homelab Galaxy Dashboard on GitHub →](https://github.com/NetworkBound/homelab-galaxy-dashboard)

---

## Preview

![My Homelab Galaxy Dashboard](screenshots/galaxy-overview.png)

*My implementation of NetworkBound's Homelab Galaxy Dashboard displaying
physical infrastructure, Proxmox workloads, network components, and service
relationships within my homelab.*

> **Development Screenshot:** This image was captured during development and
> troubleshooting. The visualization continues to change as I improve device
> discovery, classification, topology relationships, and integration with the
> rest of my infrastructure.

---

## Purpose

As my environment expanded, static documentation became increasingly difficult
to keep synchronized with the actual infrastructure.

I adopted and customized this project to provide a more dynamic way to visualize:

- Physical servers
- Proxmox nodes
- Virtual machines
- LXC containers
- Storage infrastructure
- Monitoring systems
- Remote-access services
- Relationships between systems

The long-term goal is for the visualization to evolve automatically as the
homelab changes.

---

## Relationship to Network Discovery

The visualization integrates with the automated discovery pipeline running on
Clio.

At a high level:

```text
Network
   │
   ▼
Automated Discovery
   │
   ▼
Device Classification
   │
   ▼
Generated Inventory Data
   │
   ▼
Interactive Visualization
```

This allows the visualization to use data generated from the actual network
rather than relying entirely on manually maintained device information.

[Explore the Network Discovery project →](../scripts-tools/Network-Discovery/README.md)

---

## Current Features

Current functionality includes:

- Interactive infrastructure visualization
- Representation of physical systems
- Representation of VMs and containers
- Relationships between infrastructure components
- Navigation through a larger homelab environment
- Integration with generated network data
- Browser-based interface

---

## Technologies

The project currently incorporates:

- JavaScript
- HTML
- CSS
- Python-generated data
- Linux
- Nginx
- Network discovery data
- Proxmox infrastructure information

---

## What I'm Learning

Building the visualization has helped me develop experience with:

- JavaScript application development
- Visualizing infrastructure data
- Data-driven user interfaces
- Representing relationships between systems
- Integrating backend-generated data with a frontend application
- Web hosting and deployment
- Debugging browser-based applications
- Designing tools around real infrastructure

---

## Project Status

**Status:** Active Development

The visualization is functional and currently integrated with my homelab.
Additional discovery, monitoring, topology, and automation integrations are
still being developed.

---

## Ongoing Development

The visualization is an ongoing project.

Future goals include:

- Improving automatic synchronization with discovered infrastructure
- Better representation of VM and container relationships
- Additional host and service metadata
- More useful system-health information
- Improved navigation and visual organization
- Integration with monitoring data
- Automatically reflecting changes in the homelab
- Potential integration with Mnemosyne for automated documentation and infrastructure analysis

The long-term goal is to create a visual interface that acts as both a
documentation platform and an operational view of the homelab.

---

## Security

The public version of this project intentionally excludes:

- Internal IP addresses
- Credentials
- Authentication data
- Private endpoints
- API keys
- Unnecessary host identifiers
- Other sensitive infrastructure information

Any public source code or screenshots are reviewed and sanitized before being
published.

---

## Credits

**Homelab Galaxy Dashboard** was created by
[NetworkBound](https://github.com/NetworkBound).

[View the original Homelab Galaxy Dashboard →](https://github.com/NetworkBound/homelab-galaxy-dashboard)

The original project and its core visualization platform belong to NetworkBound
and its contributors. This portfolio documents my personal deployment,
configuration, integrations, modifications, and continued development around
the project.

---

[← Back to Portfolio](../../README.md)
