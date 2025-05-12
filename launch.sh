#!/bin/bash
# launch.sh - Launches all containers in detached mode

echo "Launching containers..."
sudo docker-compose up -d
echo "Containers launched."
