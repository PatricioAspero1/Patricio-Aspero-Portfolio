#!/usr/bin/env python3

import csv
import os
import subprocess
import xml.etree.ElementTree as ET

SUBNET = os.getenv("DISCOVERY_SUBNET", "192.168.1.0/24")
OUTPUT_CSV = os.getenv("DISCOVERY_OUTPUT", "discovered_devices.csv")


def run_nmap():
    """Run Nmap with OS and service detection and return XML output."""
    cmd = [
        "sudo",
        "nmap",
        "-sS",
        "-O",
        "-sV",
        "-T4",
        "--osscan-guess",
        "-oX",
        "-",
        SUBNET,
    ]

    try:
        print(f"Running Nmap scan against configured subnet: {SUBNET}")
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            check=True,
        )
        return result.stdout
    except subprocess.CalledProcessError as exc:
        print(f"Nmap failed: {exc}")
        print(exc.stderr)
        return None


def parse_nmap_xml(xml_data):
    """Extract device information from Nmap XML."""
    devices = []
    root = ET.fromstring(xml_data)

    for host in root.findall("host"):
        address = host.find('address[@addrtype="ipv4"]')
        if address is None:
            continue

        ip = address.get("addr", "")

        mac_elem = host.find('address[@addrtype="mac"]')
        mac = mac_elem.get("addr", "") if mac_elem is not None else ""
        vendor = mac_elem.get("vendor", "") if mac_elem is not None else ""

        hostname_elem = host.find("hostnames/hostname")
        hostname = hostname_elem.get("name", "") if hostname_elem is not None else ""

        ports = []
        for port in host.findall("ports/port"):
            state_elem = port.find("state")
            if state_elem is None or state_elem.get("state") != "open":
                continue

            portid = port.get("portid", "")
            protocol = port.get("protocol", "")
            service = port.find("service")
            service_name = service.get("name", "") if service is not None else ""

            ports.append(f"{portid}/{protocol} ({service_name})")

        os_elem = host.find("os/osmatch")
        os_name = os_elem.get("name", "") if os_elem is not None else ""

        devices.append(
            {
                "ip": ip,
                "mac": mac,
                "vendor": vendor,
                "hostname": hostname,
                "os": os_name,
                "ports": "; ".join(ports),
            }
        )

    return devices


def write_csv(devices):
    """Write discovered devices to CSV."""
    fieldnames = ["ip", "mac", "vendor", "hostname", "os", "ports"]

    with open(OUTPUT_CSV, "w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(devices)

    print(f"Discovered {len(devices)} devices; saved to {OUTPUT_CSV}")


def main():
    xml_data = run_nmap()
    if not xml_data:
        return

    devices = parse_nmap_xml(xml_data)
    write_csv(devices)

    for device in devices:
        label = device["hostname"] or device["vendor"] or "Unknown"
        print(f"{device['ip']} - {label}")


if __name__ == "__main__":
    main()
