Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
    vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    vb.customize ["modifyvm", :id, "--nicpromisc4", "allow-all"]
    vb.customize ["modifyvm", :id, "--nicpromisc5", "allow-all"]
    vb.cpus = 1
  end


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
end
