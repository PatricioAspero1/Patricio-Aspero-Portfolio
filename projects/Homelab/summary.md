# Homelab

My homelab is a multi-system environment built to give me hands-on experience
with virtualization, networking, storage, Linux administration, monitoring,
security, and self-hosted infrastructure.

The environment has grown from individual systems into a small clustered
infrastructure built around three Proxmox virtualization hosts, dedicated
network storage, a Raspberry Pi providing supporting infrastructure, and
multiple virtual machines and containers.

The lab is continuously evolving as I experiment with new technologies,
services, security practices, and infrastructure designs.

---

## Infrastructure Overview

| System | Role | Platform |
|---|---|---|
| **Atlas** | Centralized storage | TrueNAS |
| **Icarus** | Virtualization Node | Proxmox VE |
| **Prometheus** | Virtualization / Media Node | Proxmox VE |
| **Daedalus** | Virtualization Node | Proxmox VE |
| **Tartarus** | Monitoring, DNS & Cluster Support | Raspberry Pi 4 |
| **Cisco SG350** | Network Switching | Managed Ethernet Switch |

---

## Proxmox Cluster

The core of the homelab consists of three Proxmox VE nodes:

- **Icarus**
- **Prometheus**
- **Daedalus**

Together, these systems provide the virtualization layer for the lab and host
the virtual machines and LXC containers that provide most of its services.

Using a clustered environment allows me to gain practical experience with
virtualization management, Linux administration, resource allocation,
networking, storage integration, monitoring, and troubleshooting across
multiple physical systems.

Each node has its own page documenting its hardware, configuration, role, and
hosted services.

---

## Atlas

**Atlas** is the lab's dedicated storage server and runs TrueNAS.

It provides centralized network storage used by other systems in the homelab,
including storage for services and Proxmox backups. Separating storage from
the virtualization hosts gives me experience working with dedicated network
storage and integrating storage services with virtualized infrastructure.

[View Atlas →](Atlas/Index)

---

## Icarus

**Icarus** is one of the three Proxmox VE virtualization nodes and hosts a
selection of virtual machines and containers used throughout the environment.

[View Icarus →](Icarus/Index)

---

## Prometheus

**Prometheus** is a Proxmox VE virtualization node with additional storage
capacity used heavily by the lab's media infrastructure.

Along with its role in the Proxmox cluster, it provides compute and storage
resources for several self-hosted services.

[View Prometheus →](Prometheus/Index)

---

## Daedalus

**Daedalus** is the third Proxmox VE virtualization node and provides additional
compute capacity for virtual machines and containers.

[View Daedalus →](Daedalus/Index)

---

## Tartarus

**Tartarus** is a Raspberry Pi 4 that provides several infrastructure services
independently of the primary virtualization cluster.

Its responsibilities include:

- Pi-hole DNS
- Prometheus monitoring
- Grafana visualization
- Proxmox cluster support

Keeping these services on a separate physical device allows important
infrastructure and monitoring capabilities to remain independent of the
virtualization hosts.

[View Tartarus →](Tartarus/Index)

---

## Network

The homelab currently operates on my local network with a **Cisco SG350 managed
switch** connecting the primary infrastructure.

At a high level, the physical network is:

Internet
   │
   ▼
Google Nest Gateway
   │
   ▼
Cisco SG350
   │
   ├── Atlas
   ├── Icarus
   ├── Prometheus
   ├── Daedalus
   ├── Tartarus

The Google Nest provides the network gateway, while the Cisco switch provides
wired connectivity between the lab systems.

The environment gives me a platform for experimenting with
network configuration, DNS, service communication, remote access, monitoring,
and security controls in a real multi-system network.

---

## Monitoring

Monitoring is provided primarily through **Prometheus and Grafana** running on
Tartarus.

This provides visibility into the health and performance of systems throughout
the homelab and gives me practical experience with infrastructure monitoring,
metrics collection, visualization, and troubleshooting.

---

## What I'm Learning

Building and maintaining this environment has provided hands-on experience with:

- Proxmox VE virtualization
- Virtual machines and LXC containers
- Linux system administration
- TrueNAS and network storage
- Network configuration and troubleshooting
- DNS and Pi-hole
- Prometheus and Grafana
- Raspberry Pi administration
- Backup infrastructure
- Remote administration
- Service deployment and troubleshooting
- Infrastructure security

---

> **Note:** This documentation intentionally omits credentials, authentication
> material, public endpoints, and other security-sensitive configuration.
