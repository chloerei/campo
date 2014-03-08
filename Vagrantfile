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

  # Fix postgresql default encoding
  config.vm.provision 'shell', inline: 'update-locale LC_ALL="en_US.utf8"'

  config.vm.define 'dev', primary: true do |dev|
    dev.vm.hostname = 'vagrant-dev'
    dev.vm.network :private_network, ip: '192.168.33.10'
    dev.ssh.forward_agent = true

    # Use nfs for performance
    dev.vm.synced_folder '.', '/vagrant', type: 'nfs'

    # Install Dependency
    dev.vm.provision :shell, path: 'bin/setup.sh', args: '/vagrant', privileged: false
  end

  config.vm.define 'web' do |web|
    web.vm.hostname = 'vagrant-web'
    web.vm.network :private_network, ip: '192.168.33.20'

    web.vm.synced_folder '.', '/vagrant', disabled: true

    # Enable root login for cap provision task
    web.vm.provision :shell, inline: 'cp /home/vagrant/.ssh /root -r'
  end
end
