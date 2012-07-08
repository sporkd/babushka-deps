dep 'mongodb' do
  requires 'mongodb.managed'
  requires 'mongodb.launchd'
end

dep 'mongodb.managed' do
  provides %w(mongo mongod)
end

dep 'mongodb.launchd'
