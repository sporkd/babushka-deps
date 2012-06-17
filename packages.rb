dep 'packages' do
  requires {
    on :osx, 'homebrew'
  }

  requires 'ack.managed',
           'tig.managed',
           'tmux.managed',
           'tree.managed',
           'wget.managed',
           'imagemagick.managed',
           'mongodb.managed',
           'redis'
end

dep 'ack.managed'

dep 'growlnotify.managed'

dep 'imagemagick.managed' do
  provides 'convert'
end

dep 'redis', :template => 'managed' do
  provides 'redis-benchmark', 'redis-check-aof', 'redis-check-dump', 'redis-cli', 'redis-server'
end

dep 'sphinx.managed' do
  provides 'searchd'
end

dep 'rds-command-line-tools.managed' do
  provides 'rds'
end

dep 'mongodb.managed'

dep 'tig.managed'

dep 'tmux.managed'

dep 'tree.managed'

dep 'wget.managed'