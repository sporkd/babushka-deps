dep 'packages' do
  requires { on :osx, 'homebrew' }

  requires [
    'grc.managed',
    'coreutils.managed',
    'ack.managed',
    'tig.managed',
    'tmux.managed',
    'tree.managed',
    'wget.managed',
    'phantomjs.managed'
  ]
end

dep 'grc.managed'

dep 'coreutils.managed' do
  provides 'gls', 'gcat', 'genv'
end

dep 'ack.managed'

dep 'tig.managed'

dep 'tmux.managed'

dep 'tree.managed'

dep 'wget.managed'

dep 'phantomjs.managed'
