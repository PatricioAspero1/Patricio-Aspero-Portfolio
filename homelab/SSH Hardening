# SSH Hardening Implementation

## Overview
Comprehensive security hardening of SSH access to my Proxmox homelab server, implementing enterprise-grade authentication and access controls to eliminate common attack vectors.

## Security Configuration

### SSH Server Configuration (`/etc/ssh/sshd_config`)
```bash
# Port Configuration
Port 1324                              # Non-standard port to reduce automated scans

# Authentication Hardening
PasswordAuthentication no              # Complete password disable
PermitRootLogin prohibit-password      # Root requires keys only
PubkeyAuthentication yes               # Enable public key authentication
PermitEmptyPasswords no                # No blank passwords
KbdInteractiveAuthentication no        # Disable challenge-response

# Cryptographic Settings
HostKey /etc/ssh/ssh_host_ed25519_key  # Prefer modern algorithms
HostKey /etc/ssh/ssh_host_rsa_key

# Session Security
ClientAliveInterval 300                # 5-minute timeout
ClientAliveCountMax 2                  # 2 keepalive messages
MaxAuthTries 3                         # Limit authentication attempts
LoginGraceTime 60                      # 1-minute login window

# Key Generation Process
Generate ED25519 keys (modern, secure)
ssh-keygen -t ed25519 -C "device_identifier" -f ~/.ssh/id_ed25519

Generate RSA fallback keys (4096-bit)
ssh-keygen -t rsa -b 4096 -C "device_identifier" -f ~/.ssh/id_rsa

# Multi-Device Access Control
Authorized Devices:
Linux Laptop (ssh-ed25519 AAA... linux_laptop)
Windows Laptop (ssh-ed25519 AAA... windows_laptop)
Home PC (ssh-ed25519 AAA... home_pc)

# File Permissions Security
chmod 700 /root/.ssh                   # Owner-only directory access
chmod 600 /root/.ssh/authorized_keys   # Owner-only key file access
chmod 600 /root/.ssh/id_*              # Private key protection
chmod 644 /root/.ssh/*.pub             # Public keys readable

# Brute Force Protection
Port obfuscation (1324 vs standard 22) reduces automated scanning
Password authentication disabled eliminates credential stuffing
MaxAuthTries limit prevents rapid authentication attempts
Fail2ban integration planned for automated IP blocking

# Firewall rules (planned)
ufw allow 1324/tcp comment "SSH Access"
ufw deny 22/tcp comment "Block default SSH"

# Successful key authentication
ssh -p 1324 root@192.168.100.2        # Should connect instantly

# Failed password attempt (expected)
ssh -o PreferredAuthentications=password -p 1324 root@192.168.100.2
# Expected: "Permission denied (publickey)"

# Port scanning simulation
nmap -p 1324 192.168.100.2            # Verify service listening
nmap -p 22 192.168.100.2              # Verify port 22 closed


## What I need to add and implement 

### Basic Log Monitoring
```bash
# Real-time authentication monitoring
tail -f /var/log/auth.log

# Systemd service monitoring  
journalctl -u ssh -f

# Failed authentication detection
grep "Failed password" /var/log/auth.log
grep "Invalid user" /var/log/auth.log

1. Fail2Ban Automated Protection
bash
# Install fail2ban
sudo apt update
sudo apt install fail2ban

# Configure SSH protection
sudo nano /etc/fail2ban/jail.local
Jail Configuration:

ini
[sshd]
enabled = true
port = 1324
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
findtime = 600


