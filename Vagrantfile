# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
#

Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo Hello"

  config.vm.define "router1" do |router1|
    router1.vm.box = "ubuntu/focal64"
    router1.vm.hostname = "router1"
    router1.vm.network "private_network", ip: "192.168.57.10"  , netmask: 24
    router1.vm.network "private_network", ip: "192.168.59.30"  , netmask: 24
    router1.vm.network "private_network", ip: "192.168.60.50"  , netmask: 24
    router1.vm.provision "shell", path: "router1.sh", run: 'always'
    router1.vm.provider "virtualbox" do |v|
        v.memory = 512 
        v.cpus = 1
    end
  end

  config.vm.define "router2" do |router2|
    router2.vm.box = "ubuntu/focal64"
    router2.vm.hostname = "router2"
    router2.vm.network "private_network", ip: "192.168.58.10"  , netmask: 24
    router2.vm.network "private_network", ip: "192.168.59.40"  , netmask: 24
    router2.vm.network "private_network", ip: "192.168.61.50"  , netmask: 24
    router2.vm.provision "shell", path: "router2.sh", run: 'always'
    router2.vm.provider "virtualbox" do |v|
        v.memory = 512
        v.cpus = 1
    end
  end

  config.vm.define "server1" do |server1|
    server1.vm.box = "ubuntu/focal64"
    server1.vm.hostname = "server1"
    server1.vm.network "private_network", ip: "192.168.57.100" , netmask: 24
    server1.vm.provision "shell", path: "server1.sh", run: 'always'
    server1.vm.provider "virtualbox" do |v|
        v.memory = 512
        v.cpus = 1
    end
  end

  config.vm.define "server2" do |server2|
    server2.vm.box = "ubuntu/focal64"
    server2.vm.hostname = "server2"
    server2.vm.network "private_network", ip: "192.168.58.100" , netmask: 24
    server2.vm.provision "shell", path: "server2.sh", run: 'always'
    server2.vm.provider "virtualbox" do |v|
        v.memory = 512
        v.cpus = 1
    end
  end

  config.vm.define "client1" do |client1|
    client1.vm.box = "ubuntu/focal64"
    client1.vm.hostname = "client1"
    client1.vm.network "private_network", ip: "192.168.60.70" , netmask: 24
    client1.vm.provision "shell", path: "client1.sh", run: 'always'
    client1.vm.provider "virtualbox" do |v|
        v.memory = 512
        v.cpus = 1
    end
  end

  config.vm.define "client2" do |client2|
    client2.vm.box = "ubuntu/focal64"
    client2.vm.hostname = "client2"
    client2.vm.network "private_network", ip: "192.168.61.70" , netmask: 24
    client2.vm.provision "shell", path: "client2.sh", run: 'always'
    client2.vm.provider "virtualbox" do |v|
        v.memory = 512
        v.cpus = 1
    end
  end
end


#Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
#  config.vm.box = "ubuntu/focal64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
#end
