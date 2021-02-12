export DEBIAN_FRONTEND=noninteractive
echo "hosta.sh script" > hosta

# sudo ip route add 192.168.100.0/30 via 192.168.10.1 dev enp0s8 #rotta per "Subnet D"
# sudo ip route add 192.168.20.0/23 via 192.168.10.1 dev enp0s8 #rotta per "Subnet B"
sudo ip route add 192.168.30.0/24 via 192.168.10.1 dev enp0s8 #rotta per "Subnet C"
