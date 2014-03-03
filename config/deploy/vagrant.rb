server '192.168.33.10', {
  user: 'vagrant',
  roles: %w{web app db},
  ssh_options: {
    keys: %w(~/.vagrant.d/insecure_private_key)
  }
}
