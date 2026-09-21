# Icarus

**Role:** Proxmox Virtualization Node  
**Platform:** Dell OptiPlex 7040  
**Operating System:** Proxmox VE 9.2  
**Host OS:** Debian GNU/Linux 13  
**Local Storage:** 1 TB SATA SSD

## Overview

Icarus is one of the three Proxmox VE virtualization nodes in my homelab.

It provides compute resources for virtual machines and LXC containers while
participating in the broader Proxmox environment alongside **Prometheus** and
**Daedalus**.

I use Icarus to gain hands-on experience with virtualization, Linux
administration, resource allocation, storage management, networking, and
self-hosted infrastructure.

---

## Hardware

| Component | Specification |
|---|---|
| **System** | Dell OptiPlex 7040 |
| **CPU** | Intel Core i7-6700 @ 3.40 GHz |
| **CPU Configuration** | 4 Cores / 8 Threads |
| **Memory** | 32 GB RAM |
| **Local Storage** | 1 TB Crucial MX500 SATA SSD |
| **Virtualization Platform** | Proxmox VE 9.2 |
| **Host Operating System** | Debian GNU/Linux 13 |

---

## Storage

Icarus uses a **1 TB Crucial MX500 SSD** as its primary local storage device.

The Proxmox installation uses LVM and LVM-thin storage to separate the host
operating system from storage allocated to virtual machines and containers.

Local storage includes:

- Proxmox host filesystem
- Swap space
- LVM-thin virtual machine storage
- Locally hosted VM and container disks

Persistent and shared storage can also be provided by **Atlas**, the dedicated
TrueNAS storage server in the homelab.

---

## Virtualization

Icarus runs **Proxmox VE**, allowing me to deploy and manage both:

- Virtual Machines
- LXC Containers

This provides hands-on experience with:

- VM and container provisioning
- CPU and memory allocation
- Virtual networking
- Virtual disk management
- Linux administration
- Service deployment
- Resource monitoring
- Troubleshooting virtualized systems

---

## Role in the Cluster

Icarus operates alongside:

- **Prometheus**
- **Daedalus**

Together, the three systems form the primary virtualization environment in my
homelab.

Separating workloads across multiple physical hosts gives me experience working
with distributed infrastructure instead of relying on a single virtualization
server.

---

## Security

Administrative access to Icarus is restricted to trusted systems and remote
access mechanisms within my homelab.

Security practices include:

- SSH-based administration
- Restricted administrative access
- Network-level access controls
- Separation between infrastructure and hosted services
- Regular system and package maintenance

Credentials, internal addresses, host identifiers, and other sensitive
configuration details are intentionally excluded from this portfolio.

---

## Skills & Experience

Working with Icarus has given me practical experience with:

- Proxmox VE
- Debian Linux
- KVM virtualization
- LXC containers
- LVM and LVM-thin storage
- Virtual networking
- Linux system administration
- Resource allocation
- VM and container troubleshooting
- Multi-node infrastructure management

---

## Hosted Systems

Icarus currently hosts two virtual machines and three LXC containers.

### Virtual Machines

| VM | Memory | Virtual Disk | Purpose |
|---|---:|---:|---|
| **Clio** | 8 GB | 50 GB | Homelab dashboard and management services |
| **Desktop** | 16 GB | 50 GB | General-purpose desktop environment |

### LXC Containers

| Container | Purpose |
|---|---|
| **Hermes** | VPN and remote-access services |
| **MineCraft** | Modded Minecraft server |
| **Vanilla** | Vanilla Minecraft server |

Each system is separated into its own VM or container, allowing services to
be independently managed, updated, restarted, and troubleshot without
affecting the Proxmox host or unrelated workloads.

---

[← Back to Homelab Overview](../summary.md)
