#!/bin/bash

# Start OpenVPN client with specified config
echo "[+] Starting OpenVPN client..."
sudo openvpn vpnbook-ca198-udp25000.ovpn &

# Wait for VPN to establish (you may need to adjust sleep duration)
sleep 15

# Enable IPv4 forwarding
echo "[+] Enabling IP forwarding..."
echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Add static route to internal network via VPN tunnel interface (tun2)
echo "[+] Adding route to internal network 192.168.60.0/24 via 10.10.0.1 (tun2)..."
sudo ip route add 192.168.60.0/24 via 10.10.0.1 dev tun2

# Apply NAT using iptables for DMZ to internal network traffic
echo "[+] Setting up NAT masquerade rule for traffic from 10.9.0.0/24 to 192.168.60.0/24..."
sudo iptables -t nat -A POSTROUTING -s 10.9.0.0/24 -d 192.168.60.0/24 -o tun2 -j MASQUERADE

# Launch Docker container for the seed-router with host networking
echo "[+] Launching seed-router Docker container with host networking..."
docker run --name seed-router --network host -it seed-router-image bash

# (Optional) ICMP Traffic Capture (Run in separate terminal if needed)
# sudo tcpdump -i tun2 icmp

# (Optional) Test Ping to Internal Host
ping 192.168.60.5

Ensure the interface name tun2 and next-hop IP 10.10.0.1 are correct and exist after VPN connection.
The sleep 15 can be adjusted based on how long your VPN takes to establish.
