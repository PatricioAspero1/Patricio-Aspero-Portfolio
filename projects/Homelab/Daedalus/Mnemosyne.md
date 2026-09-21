# Mnemosyne

**Type:** Virtual Machine  
**Host:** Daedalus  
**Operating System:** Linux  
**Resources:** 8 vCPUs / 28 GB RAM / 600 GB SSD-backed Storage  
**Role:** Local AI, Automation & Homelab Intelligence

## Overview

Mnemosyne is a high-resource virtual machine dedicated to local AI inference,
homelab automation, infrastructure health analysis, and automated reporting.

It runs local large language models through **Ollama** and combines them with
custom monitoring and automation scripts to provide information about the
state of my homelab.

Rather than using the system solely as a local chatbot, I am developing
Mnemosyne as an experimental platform for integrating local AI with real
infrastructure administration.

Mnemosyne is the primary workload hosted by **Daedalus** and receives the
majority of that node's available compute and memory resources.

---

## Virtualization Configuration

Mnemosyne runs as a KVM virtual machine under Proxmox VE.

Its current configuration includes:

- 8 host-type vCPUs
- 28 GB RAM
- 600 GB SSD-backed virtual storage
- VirtIO networking
- VirtIO SCSI storage
- Q35 machine type
- UEFI (OVMF) firmware
- Proxmox firewall integration
- QEMU Guest Agent
- Automatic startup with the host

The VM receives most of Daedalus's available resources because local LLM
inference and the surrounding automation environment represent the node's
primary workload.

---

## Local AI

Mnemosyne uses **Ollama** to run large language models locally within my
homelab.

Models currently being tested include:

- Qwen 2.5 14B
- Llama 3.1 8B

A containerized **Open WebUI** instance provides a browser-based interface
for interacting with the locally hosted models.

Running inference locally gives me an environment for experimenting with:

- Local LLM deployment
- Model resource requirements
- AI service administration
- Model performance
- Prompt and tool integration
- AI-assisted infrastructure management

It also allows AI workloads to operate directly alongside my homelab
infrastructure without requiring every interaction to depend on an externally
hosted AI service.

---

## Homelab Health Automation

Mnemosyne runs a collection of custom scripts that collect operational
information from different parts of the homelab.

Current automated checks include:

- Proxmox cluster health
- Monitoring infrastructure status
- Application and service status
- Available system updates
- Disk and storage health

These checks allow information from multiple independent systems to be
collected in one location rather than requiring each host and service to be
manually inspected.

---

## Automated Briefings

Information gathered by the health-check scripts can be combined into a
centralized homelab briefing.

The goal is to provide a concise overview of the current state of the
environment and surface systems that may require attention.

This project gives me an opportunity to experiment with combining traditional
infrastructure monitoring and scripting with locally hosted AI models.

---

## Discord Integration

Mnemosyne also runs a custom Python Discord bot that provides another
interface to parts of the automation environment.

The Discord integration can be used to surface selected information and
interact with supported tools without requiring direct access to the
Mnemosyne command line.

This also provides a destination for automated infrastructure notifications
and alerts.

---

## Alert Integration

Mnemosyne runs an alert receiver that integrates with the broader monitoring
environment.

This allows monitoring events generated elsewhere in the homelab to be
received by Mnemosyne and incorporated into notification and automation
workflows.

The long-term goal is to move beyond simply reporting problems and begin
safely automating responses to well-understood, low-risk infrastructure
events.

---

## Technologies

Mnemosyne currently incorporates technologies including:

- Ollama
- Qwen
- Llama
- Open WebUI
- Docker
- Python
- Bash
- Linux
- Discord API
- REST APIs
- Proxmox VE
- Prometheus and Grafana integration
- Cron and scheduled automation

---

## Skills & Experience

Building Mnemosyne has given me hands-on experience with:

- Local LLM deployment
- AI infrastructure
- Linux system administration
- KVM virtualization
- Docker
- Python automation
- Bash scripting
- API integration
- Infrastructure monitoring
- Automated health checking
- Alerting and notification systems
- Resource management
- AI-assisted infrastructure operations

---

## Ongoing Development

Mnemosyne is an ongoing project and its architecture will continue to change
as I experiment with using local AI for infrastructure administration.

One current area of experimentation is model selection. The larger models
currently running on Mnemosyne provide greater capability but require
significant CPU and memory resources. I may move some automation tasks to
smaller, lower-parameter models where faster inference and lower resource
consumption are more valuable than maximum model capability.

Future development goals include:

- Evaluating smaller models for faster infrastructure-related tasks
- Expanding automated infrastructure health analysis
- Improving alert classification and summarization
- Creating additional tools that the local AI can safely invoke
- Automating selected maintenance tasks on non-critical VMs and services
- Assisting with routine software updates on non-critical systems
- Adding validation and approval controls before higher-impact actions
- Expanding integration with monitoring and alerting systems
- Generating and maintaining homelab documentation automatically
- Assisting with updates to this GitHub portfolio as the environment changes

For infrastructure changes, my goal is to use a controlled automation model
rather than provide the AI unrestricted administrative access. Automated
actions will initially focus on low-risk, non-critical systems, with logging,
validation, and human approval used where appropriate.

A future GitHub integration could allow Mnemosyne to generate updated
documentation when the homelab changes. Rather than directly publishing
changes without review, the system could generate commits or pull requests
containing proposed documentation updates that I can review before merging.

The long-term objective is to turn Mnemosyne into a locally hosted
infrastructure assistant that can **observe, analyze, document, recommend,
and eventually perform carefully controlled administrative tasks** throughout
the homelab.

---

[← Back to Daedalus](README.md)
