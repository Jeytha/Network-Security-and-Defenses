
#!/bin/bash

echo "[+] Checking listening ports using netstat..."

# Check network settings inside each container
for host in host3-192.168.60.7 host2-192.168.60.6 hosta-10.9.0.5; do
    echo "[*] Entering $host to run netstat..."
    docker exec -it "$host" bash -c "netstat -tuln"
done

echo "[+] Configuring iptables firewall rules..."

# Block Telnet
sudo iptables -A INPUT -p tcp --dport 23 -j REJECT
sudo iptables -A OUTPUT -p tcp --sport 23 -j REJECT

# Allow HTTP
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT

# Allow SSH
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# Allow ephemeral ports (TCP/UDP high ports)
sudo iptables -A INPUT -p tcp --dport 32768:61000 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 32768:61000 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 32768:61000 -j ACCEPT
sudo iptables -A OUTPUT -p udp --sport 32768:61000 -j ACCEPT

echo "[+] Testing firewall rules..."

# Test web server
echo "[*] Testing HTTP access to 10.9.0.5..."
curl http://10.9.0.5

# Test SSH connectivity
echo "[*] Testing SSH access to 10.9.0.5..."
ssh root@10.9.0.5
