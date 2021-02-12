export DEBIAN_FRONTEND=noninteractive
echo "hostb.sh script" > hostb

# sudo ip route add 192.168.100.0/30 via 192.168.20.1 dev enp0s8 #rotta per "Subnet D"
# sudo ip route add 192.168.10.0/25 via 192.168.20.1 dev enp0s8 #rotta per "Subnet A"
sudo ip route add 192.168.30.0/24 via 192.168.20.1 dev enp0s8 #rotta per "Subnet C"
