#!/bin/bash

# network_simulation.sh
# Sets up and runs the secure network simulation with Docker, including DMZ, Internal hosts, and Snort IDS.

echo "Building Docker images..."
sudo docker-compose build

echo "Launching containers..."
sudo docker-compose up -d

echo "Listing running containers..."
sudo docker ps

echo "Accessing DMZ host (10.9.0.5) to update packages..."
sudo docker exec -it hostA-10.9.0.5 bash -c "apt update && echo 'hostA package update complete.'"

echo "Accessing internal host (192.168.60.5) to test connectivity to DMZ..."
sudo docker exec -it host1-192.168.60.5 bash -c "ping -c 4 10.9.0.5"

echo "Starting Snort IDS in DMZ container (hostA-10.9.0.5)..."
sudo docker exec -it hostA-10.9.0.5 bash -c "snort -i eth0 -A console -q -c /etc/snort/snort.conf"

echo "Network simulation script complete."

