# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.provider :virtualbox do |vb|
     # Don't boot with headless mode
     # vb.gui = true

     # Use VBoxManage to customize the VM. For example to change memory:
     vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.define 'dev' do |dev|
    config.vm.network :private_network, ip: '192.168.33.10'

    # Install Dependency
    config.vm.provision :shell, path: 'bin/setup.sh', args: '/vagrant', privileged: false
  end

  config.vm.define 'web' do |dev|
    config.vm.network :private_network, ip: '192.168.33.11'

    # Enable root login for cap provision task
    config.vm.provision :shell, inline: 'cp /home/vagrant/.ssh /root -r'
  end
end
