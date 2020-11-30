export DEBIAN_FRONTEND=noninteractive
echo "router2.sh script" > router2

sudo echo 1 > /proc/sys/net/ipv4/ip_forward

sudo ip route add 192.168.10.0/25 via 192.168.100.1 dev enp0s8 #rotta per "Subnet A"
sudo ip route add 192.168.20.0/23 via 192.168.100.1 dev enp0s8 #rotta per "Subnet B"
