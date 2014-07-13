# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.network :private_network, ip: '192.168.33.10'

  config.vm.synced_folder '.', '/vagrant', nfs: true

  # Fix postgresql default encoding
  config.vm.provision "shell", inline: <<-EOF
    update-locale LC_ALL="en_US.utf8"
    LC_ALL=en_US.UTF-8
  EOF
end
