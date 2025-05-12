#!/bin/bash
# ping_test.sh - Tests ICMP connectivity between internal and DMZ networks

echo "📡 Sending ping from host1-192.168.60.5 to 10.9.0.5..."
sudo docker exec -it host1-192.168.60.5 bash -c "ping -c 4 10.9.0.5"
echo "Ping test complete."
