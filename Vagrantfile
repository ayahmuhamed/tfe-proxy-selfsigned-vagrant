agrant.configure("2") do |config|
    config.vm.define vm_name="tfe" do |tfe|
      tfe.vm.box = "vivien/bionic64"
      tfe.vm.hostname = "tfe"
      tfe.vm.network "private_network", ip: "192.168.50.10"
      tfe.vm.provision "shell", path: "scripts/install-tfe.sh", privileged: true
      tfe.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", "4096"]
        v.customize ["modifyvm", :id, "--cpus", "2"]
    end
  end
end
