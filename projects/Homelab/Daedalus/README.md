
# Daedalus

**Role:** Proxmox Virtualization Node  
**Platform:** Dell OptiPlex 7040  
**Operating System:** Proxmox VE 9.2  
**Host OS:** Debian GNU/Linux 13  
**Local Storage:** 1 TB Samsung 870 EVO SSD

## Overview

Daedalus is one of the three Proxmox VE virtualization nodes in my homelab.

Unlike Icarus and Prometheus, which divide their resources among several
virtual machines and containers, Daedalus is primarily dedicated to a single
large virtual machine: **Mnemosyne**.

This allows the majority of the node's memory and storage resources to be
allocated to one workload while still retaining the management and
virtualization capabilities provided by Proxmox.

---

## Hardware

| Component | Specification |
|---|---|
| **System** | Dell OptiPlex 7040 |
| **CPU** | Intel Core i7-6700 @ 3.40 GHz |
| **CPU Configuration** | 4 Cores / 8 Threads |
| **Memory** | 32 GB RAM |
| **Local Storage** | 1 TB Samsung 870 EVO SATA SSD |
| **Virtualization Platform** | Proxmox VE 9.2 |
| **Host Operating System** | Debian GNU/Linux 13 |

---

## Storage

Daedalus uses a **1 TB Samsung 870 EVO SSD** for the Proxmox installation
and local virtual machine storage.

Proxmox uses LVM and LVM-thin storage to separate the host operating system
from storage allocated to virtual workloads.

A substantial portion of the local SSD is allocated to Mnemosyne.

---

## Virtualization

Daedalus currently hosts a single virtual machine.

| VM | Memory | Virtual Disk | Purpose |
|---|---:|---:|---|
| **Mnemosyne** | 28 GB | 600 GB | Dedicated high-resource virtual machine |

Dedicating most of the node's available resources to a single VM allows
Mnemosyne to operate with substantially more memory and local storage than
many of the smaller services distributed throughout the rest of the cluster.

---

## Role in the Cluster

Daedalus operates alongside:

- **Icarus**
- **Prometheus**

Together, the three physical systems form the primary Proxmox virtualization
environment in my homelab.

While Icarus and Prometheus host numerous independent services, Daedalus
provides a dedicated environment for a larger workload.

---

## Skills & Experience

Working with Daedalus provides hands-on experience with:

- Proxmox VE
- KVM virtualization
- Debian Linux
- LVM and LVM-thin storage
- Virtual machine provisioning
- Resource allocation
- Linux system administration
- Virtual networking
- Multi-node infrastructure management

---

[← Back to Homelab Overview](../summary.md)
