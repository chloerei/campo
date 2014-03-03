server '127.0.0.1', {
  user: 'vagrant',
  roles: %w{web app db},
  ssh_options: {
    port: 2222,
    keys: %w(~/.vagrant.d/insecure_private_key)
  }
}
