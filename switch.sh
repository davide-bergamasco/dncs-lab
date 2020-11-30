export DEBIAN_FRONTEND=noninteractive
echo "switch.sh script" > switch

apt-get update
apt-get install -y tcpdump
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common

ip link set enp0s8 up
ip link set enp0s9 up
ip link set enp0s10 up

ovs-vsctl add-br mybridge
ovs-vsctl add-port mybridge enp0s8
ovs-vsctl add-port mybridge enp0s9 tag=10
ovs-vsctl add-port mybridge enp0s10 tag=20
