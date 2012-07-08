dep 'redis' do
  requires 'redis.managed'
  requires 'redis.launchd'
end

dep 'redis.managed' do
  provides 'redis-benchmark', 'redis-check-aof', 'redis-check-dump', 'redis-cli', 'redis-server'
end

dep 'redis.launchd'
