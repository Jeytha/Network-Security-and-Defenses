#!/bin/bash
# update_containers.sh - Updates APT package lists inside the containers

echo "Updating hostA-10.9.0.5 (DMZ)..."
sudo docker exec -it hostA-10.9.0.5 bash -c "apt update"

echo "Updating host1-192.168.60.5 (Internal)..."
sudo docker exec -it host1-192.168.60.5 bash -c "apt update"

echo "Package updates complete."
