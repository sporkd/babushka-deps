dep 'mysql' do
  requires 'mysql.managed'
  requires 'mysql.launchd'
end

dep 'mysql.managed' do
  provides 'mysql'
end

dep 'mysql.launchd'
