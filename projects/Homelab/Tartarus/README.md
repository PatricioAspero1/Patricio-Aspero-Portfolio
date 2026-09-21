# Tartarus

**Role:** Independent Monitoring, DNS & Infrastructure Node  
**Platform:** Raspberry Pi  
**Operating System:** Raspberry Pi OS / Debian Linux  
**Architecture:** ARM64  
**Memory:** 2 GB RAM

## Overview

Tartarus is a Raspberry Pi that provides several core infrastructure services
for my homelab.

Unlike most of my services, Tartarus operates independently of the Proxmox
virtualization environment. This makes it useful for hosting services that I
want to remain available even when the primary virtualization nodes are
offline, restarting, or undergoing maintenance.

Its primary responsibilities include:

- Network-wide DNS through Pi-hole
- Infrastructure monitoring through Prometheus
- Monitoring visualization through Grafana
- Host-level metrics through Node Exporter
- Independent infrastructure monitoring
- Automated system backups to Atlas

---

## Why a Dedicated Raspberry Pi?

Many services in my homelab run as virtual machines or containers on
**Icarus**, **Prometheus**, and **Daedalus**.

Monitoring those systems exclusively from another VM inside the same
virtualization environment would create a dependency: if the virtualization
infrastructure failed, the monitoring platform could fail alongside the
systems it was supposed to monitor.

Tartarus provides a small, low-power physical system outside of that
environment.

This allows monitoring, DNS, and supporting infrastructure to remain
independent of the primary compute cluster.

---

## Pi-hole

Tartarus runs **Pi-hole** as a network DNS service.

Pi-hole provides centralized DNS functionality for devices within the
homelab while also allowing DNS requests and filtering behavior to be
observed and managed from a single location.

Running DNS on Tartarus keeps this service independent of the Proxmox
virtualization nodes.

### Experience

- DNS administration
- Pi-hole
- Network-wide DNS configuration
- Linux service administration
- Network troubleshooting

---

## Prometheus

Tartarus runs **Prometheus** as the primary metrics collection platform for
the homelab.

Prometheus collects metrics from supported systems and services throughout
the environment, including Linux systems using Node Exporter.

This provides centralized visibility into the health and performance of
systems distributed across the homelab.

### Monitored Infrastructure

The monitoring environment can collect information from systems including:

- Proxmox virtualization hosts
- Linux virtual machines
- LXC containers
- TrueNAS storage
- Infrastructure services

Prometheus provides the data collection layer while Grafana provides the
visualization layer.

---

## Grafana

**Grafana** runs alongside Prometheus on Tartarus and provides dashboards for
visualizing collected infrastructure metrics.

Dashboards allow me to monitor system information such as:

- CPU utilization
- Memory utilization
- Storage usage
- Host availability
- System performance
- Service health

Together, Prometheus and Grafana provide a centralized monitoring platform
for the broader homelab.

---

## Node Exporter

Tartarus also runs **Prometheus Node Exporter** so the monitoring server
itself can be monitored.

This allows Tartarus's own Linux system metrics to be collected alongside
metrics from the rest of the environment.

---

## Monitoring Architecture

At a high level, the monitoring environment operates like this:

```text
Icarus ──────────┐
Prometheus ──────┤
Daedalus ────────┤
Atlas ───────────┼────► Prometheus ────► Grafana
VMs / LXCs ──────┤        │
Clio ────────────┤        │
                 │        │
                 └────────┘
                      Tartarus
