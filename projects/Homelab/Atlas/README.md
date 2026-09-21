# Atlas

**Role:** Centralized Network Storage & Backup Infrastructure  
**Platform:** Dell OptiPlex 7040  
**Operating System:** TrueNAS  
**Storage:** 4 TB HDD + 500 GB NVMe Boot Drive

## Overview

Atlas is the dedicated storage server within my homelab. It runs TrueNAS
and provides centralized storage and backup services for systems throughout
the environment.

Separating storage from my Proxmox virtualization nodes allows persistent
data and backups to remain independent of the compute systems hosting my
virtual machines and containers.

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
| **Atlas Pool** | ~3.62 TiB | Primary homelab data and backup storage |
| **NVMe Boot Pool** | ~465 GiB | TrueNAS operating system |

The Atlas data pool is hosted on a dedicated 4 TB Western Digital hard drive,
while TrueNAS itself runs from a separate NVMe SSD.

Keeping the operating system and primary data storage on separate devices
allows the data drive to remain dedicated to homelab storage and backups.

---

## Role in the Homelab

Atlas serves as the centralized storage and backup layer for the broader
homelab.

Its responsibilities include:

- Centralized network storage
- Persistent storage for self-hosted services
- Storage accessible by other homelab systems
- Centralized Proxmox backup storage
- Tartarus system-image storage
- Separating persistent data and backups from virtualization compute resources

Atlas works alongside the three Proxmox virtualization nodes:

- **Icarus**
- **Prometheus**
- **Daedalus**

The Proxmox nodes primarily provide compute resources, while Atlas provides
dedicated storage and backup services.

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

## Backup Infrastructure

Atlas serves as the centralized backup destination for the homelab.

My Proxmox environment uses an automated scheduled backup job to store
backups of virtual machines and LXC containers on TrueNAS-backed storage.

The current backup policy:

- Runs automatically each day
- Covers workloads across the Proxmox environment
- Stores backups separately from the virtualization hosts
- Retains the five most recent backups

Maintaining multiple recovery points while automatically removing older
backups helps balance recovery options with available storage capacity.

### Tartarus Backups

Tartarus operates independently of Proxmox and therefore uses a separate
backup process.

Automated system images of Tartarus are stored on Atlas, providing a recovery
path if the Raspberry Pi's local storage fails or becomes corrupted.

Together, these systems allow Atlas to provide centralized backup storage for
both the virtualized infrastructure and supporting physical infrastructure.

---

## Security

Storage access is managed through TrueNAS permissions and network share
configuration.

Administrative interfaces and storage services are kept within the homelab
network rather than being directly exposed to the public Internet.

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
- Proxmox backup configuration
- Automated backup scheduling
- Backup retention policies
- Network backup targets
- System-image storage
- Recovery planning
- Integrating dedicated storage with virtualized infrastructure

---

[← Back to Homelab Overview](../summary.md)
