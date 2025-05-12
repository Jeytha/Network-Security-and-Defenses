Securing a Conceptualised E-Commerce Company - Luna Bags (LB)

Network Topology Overview

Luna Bags (LB) uses a segmented network architecture to enhance security and manage traffic effectively. The entire system is structured into three main zones: the external network (Internet), the DMZ (Demilitarized Zone), and the internal network.
All incoming traffic from the Internet first passes through the SEED Router, which also acts as a firewall. This device plays a critical role in filtering and controlling access between the zones. It ensures that only permitted traffic can reach sensitive areas of the network.

From the SEED Router, the network branches into two distinct segments:

DMZ Network (10.9.0.0/24):
This zone acts as a buffer between the public Internet and the internal network. It hosts public-facing services, such as the Apache web server, which is installed on IP address 10.9.0.5. The purpose of the DMZ is to provide services that need to be accessible from the outside while isolating these services from the company’s internal resources, thereby minimizing risk in the event of a compromise.

Internal Network (192.168.60.0/24):
This zone houses critical internal assets such as employee workstations, internal databases, and administrative tools. It is completely isolated from direct Internet access and can only be reached through controlled and secure channels like a VPN. This segmentation ensures that even if a service in the DMZ is compromised, attackers cannot directly access the internal systems.

This layered and segmented approach allows Luna Bags to contain potential threats, limit exposure, and enforce strict access controls between the different parts of the network. 
External Network: Hosts public-facing services accessed by customers and suppliers.
DMZ (Demilitarized Zone): Hosts the Apache web server. Segregated to reduce attack surface.
Internal Network: Houses sensitive resources like employee systems and databases. Fully isolated.

Lab Setup
Use only the SEED virtual machines provided by SEED Labs:
Intel CPU: Labsetup.zip
ARM CPU: Labsetup-arm.zip

Virtual machine downloads and detailed setup instructions:
https://seedsecuritylabs.org/labsetup.html

Key Implementations
1. Apache Web Server (10.9.0.5 - DMZ)
Hosted in the DMZ.

Serves external visitors via HTTP (port 80).

Verified using:
curl http://10.9.0.5
Web browser accessibility

2. VPN (OpenVPN)
Secure communication channel between DMZ and internal network.
TLS-based authentication using certificate-based login.
Static routing and NAT configured.

Deployed on SEED-ROUTER in host mode.
3. Intrusion Detection System (IDS) - Snort

Monitors:
Internet → DMZ
DMZ → Internal Network
HOME_NET: 192.168.60.0/24
EXTERNAL_NET: 10.9.0.0/24 + Internet

Alerts logged and sent to Splunk via syslog.

4. SIEM - Splunk
Aggregates logs from:
Apache Web Server
Internal hosts
Snort IDS
System and firewall logs
Syslog input (port 514) enabled.
Web dashboard provides real-time monitoring.

Firewall Configuration - iptables
Implemented on SEED-ROUTER

Verification Tools:
curl, ssh — Functional testing
nmap, netstat — Port scanning & connection tracking

Assumptions
No Telnet Usage: All remote access is through SSH.
Ephemeral Ports: Required for Docker and service communication.
Internal Network: Fully segmented, accessible only through VPN and firewalls.

Recommendations & Reflections
VPN
Strengths: Secure encrypted tunnel, bidirectional communication
Risks: Misconfigurations could expose internal assets.

Mitigations:
Use strong certificates
Enforce MFA
Monitor access logs continuously

Snort IDS
Strengths: Real-time threat detection
Risks: False positives, resource usage

Recommendations:
Tune rules
Update signatures regularly
Integrate with Splunk for alert triage

Splunk SIEM
Strengths: Centralized log analysis, correlation, visualization
Challenges: Storage overhead, complex setup

Recommendations:
Filter logs
Manage data retention
Ensure complete source coverage

Firewall
Strengths: Tight segmentation, limited exposure

Recommendations:
Regular rule audits
Remove unused services
Monitor logs for anomalies


