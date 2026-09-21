# Prometheus

**Role:** Proxmox Virtualization & Media Services Node  
**Platform:** Dell OptiPlex 7040  
**Operating System:** Proxmox VE 9.2  
**Host OS:** Debian GNU/Linux 13  
**Primary Storage:** 14 TB HDD + 256 GB NVMe SSD

## Overview

Prometheus is one of the three Proxmox VE virtualization nodes in my homelab
and serves as the primary host for my media-management infrastructure.

While Icarus hosts several general infrastructure and management services,
Prometheus is focused primarily on storage-intensive applications and
containerized media services.

---

## Hardware

| Component | Specification |
|---|---|
| **System** | Dell OptiPlex 7040 |
| **CPU** | Intel Core i7-6700 @ 3.40 GHz |
| **CPU Configuration** | 4 Cores / 8 Threads |
| **Memory** | 32 GB RAM |
| **Boot / VM Storage** | 256 GB Samsung NVMe SSD |
| **Bulk Storage** | 14 TB Western Digital HDD |
| **Virtualization Platform** | Proxmox VE 9.2 |
| **Host Operating System** | Debian GNU/Linux 13 |

---

## Storage

Prometheus uses two storage devices with different roles.

The **256 GB NVMe SSD** contains Proxmox and local virtual machine/container
storage, while the **14 TB Western Digital HDD** provides high-capacity storage
for media-related workloads.

This separates high-capacity data storage from the primary operating system
and virtualization storage.

---

## Virtualization

Prometheus uses Proxmox VE to host both virtual machines and LXC containers.

The media stack is divided into individual containers rather than running all
services directly on the Proxmox host. This allows each application to be
managed, updated, restarted, and troubleshot independently.

---

## Hosted Systems

Prometheus currently hosts one virtual machine and seven LXC containers.

### Virtual Machines

| VM | Resources | Purpose |
|---|---|---|
| **Kryptos** | 2 GB RAM / 32 GB Disk | Dedicated virtual machine |

### LXC Containers

| Container | Virtual Disk | Purpose |
|---|---:|---|
| **Dionysus** | 32 GB | Media service |
| **qBittorrent** | 16 GB | Download client |
| **Sonarr** | 4 GB | TV media management |
| **Radarr** | 4 GB | Movie media management |
| **Prowlarr** | 4 GB | Indexer management |
| **Bazarr** | 4 GB | Subtitle management |
| **FlareSolverr** | 4 GB | Supporting web-request service |

---

## Media Service Architecture

Rather than deploying the media environment as one large system, Prometheus
separates individual applications into dedicated containers.

This provides:

- Service isolation
- Independent application maintenance
- Individual resource allocation
- Easier troubleshooting
- Reduced impact when restarting or modifying a service
- Separation between the Proxmox host and application workloads

The services communicate across the internal network to form the complete
media-management environment.

---

## Role in the Cluster

Prometheus operates alongside:

- **Icarus**
- **Daedalus**

Together, these three systems form the primary Proxmox virtualization
environment in my homelab.

Prometheus specializes primarily in storage-intensive and media-related
workloads, while other infrastructure is distributed across the remaining
nodes.

---

## Skills & Experience

Building and maintaining Prometheus has given me hands-on experience with:

- Proxmox VE
- Debian Linux
- KVM virtualization
- LXC containers
- Large-capacity storage
- Linux permissions
- Application isolation
- Service-to-service networking
- Resource allocation
- Self-hosted application administration
- Multi-node infrastructure management

---

[← Back to Homelab Overview](../summary.md)
