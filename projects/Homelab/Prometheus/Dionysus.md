# Dionysus

**Type:** LXC Container  
**Host:** Prometheus  
**Resources:** 4 vCPUs / 4 GB RAM  
**Role:** Plex Media Server

## Overview

Dionysus hosts Plex Media Server and provides the primary media-serving
component of my self-hosted media environment.

The container accesses dedicated bulk storage hosted by Prometheus through
a bind-mounted filesystem. This allows the application itself to remain
isolated inside an LXC container while large media files remain on separate
high-capacity storage.

## Architecture

Dionysus integrates with several independently hosted services on Prometheus
for media organization, metadata, subtitles, and library management.

Separating these components into individual containers allows each service
to be maintained and troubleshot independently.

## Skills & Experience

- Plex Media Server administration
- LXC containerization
- Linux filesystem permissions
- Bind mounts
- Large-capacity storage management
- Service integration
- Network application administration

---

[← Back to Prometheus](README.md)
