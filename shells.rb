meta :shell_setup do
  template {
    met? { '/etc/shells'.p.grep(which(basename)) }
    meet { append_to_file which(basename), '/etc/shells', :sudo => true }
  }
end

dep 'fish' do
  requires 'fish.shell_setup'
end

dep 'fish.shell_setup' do
  requires 'fishfish.managed'
end

dep 'fishfish.managed' do
  provides 'fish'
end

dep 'zsh', :username do
  username.default!(shell('whoami'))
  requires 'zsh.shell_setup'
  met? { shell("sudo su - '#{username}' -c 'echo $SHELL'") == which('zsh') }
  meet { sudo("chsh -s '#{which('zsh')}' #{username}") }
end

dep 'zsh.shell_setup' do
  requires 'zsh.bin'
end

dep 'zsh.bin'
