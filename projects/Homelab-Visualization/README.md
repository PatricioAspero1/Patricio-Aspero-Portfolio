# Interactive Homelab Visualization

## Overview

The Interactive Homelab Visualization is a custom application I am developing
to provide a navigable visual representation of my homelab.

Rather than relying entirely on static diagrams, the project displays physical
hosts, virtual machines, containers, infrastructure services, and their
relationships in an interactive environment.

The project is designed to make a growing homelab easier to understand,
document, and explore.

---

## Purpose

As my environment expanded, static documentation became increasingly difficult
to keep synchronized with the actual infrastructure.

This project was created to provide a more dynamic way to visualize:

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
