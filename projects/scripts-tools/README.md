# Scripts & Automation

This section highlights scripts, automation, and tooling I have built or
configured as part of my homelab and cybersecurity work.

Rather than listing programming languages by themselves, this section focuses
on how I use scripting to solve infrastructure problems, automate repetitive
work, monitor systems, and document my environment.

> **Learning & Development Note:**  
> Scripting and automation are areas I am actively developing my skills in.
> While building these projects, I use documentation, technical resources,
> Google, and AI-assisted guidance to help research unfamiliar concepts,
> troubleshoot problems, and improve my implementations.
>
> My goal is not simply to generate working scripts, but to understand how
> they work, test and modify them myself, and continue building the skills
> needed to design increasingly independent and reliable automation.

---

## Projects

### Homelab Health & AI Briefing

A collection of Bash scripts running on Mnemosyne that gathers health
information from across my infrastructure and prepares centralized homelab
briefings.

Current checks include cluster health, monitoring status, application health,
available updates, and disk health.

**Technologies:** Bash, Linux, Proxmox, Prometheus, Ollama, Cron

[View Homelab Health & AI Briefing →](Homelab-Health/README.md)

---

### Automated Network Discovery

A Python and Bash automation pipeline running on Clio that discovers devices,
classifies systems, processes network information, and generates topology data.

The workflow runs automatically and allows my network documentation to evolve
alongside the actual environment.

**Technologies:** Python, Bash, Nmap, Linux, Cron

[View Network Discovery →](Network-Discovery/README.md)

---

### Homelab Visualization Integration

The network-discovery pipeline also provides data used by my separate
interactive homelab visualization project.

The visualization itself is documented independently because it is a larger
application rather than only a script or automation workflow.

[View Homelab Visualization →](../Homelab-Visualization/README.md)

---

### Discord & Alert Integration

Python-based integrations running on Mnemosyne that provide infrastructure
notifications and another interface to selected homelab information.

This project connects monitoring events, custom automation, and Discord.

**Technologies:** Python, Discord API, REST APIs, systemd

[View Discord & Alert Integration →](Discord-Alerts/README.md)

---

### Backup Automation

Automated backup and recovery workflows covering both my Proxmox environment
and independently hosted infrastructure.

Proxmox workloads are backed up to Atlas automatically, while Tartarus uses a
separate system-imaging process for recovery.

**Technologies:** Proxmox, TrueNAS, NFS, Bash, Cron

[View Backup Automation →](Backup-Automation/README.md)

---

## Languages & Technologies

Across these projects, I am developing experience with:

- **Scripting:** Python, Bash, PowerShell
- **Web:** HTML, JavaScript
- **Infrastructure:** Linux, Proxmox VE, Docker, LXC, TrueNAS
- **Networking:** Nmap, WireGuard, DNS, routing and firewalling
- **Monitoring:** Prometheus, Grafana, Node Exporter
- **Automation:** Cron, systemd, REST APIs, Ollama

---

[← Back to Portfolio](../../README.md)
