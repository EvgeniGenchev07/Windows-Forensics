# INetSim Dummy Router for malware analysis script

This script sets up a **controlled fake network environment (dummy router + DNS server)**  for malware analysis, traffic simulation, and offline network emulation.

It can:
- Install required dependencies
- Configure a static network interface
- Redirect DNS traffic to a fake resolver
- Start a full INetSim service environment
- Restore normal network settings

---

# Warning

This tool modifies:
- Network interfaces
- Routing tables
- DNS resolver configuration (`/etc/resolv.conf`)
- System services (`systemd-resolved`, `dnsmasq`)

Use only in:
- Virtual machines
- Isolated lab environments
- Malware analysis sandboxes

---

# Features

## Install mode
Installs:
- INetSim
- Perl runtime
- Required DNS Perl modules
- CPAN Net-DNS 1.37 package (forced install)

---

## Start mode
Configures:
- Static IP on selected interface
- Default route (fake gateway setup)
- DNS redirection to local INetSim resolver
- Full INetSim service emulation:
    - DNS
    - IRC
    - NTP
    - Finger
    - Syslog
    - Echo / Chargen / Dummy services

---

## Stop mode
Restores:
- DHCP network configuration
- systemd-resolved
- dnsmasq
- NetworkManager services
- Removes static routes and IPs

---

#  Usage

## Make script executable
```bash
chmod +x configurator.sh
```
## Install dependencies
```bash
./configurator.sh install
```
## Start the service
```bash
./configurator.sh start
```
## Restore to default settings and stop the service
```bash
./configurator.sh stop
```