dep 'ssh keys', :ssh_dir, :ssh_password do
  ssh_dir.ask("Where do you keep your ssh keys").default('~/.ssh')

  met? {
    (ssh_dir / 'id_rsa.pub').exists? && (ssh_dir / 'id_rsa').exists?
  }
  prepare {
    ssh_password.ask("What passphrase do you want to encrypt your SSH keys with")
  }
  meet {
    shell "ssh-keygen -t rsa -N #{ ssh_password } -f #{ ssh_dir }/id_rsa"
  }
end
