export DEBIAN_FRONTEND=noninteractive
echo "router1.sh script" > router1

sudo echo 1 > /proc/sys/net/ipv4/ip_forward

ip link set enp0s8 up

ip link add link enp0s8 name enp0s8.10 type vlan id 10
ip link add link enp0s8 name enp0s8.20 type vlan id 20

ip addr add 192.168.10.1/25 brd 192.168.10.63 dev enp0s8.10
ip addr add 192.168.20.1/23 brd 192.168.21.255 dev enp0s8.20

ip link set dev enp0s8.10 up
ip link set dev enp0s8.20 up

sudo ip route add 192.168.30.0/24 via 192.168.100.2 dev enp0s9 #rotta per rete "Subnet C"
