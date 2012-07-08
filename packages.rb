dep 'packages' do
  requires { on :osx, 'homebrew' }

  requires [
    'ack.managed',
    'tig.managed',
    'tmux.managed',
    'tree.managed',
    'wget.managed'
  ]
end

dep 'ack.managed'

dep 'growlnotify.managed'

dep 'tig.managed'

dep 'tmux.managed'

dep 'tree.managed'

dep 'wget.managed'

dep 'rds-command-line-tools.managed' do
  provides 'rds'
end
