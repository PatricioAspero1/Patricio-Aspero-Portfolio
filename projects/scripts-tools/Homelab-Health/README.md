# Homelab Health & AI Briefing System

This project is a collection of Bash scripts used to monitor my homelab,
identify issues, perform limited automated recovery, and generate a daily
AI-assisted infrastructure briefing.

The scripts run on **Mnemosyne**, my local AI and automation virtual machine.

The system combines traditional infrastructure monitoring with a locally
hosted language model through Ollama.

---

## What It Checks

The current automation performs several scheduled checks.

### Cluster Health

The cluster-health script queries the Proxmox environment and records the
state of virtual machines and containers.

It also includes limited self-healing logic for selected services. If one of
the configured containers is stopped, the script can attempt to restart it
and verify the resulting state.

### Monitoring Infrastructure

The monitoring script checks services including:

- Prometheus
- Grafana
- Cloudflare Tunnel

This provides a quick indication of whether the core monitoring and remote
access infrastructure is responding.

### Application Health

The application-health script verifies selected services and can retrieve
basic application statistics through their APIs.

### System Updates

The update-checking script connects to selected Linux hosts and checks the
number of available package updates.

This allows pending maintenance to be summarized without manually logging
into every system.

### Storage Health

The storage check currently monitors:

- High-capacity storage on Prometheus
- ZFS pool health on Atlas

This provides an additional layer of visibility into storage availability
and potential issues.

---

## AI-Generated Morning Briefing

After the scheduled checks complete, the results are combined into a single
report.

Mnemosyne then sends the collected information to a locally hosted language
model through **Ollama**.

The model generates a concise morning briefing summarizing:

- Cluster health
- Service availability
- Pending updates
- Storage conditions
- Any detected issues
- Selected cybersecurity and technology news
- Weather information

The finished briefing can then be delivered through Discord.

---

## Architecture

```text
Proxmox Hosts ───────┐
Monitoring Services ─┤
Applications ────────┤
Storage Systems ─────┼────► Health Check Scripts
Linux Hosts ─────────┘               │
                                     ▼
                               Combined Logs
                                     │
                                     ▼
                                  Ollama
                                     │
                                     ▼
                               Local AI Model
                                     │
                                     ▼
                            Generated Briefing
                                     │
                                     ▼
                                  Discord
