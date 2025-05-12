#!/bin/bash

echo "[+] Removing existing syslog output configuration from Snort..."
sudo sed -i '/^output log_syslog:/d' /etc/snort/snort.conf

echo "[+] Adding new syslog output configuration to Snort..."
echo 'output log_syslog: alert, log_alert_once, full_packet' | sudo tee -a /etc/snort/snort.conf

echo "[+] Restarting Snort service..."
sudo systemctl restart snort

echo "[+] Displaying recent Snort logs from syslog..."
sudo tail -n 20 /var/log/syslog | grep "Snort"




