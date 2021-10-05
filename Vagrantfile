# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-18.04"

  #Access to TFE
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 443, host: 443
  config.vm.network "forwarded_port", guest: 8800, host: 8800

  config.vm.provider "virtualbox" do |vb, override|
      # TFE Requirements
      vb.memory = 4096
      vb.cpus = 2
   end

  config.vm.provider "vmware_desktop" do |vb, override|
      # TFE Requirements
      vb.vmx["memsize"] = "4096"
      vb.vmx["numvcpus"] = "2"
  end

  #Install Terraform Enterprise
  config.vm.provision "shell", run: "once", inline: <<-SHELL
    #apt-get update
    #Allows Grub update to continue noninteractive
    #DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
    if [[ -f "/vagrant/config/license.rli" ]]
      then
        echo "License found.  Automating Install"
        echo "Creating App Dir"
        mkdir /tfe/app -p
        mkdir /tfe/snapshots -p
        echo "Copying replicated conf"
        cp /vagrant/config/replicated.conf /etc/replicated.conf
        apt-get update
        curl -s https://install.terraform.io/ptfe/stable | sudo bash
        apt-get install jq -y
        while ! curl -ksfS --connect-timeout 5 https://127.0.0.1/_health_check; do
          echo "Waiting for TFE to come up..."
          sleep 5
        done
        TOKEN=$(replicated admin --tty=0 retrieve-iact)
        PASS=$(jq ".DaemonAuthenticationPassword" /vagrant/config/replicated.conf)
        echo "Install complete..."
        echo "Console available: https://127.0.0.1:8800"
        echo "Console Password: ${PASS}"
        echo "TFE Login:  https://127.0.0.1/admin/account/new?token=${TOKEN}" 
      else
        echo "Performing manual install"  
        curl -s https://install.terraform.io/ptfe/stable | sudo bash
      fi
  SHELL
end
