# Network-Security-and-Defenses
Providing network security for a conceptualised e-commerce company

Network Topology

The company has the network below. 192.168.60.0/24 is an internal network where many ‎employees need to access for internal services and customer database. 10.9.0.0/24 is the DMZ ‎where many public services are offered to LB’s customers. ‎

The virtual machine is available at https://seedsecuritylabs.org/labsetup.html. Other virtual ‎machines are not allowed. The Docker network setting file for this topology can be downloaded ‎from: ‎
‎(for Intel chip) https://seedsecuritylabs.org/Labs_20.04/Files/Firewall/Labsetup.zip .  ‎
‎(for ARM chip) https://seedsecuritylabs.org/Labs_20.04/Files/Firewall/Labsetup-arm.zip.‎

Luna Bags (LB) employs a segmented network topology for effective security and traffic management:

1. Apache Web Server Setup
Installed on 10.9.0.5 (DMZ).

Apache2 server default page confirmed operational via:

curl http://10.9.0.5

Browser-based testing.

1.1 External Network

Consists of public-facing services (website, supplier access).
Accessible to customers, suppliers, and external stakeholders.

1.2 Demilitarized Zone (DMZ)

Acts as a buffer zone between external and internal networks.
Hosts services like the Apache web server (IP: 10.9.0.5).
Limits attack vectors by preventing direct access to internal systems.

1.3 Internal Network

IP range: 192.168.60.0/24.
Contains critical company assets (employee workstations, databases, admin tools).
Protected by strict firewall rules to block unauthorized external access.

2. Executive Summary of Key Implementations

2.1 Apache Web Server

Installed in the DMZ to serve external website visitors.
Runs on port 80 for HTTP traffic.
Verified using curl and webpage availability.

2.2 Virtual Private Network (VPN)

Configured using OpenVPN with embedded certificates.
Enables encrypted TLS-based authentication between DMZ and internal network.
Static routing and NAT rules ensure bidirectional communication.
VPN traffic tunneled securely via SEED router using host mode.

2.3 Intrusion Detection System (IDS) - Snort

Deployed to monitor traffic across DMZ and internal network.

Traffic monitored:
From Internet to DMZ (web server).
From DMZ to Internal Network.
Integrated with Syslog and forwarded to Splunk for analysis.

2.4 SIEM Tool - Splunk

Installed and configured to collect logs from:
Apache Web Server (10.9.0.5).
Internal hosts (192.168.60.0/24).
Snort alerts.
Firewall logs and system logs.
Listens on port 514 (syslog) and provides real-time insights.

2.5 Firewall Policies (iptables)

Deployed on the SEED virtual machine to enforce segmentation and access control.

Key Rules:
Block port 23 (Telnet) - incoming and outgoing.
Allow port 80 (HTTP) - incoming and outgoing.
Allow port 22 (SSH) - incoming and outgoing.
Allow high ephemeral ports (32768–61000) for dynamic communications.

Verified via:
curl for HTTP access.
ssh command for remote login tests.
nmap and netstat for scanning open ports and active connections.

3. Technical Solutions

3.1 VPN Configuration

OpenVPN setup with:
Pre-configured .ovpn file including certificates.
Enabled IP forwarding for traffic routing.
Static routes added to route internal network traffic via VPN.
NAT rules ensured proper return traffic flow.
Router used: SEED-ROUTER (host mode) for direct VPN interface access.

3.2 Snort IDS

Configured to monitor:
DMZ ↔ External Network
DMZ ↔ Internal Network
Snort HOME_NET = 192.168.60.0/24
Snort EXTERNAL_NET = 10.9.0.0/24 and external IPs

Logging:
Alerts generated via Syslog.
Logs pushed to Splunk for analysis.

3.3 Splunk SIEM

Installed on a Linux server.

Configured to:
Accept syslog inputs.
Index logs from various sources (Snort, Apache, internal hosts).
Accessible via web interface.

Validated:
Timestamps, source IPs.
Real-time log viewing and correlation.

3.4 Firewall (iptables)

Tools Used:
nmap to scan open ports.
netstat to view active listening connections.

iptables Rules Summary:

Telnet (Port 23): Blocked both ways.
HTTP (Port 80): Allowed both ways.
SSH (Port 22): Allowed both ways.
High Ephemeral Ports (32768–61000): Allowed for container/service comms.

4. Assumptions
   
Telnet is deprecated and not used for remote access.
SSH is the only protocol used for secure remote administration.
Dynamic Ports are needed for communication between Docker containers and services.
Internal network is completely segmented from the public network via VPN and firewalls.

5. Recommendations and Reflections
5.1 VPN Configuration

Strengths:
Encrypted tunnel protects internal communications.
NAT and routing ensure seamless bidirectional traffic.

Risks: Misconfigured routing or credential misuse may expose internal systems.

Mitigations: 
Use strong certificate-based auth. 
Enforce MFA.
Rotate credentials regularly.
Monitor traffic and logs continuously.

5.2 Snort IDS

Strengths:
Real-time detection of malicious traffic.
Customizable rule sets.

Risks:
Performance issues in high-traffic environments.
Potential false positives.

Recommendations:
Regular rule set updates.
Threshold tuning to reduce noise.
Integrate with Splunk to prioritize alerts.

5.3 Splunk SIEM

Strengths:
Centralized log collection and analysis.
Advanced data correlation and visualization.

Challenges:
High storage and indexing requirements.
Complex initial setup.

Recommendations:
Plan data retention carefully.
Use filters and parsing rules.
Ensure all critical sources are configured to log to Splunk.

5.4 Firewall Policies

Strengths:
Restrictive policy minimizes attack surface.
Only essential services allowed.

Recommendations:
Review rules regularly for compliance and least privilege.
Monitor logs for blocked traffic attempts.
Disable unused services to reduce vulnerabilities.





