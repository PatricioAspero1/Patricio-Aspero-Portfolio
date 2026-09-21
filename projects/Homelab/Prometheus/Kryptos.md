# Kryptos

**Type:** Virtual Machine  
**Host:** Prometheus  
**Resources:** 2 vCPUs / 2 GB RAM / 32 GB Storage  
**Role:** WireGuard VPN Gateway

## Overview

Kryptos provides secure remote network access to my homelab using WireGuard.

The architecture uses an external cloud VPS as a publicly reachable WireGuard
endpoint while Kryptos provides connectivity between the encrypted VPN and
resources inside my homelab.

This design allows remote devices to securely access internal resources
without directly exposing the homelab's management interfaces to the Internet.

## Architecture

High-level traffic flow:

Remote Device
      │
      ▼
Cloud VPS
      │
      │ WireGuard
      ▼
Kryptos
      │
      ▼
Homelab Network

The environment supports multiple WireGuard peers and can be configured for
either access specifically to homelab resources or broader tunneled network
traffic depending on the client configuration.

## Networking

Building Kryptos required configuring and troubleshooting:

- WireGuard peers and key-based authentication
- IP forwarding
- Linux routing
- Policy routing
- NAT
- Firewall rules
- Split tunneling
- Full tunneling
- Remote LAN access

## Security

The VPN uses WireGuard's public-key authentication and encrypted tunnels to
provide remote connectivity.

Administrative interfaces remain on the internal network rather than being
directly exposed to the public Internet.

Public endpoints, internal addressing, VPN keys, and detailed firewall rules
are intentionally excluded from this portfolio.

## Skills & Experience

Kryptos has given me hands-on experience with:

- WireGuard
- Linux networking
- VPN architecture
- Cloud-hosted infrastructure
- Routing and IP forwarding
- NAT
- Firewall configuration
- Split tunneling
- Public/private network integration
- Remote-access troubleshooting

---

[← Back to Prometheus](README.md)
