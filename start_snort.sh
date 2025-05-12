#!/bin/bash
# start_snort.sh - Launches Snort IDS inside the DMZ container

echo "Starting Snort on hostA-10.9.0.5..."
sudo docker exec -it hostA-10.9.0.5 bash -c "snort -i eth0 -A console -q -c /etc/snort/snort.conf"
