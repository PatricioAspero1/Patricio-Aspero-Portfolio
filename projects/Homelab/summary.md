# Homelab

My homelab is a multi-system environment built for hands-on experience with
virtualization, networking, storage, Linux administration, monitoring,
automation, security, and self-hosted infrastructure.

What began as a few individual systems has grown into a three-node Proxmox
virtualization environment supported by dedicated network storage, independent
monitoring and DNS infrastructure, centralized networking, secure remote-access
systems, and a growing collection of virtual machines and containers.

The environment is continuously evolving as I experiment with new technologies,
automation, infrastructure designs, and security practices.

---

## Physical Homelab

![Physical Homelab Rack](projects/Homelab/images/Homelab-Picture.jpeg)

*My physical homelab rack containing the systems that support the environment
documented throughout this portfolio. The rack includes my Proxmox
virtualization nodes, TrueNAS storage server, managed networking equipment,
Raspberry Pi infrastructure, and UPS-backed power.*

---

## Infrastructure Overview

| System | Role | Platform |
|---|---|---|
| **Atlas** | Centralized Storage | TrueNAS |
| **Icarus** | Virtualization & Infrastructure Services | Proxmox VE |
| **Prometheus** | Virtualization, Media & Network Services | Proxmox VE |
| **Daedalus** | AI & Automation Virtualization Node | Proxmox VE |
| **Tartarus** | Monitoring, DNS & Independent Infrastructure | Raspberry Pi |
| **Cisco SG350** | Network Switching | Managed Ethernet Switch |

The infrastructure is intentionally divided across multiple physical systems
rather than placing every service on a single server. This gives me practical
experience managing dependencies between compute, storage, networking,
monitoring, and application services.

---

# Architecture

At a high level, the environment is structured around a managed network
connecting dedicated infrastructure systems.

```text
                         Internet
                            │
                            ▼
                    Google Nest Gateway
                            │
                            ▼
                      Cisco SG350
                    Managed Switch
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
          ▼                 ▼                 ▼
       Atlas             Tartarus            Proxmox Cluster
      TrueNAS           Raspberry Pi               │
      Storage          DNS/Monitoring    ┌─────────┼─────────┐
                                         │         │         │
                                         ▼         ▼         ▼
                                      Icarus  Prometheus   Daedalus
                                                          
```

The network supports communication between physical hosts, virtual machines,
LXC containers, storage services, monitoring infrastructure, and remote-access
systems.

---

# Proxmox Virtualization Environment

The primary compute layer consists of three Proxmox VE nodes:

- **Icarus**
- **Prometheus**
- **Daedalus**

All three currently run Proxmox VE 9.2 on Debian 13 and provide the
virtualization platform for most of the homelab.

Rather than giving every node the same purpose, workloads are distributed
according to their role and resource requirements.

### Icarus

Icarus hosts general infrastructure, management, network-discovery, and
remote-access services.

Notable workloads include:

- **Clio** — Automated network discovery, classification, and visualization
- **Hermes** — Cloudflare Tunnel and remote-access infrastructure
- **Desktop** — Fallback Ubuntu administrative environment
- Dedicated game-server containers

[Explore Icarus →](Icarus/README.md)

### Prometheus

Prometheus combines virtualization with high-capacity local storage and hosts
several interconnected application and networking services.

Notable workloads include:

- **Kryptos** — WireGuard VPN gateway
- **Dionysus** — Plex Media Server
- Containerized application-management services
- qBittorrent
- Sonarr
- Radarr
- Prowlarr
- Bazarr
- FlareSolverr

[Explore Prometheus →](Prometheus/README.md)

### Daedalus

Daedalus is primarily dedicated to **Mnemosyne**, a high-resource virtual
machine used for local AI, infrastructure analysis, and automation.

Mnemosyne combines locally hosted large language models with custom scripts,
monitoring information, automated health checks, alerting, and reporting.

Future development is focused on safely extending this platform into
AI-assisted infrastructure administration.

[Explore Daedalus →](Daedalus/README.md)

---

# Storage — Atlas

**Atlas** is the dedicated storage server for the environment.

It runs **TrueNAS** on a Dell OptiPlex 7040 and uses ZFS to provide centralized
storage independently of the Proxmox virtualization hosts.

Current hardware includes:

- Intel Core i7-6700
- 32 GB DDR4 RAM
- 500 GB NVMe boot drive
- 4 TB dedicated data drive
- TrueNAS / ZFS

Separating storage from compute gives me experience managing network storage,
datasets, permissions, backups, and integration between dedicated storage and
virtualized infrastructure.

[Explore Atlas →](Atlas/README.md)

---

# Independent Infrastructure — Tartarus

**Tartarus** is a Raspberry Pi that hosts infrastructure services independently
of the Proxmox cluster.

Its primary responsibilities include:

- **Pi-hole** — Network DNS
- **Prometheus** — Metrics collection
- **Grafana** — Monitoring dashboards
- **Node Exporter** — Linux host metrics
- Automated backups to Atlas

Keeping monitoring and DNS outside the primary virtualization environment
reduces the chance that a virtualization failure also takes down the systems
used to observe and troubleshoot that failure.

Tartarus is also being evaluated as an independent emergency remote-access
system, further reducing reliance on the primary virtualization environment.

[Explore Tartarus →](Tartarus/README.md)

---

# Networking

The physical infrastructure is connected through a **Cisco SG350 managed
Ethernet switch**, with a Google Nest system currently providing the network
gateway.

The network connects:

- Three Proxmox hosts
- TrueNAS storage
- Raspberry Pi infrastructure
- Virtual machines
- LXC containers
- Monitoring services
- Remote-access infrastructure
- Client devices

Building the environment has given me practical experience troubleshooting
communication across physical hosts, virtual networks, containers, storage
systems, and application services.

---

# Remote Access

Remote administration is intentionally handled through multiple systems rather
than depending entirely on one access method.

## Kryptos

Kryptos provides WireGuard-based remote network access through an external
cloud endpoint.

This project has given me experience with:

- WireGuard
- VPN architecture
- Linux routing
- IP forwarding
- NAT
- Firewall rules
- Split tunneling
- Cloud-to-homelab networking

## Hermes

Hermes hosts Cloudflare Tunnel infrastructure for selected web-based services.

This allows specific applications to be accessed through controlled tunnels
without directly exposing their internal service ports to the Internet.

## Desktop

Icarus also hosts an Ubuntu Desktop VM that serves as a fallback administrative
environment when my normal VPN-based management workflow is unavailable or
impractical.

Together, these systems provide multiple approaches to remote administration
while allowing me to experiment with different secure-access architectures.

---

# Monitoring

Monitoring is centralized on **Tartarus** using Prometheus and Grafana.

Systems throughout the homelab expose metrics that can be collected and
visualized centrally.

```text
Icarus ───────────┐
Prometheus ───────┤
Daedalus ─────────┤
Atlas ────────────┼────► Prometheus ────► Grafana
VMs / LXCs ───────┤          │
Clio ─────────────┘          │
                             ▼
                          Tartarus
```

This provides visibility into infrastructure health and gives me practical
experience with:

- Metrics collection
- Infrastructure monitoring
- Dashboard creation
- Linux exporters
- Service health monitoring
- Troubleshooting distributed systems

---

# Network Discovery & Visualization

**Clio** is an Ubuntu virtual machine dedicated to automated network discovery
and visualization.

Custom scripts periodically discover systems on the network, classify detected
devices, process the resulting information, and generate updated visualizations
of the environment.

Clio also hosts my custom interactive homelab visualization and additional
network-discovery tooling.

This project combines:

- Python
- Nmap
- Linux
- Network discovery
- Automated device classification
- Data processing
- HTML / JavaScript visualization
- Scheduled automation
- Monitoring integration

[Explore Clio →](Icarus/Clio.md)

---

# AI & Automation

**Mnemosyne** is my experimental local AI and infrastructure-automation system.

It runs local language models through Ollama and combines them with custom
scripts that collect information about the homelab.

Current functionality includes checks for:

- Cluster health
- Monitoring status
- Application status
- Available updates
- Disk health

The collected information can be used to generate centralized infrastructure
briefings and notifications.

Future development will explore controlled AI-assisted administration,
including low-risk maintenance, documentation generation, and proposed GitHub
portfolio updates with human review before changes are published.

[Explore Mnemosyne →](Daedalus/Mnemosyne.md)

---

# Backup & Recovery

Backup and recovery are built into the homelab rather than being handled
individually by each service.

## Proxmox Backups

The Proxmox environment uses a centralized scheduled backup job that backs up
virtual machines and LXC containers from the virtualization environment to
storage hosted by **Atlas**, my TrueNAS server.

The current backup policy includes:

- Automated daily backups
- Centralized TrueNAS backup storage
- Coverage across the Proxmox environment
- Retention of the five most recent backups
- Separation of backup storage from the virtualization hosts

At a high level:

```text
             Icarus ────────┐
                             │
          Prometheus ────────┼────► Scheduled Proxmox Backups
                             │                │
            Daedalus ────────┘                ▼
                                          Atlas
                                         TrueNAS
                                            │
                                            ▼
                                      Backup Storage

---

# What I'm Learning

Building and maintaining the environment has provided hands-on experience with:

### Virtualization & Systems
- Proxmox VE
- KVM virtual machines
- LXC containers
- Debian and Ubuntu Linux
- Raspberry Pi / ARM Linux
- Resource allocation
- LVM and LVM-thin storage

### Networking & Security
- TCP/IP networking
- WireGuard
- VPN architecture
- Cloudflare Tunnels
- DNS
- Linux routing
- NAT
- Firewall configuration
- Remote administration
- Network troubleshooting

### Storage & Recovery
- TrueNAS
- ZFS
- Network-attached storage
- NFS
- Linux filesystem permissions
- Backup automation
- System imaging
- Recovery planning

### Monitoring & Automation
- Prometheus
- Grafana
- Node Exporter
- Python
- Bash
- Cron
- REST APIs
- Infrastructure health checks
- Automated reporting

### AI Infrastructure
- Ollama
- Local LLM deployment
- Open WebUI
- Docker
- AI-assisted infrastructure analysis
- Automation design

---

# Ongoing Development

This homelab is an ongoing project rather than a finished environment.

I regularly modify the architecture as I learn new technologies, encounter
limitations, or identify better ways to design and manage the infrastructure.

Current and future areas of development include:

- Expanding infrastructure automation
- Improving backup and recovery
- Further developing automated network discovery
- Improving the custom homelab visualization
- Experimenting with local AI for infrastructure administration
- Evaluating smaller AI models for faster automation tasks
- Automating selected maintenance on non-critical systems
- Improving independent emergency remote access
- Automatically generating infrastructure documentation
- Integrating homelab changes with this GitHub portfolio

The goal of the environment is not simply to keep services running, but to
provide a continually evolving platform where I can design, break,
troubleshoot, rebuild, secure, and automate real systems.

---

> **Security Note:** Public documentation intentionally omits credentials,
> authentication material, internal IP addressing, public endpoints, hardware
> identifiers, API tokens, VPN keys, and other security-sensitive
> configuration.
