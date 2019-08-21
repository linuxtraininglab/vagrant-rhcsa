# -*- mode: ruby -*-
# vi: set ft=ruby :
$MESSAGE = <<-MESSAGE
RHCSA LAB

To access the web interfaces of the lab add the following hosts file entry: 
192.168.5.100   ldap.rhcsa.lab yum.rhcsa.lab lab.rhcsa.lab

LDAP Server:    https://ldap.linux.lab
YUM Server:     http://yum.linux.lab
Task List:      http://lab.linux.lab
MESSAGE

Vagrant.configure("2") do |config|
  
  config.vm.define "ipa" do |ipa|
    ipa.vm.box = "linux-lab/ipa-server"
    ipa.vm.hostname = 'ldap.rhcsa.lab'
  
    ipa.vm.network "private_network", ip: "192.168.5.100"
    #ipa.vm.synced_folder ".", "/vagrant", disabled: true
    ipa.vm.post_up_message = $MESSAGE

    ipa.vm.provider :virtualbox do |vbox|
      vbox.customize ["modifyvm", :id, "--memory", 2048]
      vbox.customize ["modifyvm", :id, "--name", "RHCSA LAB - FreeIPA Server"]
    end
  end
  
  config.vm.define "server1" do |client|
    client.vm.box = "linux-lab/lab-server"
  
    client.vm.network "private_network", ip: "192.168.5.21", auto_config: false
    client.vm.synced_folder ".", "/vagrant", disabled: true
    
    # This will stop NetworkManager from adding entries to resolv.conf from DHCP
    client.vm.provision "shell", inline: "nmcli connection mod enp0s3 ipv4.ignore-auto-dns yes"

    client.vm.provider :virtualbox do |vbox|
      vbox.gui = true
      vbox.customize ["modifyvm", :id, "--memory", 1024]
      vbox.customize ["modifyvm", :id, "--name", "RHCSA LAB - Server 1"] 
    end
  end

end
