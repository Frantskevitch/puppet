# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provision "shell", path: "./puppet.sh"

  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "modules"
  end

  config.vm.define "puppet" do |puppet|
    puppet.vm.box = "centos/7"
    puppet.vm.hostname = "puppet"
    puppet.vm.network "private_network", ip: "192.168.56.50"
    puppet.vm.provider "virtualbox" do |vb|
      vb.name = "puppet_exit_cfg"
      vb.cpus = 1
      vb.memory = 2048
    end

  end

  config.vm.define "client" do |node|
    node.vm.box = "centos/7"
    node.vm.hostname = "client"
    node.vm.network "private_network", ip: "192.168.56.55"
    node.vm.provider "virtualbox" do |vb|
      vb.name = "client_cfg"
      vb.cpus = 1
      vb.memory = 2048
    end

  end
end

