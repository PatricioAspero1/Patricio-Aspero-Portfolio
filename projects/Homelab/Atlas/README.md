# Atlas

**Role:** Centralized Network Storage  
**Platform:** Dell OptiPlex 7040  
**Operating System:** TrueNAS  
**Storage:** 4 TB HDD + 500 GB NVMe Boot Drive

## Overview

Atlas is the dedicated storage server within my homelab. It runs TrueNAS
and provides centralized storage for systems and services throughout the
environment.

Separating storage from my Proxmox virtualization nodes allows 
data to remain independent of the compute systems hosting my virtual
machines and containers.

---

## Hardware

| Component | Specification |
|---|---|
| **System** | Dell OptiPlex 7040 |
| **CPU** | Intel Core i7-6700 @ 3.40 GHz |
| **CPU Configuration** | 4 Cores / 8 Threads |
| **Memory** | 32 GB DDR4 |
| **Boot Drive** | 500 GB Crucial P310 NVMe SSD |
| **Data Drive** | 4 TB Western Digital HDD |
| **Storage Technology** | ZFS |
| **Operating System** | TrueNAS |

---

## Storage Architecture

Atlas uses **ZFS through TrueNAS** to manage its storage.

### Storage

| Storage | Capacity | Purpose |
|---|---:|---|
| **Atlas Pool** | ~3.62 TiB | Primary homelab data storage |
| **NVMe Boot Pool** | ~465 GiB | TrueNAS operating system |

The current Atlas data pool is hosted on a dedicated 4 TB Western Digital
hard drive, while TrueNAS itself runs from a separate NVMe SSD.

Keeping the operating system and primary data storage on separate devices
allows the storage drive to remain dedicated to homelab data.

---

## Role in the Homelab

Atlas serves as the centralized storage layer for the broader homelab.

Its responsibilities include:

- Centralized network storage
- Persistent storage for self-hosted services
- Storage accessible by other homelab systems
- Backup storage
- Separating persistent data from virtualization compute resources

Atlas works alongside the three Proxmox virtualization nodes:

- **Icarus**
- **Prometheus**
- **Daedalus**

The Proxmox nodes primarily provide compute resources, while Atlas provides
dedicated storage services.

---

## TrueNAS & ZFS

TrueNAS provides the storage management layer for Atlas and gives me
hands-on experience working with:

- ZFS storage pools
- Datasets
- Network shares
- Storage permissions
- User and group access
- Storage monitoring
- Network storage integration

---

## Security

Storage access is managed through TrueNAS permissions and network share
configuration.

Administrative interfaces and storage services are kept within the
homelab network rather than being directly exposed to the public Internet.

Credentials, authentication material, device serial numbers, internal
addresses, and other security-sensitive configuration are intentionally
excluded from this portfolio.

---

## Skills & Experience

Building and maintaining Atlas has given me practical experience with:

- TrueNAS administration
- ZFS
- Network-attached storage
- Storage management
- Network file sharing
- Linux command-line administration
- Permissions and access control
- Backup storage
- Integrating dedicated storage with virtualized infrastructure

---

[← Back to Homelab Overview](../summary.md)
