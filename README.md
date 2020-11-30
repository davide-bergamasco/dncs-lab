# DNCS-LAB

This repository contains the Vagrant files required to run the virtual lab environment used in the DNCS course.
```


        +-----------------------------------------------------+
        |                                                     |
        |                                                     |eth0
        +--+--+                +------------+             +------------+
        |     |                |            |             |            |
        |     |            eth0|            |eth2     eth2|            |
        |     +----------------+  router-1  +-------------+  router-2  |
        |     |                |            |             |            |
        |     |                |            |             |            |
        |  M  |                +------------+             +------------+
        |  A  |                      |eth1                       |eth1
        |  N  |                      |                           |
        |  A  |                      |                           |
        |  G  |                      |                     +-----+----+
        |  E  |                      |eth1                 |          |
        |  M  |            +-------------------+           |          |
        |  E  |        eth0|                   |           |  host-c  |
        |  N  +------------+      SWITCH       |           |          |
        |  T  |            |                   |           |          |
        |     |            +-------------------+           +----------+
        |  V  |               |eth2         |eth3                |eth0
        |  A  |               |             |                    |
        |  G  |               |             |                    |
        |  R  |               |eth1         |eth1                |
        |  A  |        +----------+     +----------+             |
        |  N  |        |          |     |          |             |
        |  T  |    eth0|          |     |          |             |
        |     +--------+  host-a  |     |  host-b  |             |
        |     |        |          |     |          |             |
        |     |        |          |     |          |             |
        ++-+--+        +----------+     +----------+             |
        | |                              |eth0                   |
        | |                              |                       |
        | +------------------------------+                       |
        |                                                        |
        |                                                        |
        +--------------------------------------------------------+



```

# Requirements
 - Python 3
 - 10GB disk storage
 - 2GB free RAM
 - Virtualbox
 - Vagrant (https://www.vagrantup.com)
 - Internet

# How-to
 - Install Virtualbox and Vagrant
 - Clone this repository
`git clone https://github.com/fabrizio-granelli/dncs-lab`
 - You should be able to launch the lab from within the cloned repo folder.
```
cd dncs-lab
[~/dncs-lab] vagrant up
```
Once you launch the vagrant script, it may take a while for the entire topology to become available.
 - Verify the status of the 4 VMs
 ```
 [dncs-lab]$ vagrant status                                                                                                                                                                
Current machine states:

router                    running (virtualbox)
switch                    running (virtualbox)
host-a                    running (virtualbox)
host-b                    running (virtualbox)
```
- Once all the VMs are running verify you can log into all of them:
`vagrant ssh router`
`vagrant ssh switch`
`vagrant ssh host-a`
`vagrant ssh host-b`
`vagrant ssh host-c`

# Assignment
This section describes the assignment, its requirements and the tasks the student has to complete.
The assignment consists in a simple piece of design work that students have to carry out to satisfy the requirements described below.
The assignment deliverable consists of a Github repository containing:
- the code necessary for the infrastructure to be replicated and instantiated
- an updated README.md file where design decisions and experimental results are illustrated
- an updated answers.yml file containing the details of your project

## Design Requirements
- Hosts 1-a and 1-b are in two subnets (*Hosts-A* and *Hosts-B*) that must be able to scale up to respectively 62 and 362 usable addresses
- Host 2-c is in a subnet (*Hub*) that needs to accommodate up to 143 usable addresses
- Host 2-c must run a docker image (dustnic82/nginx-test) which implements a web-server that must be reachable from Host-1-a and Host-1-b
- No dynamic routing can be used
- Routes must be as generic as possible
- The lab setup must be portable and executed just by launching the `vagrant up` command

## Tasks
- Fork the Github repository: https://github.com/fabrizio-granelli/dncs-lab
- Clone the repository
- Run the initiator script (dncs-init). The script generates a custom `answers.yml` file and updates the Readme.md file with specific details automatically generated by the script itself.
  This can be done just once in case the work is being carried out by a group of (<=2) engineers, using the name of the 'squad lead'.
- Implement the design by integrating the necessary commands into the VM startup scripts (create more if necessary)
- Modify the Vagrantfile (if necessary)
- Document the design by expanding this readme file
- Fill the `answers.yml` file where required (make sure that is committed and pushed to your repository)
- Commit the changes and push to your own repository
- Notify the examiner (fabrizio.granelli@unitn.it) that work is complete specifying the Github repository, First Name, Last Name and Matriculation number. This needs to happen at least 7 days prior an exam registration date.

# Notes and References
- https://rogerdudler.github.io/git-guide/
- http://therandomsecurityguy.com/openvswitch-cheat-sheet/
- https://www.cyberciti.biz/faq/howto-linux-configuring-default-route-with-ipcommand/
- https://www.vagrantup.com/intro/getting-started/


# Design

## Network Topology

Here you can see the basic network topology of the virtual lab. A more detalied version of this topology is available on this repository (check out the `Network-Topology.png` file).

```

        +-----------------------------------------------------+
        |                                                     |
        |                                                     |enp0s3
        +--+--+                +------------+             +------------+
        |     |                |            |             |            |
        |     |          enp0s3|            |enp0s9 enp0s8|            |
        |     +----------------+  router-1  +-------------+  router-2  |
        |     |                |            |             |            |
        |     |                |            |             |            |
        |  M  |                +------------+             +------------+
        |  A  |                      |enp0s8                     |enp0s9
        |  N  |                      |                           |
        |  A  |                      |                           |enp0s8
        |  G  |                      |                     +-----+----+
        |  E  |                      |enp0s8               |          |
        |  M  |            +-------------------+           |          |
        |  E  |            |                   |           |  host-c  |
        |  N  +------------+      SWITCH       |           |          |
        |  T  |            |                   |           |          |
        |     |            +-------------------+           +----------+
        |  V  |               |enp0s9       |enp0s10             |enp0s3
        |  A  |               |             |                    |
        |  G  |               |             |                    |
        |  R  |               |enp0s8       |enp0s8              |
        |  A  |        +----------+     +----------+             |
        |  N  |        |          |     |          |             |
        |  T  |  enp0s3|          |     |          |             |
        |     +--------+  host-a  |     |  host-b  |             |
        |     |        |          |     |          |             |
        |     |        |          |     |          |             |
        ++-+--+        +----------+     +----------+             |
        | |                              |enp0s3                 |
        | |                              |                       |
        | +------------------------------+                       |
        |                                                        |
        |                                                        |
        +--------------------------------------------------------+



```

## Network specifications

This virtual lab contains four different subnets that are needed to accomplish the design requirements:


- Subnet-A : 192.168.10.0/25

```

  SubnetAddress: 192.168.10.0
  SubnetPrefixLength: 255.255.255.128
  CIDR Notation: /25
  RequiredAddresses: 62
  Number of Usable Hosts: 126
  Usable Host IP Range: (192.168.10.1 - 192.168.10.126)
  Broadcast Address: 192.168.10.127

```

- Subnet-B : 192.168.20.0/23

```

  SubnetAddress: 192.168.20.0
  SubnetPrefixLength: 255.255.254.0
  CIDR Notation: /23
  RequiredAddresses: 362
  Number of Usable Hosts:	510
  Usable Host IP Range: (192.168.20.1 - 192.168.21.254)
  Broadcast Address: 192.168.21.255

```


- Subnet-C : 192.168.30.0/24

```

  SubnetAddress: 192.168.30.0
  SubnetPrefixLength: 255.255.255.0
  CIDR Notation: /24
  RequiredAddresses: 143
  Number of Usable Hosts:	254
  Usable Host IP Range: (192.168.20.1 - 192.168.21.254)
  Broadcast Address: 192.168.21.255

  ```

- Subnet-D : 192.168.100.0/30

```

  SubnetAddress: 192.168.100.0
  SubnetPrefixLength: 255.255.255.0
  CIDR Notation: /30
  Number of Usable Hosts:	2
  Usable Host IP Range: (192.168.100.1 - 192.168.100.2)
  Broadcast Address: 192.168.100.3

```

Each of these subnets contains different hosts and different router's network interfaces. The lenght of the various netmasks depends on the number of usable addresses needed in each subnet.

In the case of `Subnet-A` it was also possible to use a /26 (255.255.255.192) netmask, which would have the required 62 usable addresses. Instead of the /26 I preferred choosing a /25 (255.255.255.127) netmask which has more free addresses. This is because one of the addresses must be used for the router's network interface. so with the /26 netmask only 61 IP addresses were free to use meanwhile with the /25 we still have 125 free IP addresses.
For all the other networks this issue does not occur.


## Virtual machines configurations

Every machine's configuration is implemented with the `Vagrantfile` and a machine specific startup script called `$machinename.sh`

### host-a

- `Vagrantfile`

```
# hosta:
config.vm.define "host-a" do |hosta|
  hosta.vm.box = "ubuntu/bionic64"
  hosta.vm.hostname = "host-a"
  hosta.vm.provision "shell", path: "hosta.sh"

  # enp0s8
  hosta.vm.network "private_network",
  virtualbox__intnet: "broadcast_host_a",
  ip: "192.168.10.2",
  mask: "255.255.255.192"

  hosta.vm.provider "virtualbox" do |vb|
    vb.memory = 256
  end
end
```

The creation and configuration of the network interface is done in the Vagrantfile. A static private IP address it's defined with its own netmask address.

- `hosta.sh`

```
export DEBIAN_FRONTEND=noninteractive
echo "hosta.sh script" > hosta

#sudo ip route add 192.168.100.0/30 via 192.168.10.1 dev enp0s8 #rotta per "Subnet D"
sudo ip route add 192.168.20.0/23 via 192.168.10.1 dev enp0s8 #rotta per "Subnet B"
sudo ip route add 192.168.30.0/24 via 192.168.10.1 dev enp0s8 #rotta per "Subnet C"
```



The first command is common for all the scripts, it simply activates the "non interactive" mode. You use this mode when you need zero interaction while installing via apt (It accepts the default answer for all questions).
The second line is also contained in every startup script, it creates a file with the name of the script. This is useful when all the machine are running because we can check that each machine has executed the correct script.
The last three lines are used to add the routes for the various subnets. The used syntax is :

sudo ip route add NET_ADDRESS via NEXT_HOP_ADDRESS dev INTERFACE_NAME

To reach all the machine that are in the subnet with "NET_ADDRESS" I have to send the packets towards the IP "NEXT_HOP_ADDRESS" through the network interface called "INTERFACE_NAME" of my machine.



### host-b

The configuration of this machine is the same of `host-a` with a different IP address.

- `Vagrantfile`

```
# hostb:
  config.vm.define "host-b" do |hostb|
    hostb.vm.box = "ubuntu/bionic64"
    hostb.vm.hostname = "host-b"
    hostb.vm.provision "shell", path: "hostb.sh"

    # enp0s8
    hostb.vm.network "private_network",
    virtualbox__intnet: "broadcast_host_b",
    ip: "192.168.20.2",
    mask: "255.255.254.0"

    hostb.vm.provider "virtualbox" do |vb|
      vb.memory = 256
    end
  end
```

- `hostb.sh`

```
export DEBIAN_FRONTEND=noninteractive
echo "hostb.sh script" > hostb

#sudo ip route add 192.168.100.0/30 via 192.168.20.1 dev enp0s8 #rotta per "Subnet D"
sudo ip route add 192.168.10.0/25 via 192.168.20.1 dev enp0s8 #rotta per "Subnet A"
sudo ip route add 192.168.30.0/24 via 192.168.20.1 dev enp0s8 #rotta per "Subnet C"

```

### host-c

The network configuration of this machine very similar to the configuration of `host-a` and `host-b`.


- `Vagrantfile`

```
# hostc:
  config.vm.define "host-c" do |hostc|
    hostc.vm.box = "ubuntu/bionic64"
    hostc.vm.hostname = "host-c"
    hostc.vm.provision "shell", path: "hostc.sh"

    # enp0s8
    hostc.vm.network "private_network",
    virtualbox__intnet: "broadcast_router-south-2",
    ip: "192.168.30.2",
    mask: "255.255.255.0"

    hostc.vm.provider "virtualbox" do |vb|
      vb.memory = 1000
    end
  end
```

- `hostc.sh`

```
export DEBIAN_FRONTEND=noninteractive
echo "hostc.sh script" > hostc

sudo ip route add 192.168.100.0/30 via 192.168.30.1 dev enp0s8 #rotta per rete "Subnet D"
sudo ip route add 192.168.10.0/25 via 192.168.30.1 dev enp0s8 #rotta per rete "Subnet A"
sudo ip route add 192.168.20.0/23 via 192.168.30.1 dev enp0s8 #rotta per rete "Subnet B"

#web server configuration

apt-get update
apt-get install -y docker.io

sudo docker pull dustnic82/nginx-test
sudo docker run -d -p 80:80 dustnic82/nginx-test

#apt-get install -y traceroute
```

This machine is running a docker image that implements a web server. With few commands we can set this up:

The first two lines after `#web server configuration` are used to install Docker. With `sudo docker pull dustnic82/nginx-test` we download the docker image from the docker repository and with `sudo docker run -d -p 80:80 dustnic82/nginx-test` we run this image, the option -d and -p are respectively used for running the container in background and mapping the port number 80 of the container to the same port number on our localhost.


### switch

- `Vagrantfile`

```
# switch:
config.vm.define "switch" do |switch|
  switch.vm.box = "ubuntu/bionic64"
  switch.vm.hostname = "switch"
  switch.vm.provision "shell", path: "switch.sh"

  #enp0s8
  switch.vm.network "private_network",
  virtualbox__intnet: "broadcast_router-south-1",
  auto_config: false

  #enp0s9
  switch.vm.network "private_network",
  virtualbox__intnet: "broadcast_host_a",
  auto_config: false

  #enp0s10
  switch.vm.network "private_network",
  virtualbox__intnet: "broadcast_host_b",
  auto_config: false

  switch.vm.provider "virtualbox" do |vb|
    vb.memory = 500
  end
end
```

- `switch.sh`

```
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
```

The switch configuration is different from the others. This because the switch is the only machine (in the lab) that does not work above the layer 2 of TCP/IP stack, so it's network interfaces don't have an IP address.
The interface `enp0s8` (which is connected to the virtualbox__intnet `broadcast_router-south-1` as the `router-1`) is setted in the TRUNK mode. It means that packets from every VLANs can be carried from this port.
The interfaces `enp0s9` and `enp0s10` are setted in the ACCESS mode on two different VLANs, so the traffic coming from one of these ports can not be maneged from another port with different VLAN tag.
In this way the broadcast domain it's divided in two, and all the machine that belong to the `Subnet_A` can reach the `Subnet_B` only through the `router-1`.If we want to completely separate the two networks it's sufficient to delete the specific `ip route add...` command from `hosta.sh` and `hostb.sh` before the `vagrant up` or entering `sudo ip route del 192.168.20.0/23 via 192.168.10.1 dev enp0s8` on `host-a` or `sudo ip route del 192.168.10.0/25 via 192.168.20.1 dev enp0s8`on `host-b` while the machines are running.

### router-2

- `Vagrantfile`

```
#router2:
config.vm.define "router-2" do |router2|
  router2.vm.box = "ubuntu/bionic64"
  router2.vm.hostname = "router-2"
  router2.vm.provision "shell", path: "router2.sh"

  #enp0s8
  router2.vm.network "private_network",
  virtualbox__intnet: "broadcast_router-inter",
  ip: "192.168.100.2",
  mask: "255.255.255.252"

  #enp0s9
  router2.vm.network "private_network",
  virtualbox__intnet: "broadcast_router-south-2",
  ip: "192.168.30.1",
  mask: "255.255.255.0"

  router2.vm.provider "virtualbox" do |vb|
    vb.memory = 500
  end
end
```

- `router2.sh`

```
export DEBIAN_FRONTEND=noninteractive
echo "router2.sh script" > router2

sudo echo 1 > /proc/sys/net/ipv4/ip_forward

sudo ip route add 192.168.10.0/25 via 192.168.100.1 dev enp0s8 #rotta per "Subnet A"
sudo ip route add 192.168.20.0/23 via 192.168.100.1 dev enp0s8 #rotta per "Subnet B"

```
This router has two network interfaces that are configered in the `Vagrantfile`. In the `router1.sh` script with the command `sudo echo 1 > /proc/sys/net/ipv4/ip_forward` it's enabled the ipv4 forwarding which by default it's disabled. With the last two lines of the script we add the route for the `Subnet_A` and `Subnet_B`. The route to the subnet in which the router already have an inteface in are setted by default.



### router-1

- `Vagrantfile`

```
#router1:
config.vm.define "router-1" do |router1|
  router1.vm.box = "ubuntu/bionic64"
  router1.vm.hostname = "router-1"
  router1.vm.provision "shell", path: "router1.sh"

  #enp0s8
  router1.vm.network "private_network",
  virtualbox__intnet: "broadcast_router-south-1",
  auto_config: false

  #enp0s9
  router1.vm.network "private_network",
  virtualbox__intnet: "broadcast_router-inter",
  ip: "192.168.100.1",
  mask: "255.255.255.252" #/30

  router1.vm.provider "virtualbox" do |vb|
    vb.memory = 500
  end
end
```

- `router1.sh`

```
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

```
