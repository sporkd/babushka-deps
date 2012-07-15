dep 'Sublime Text 2' do
  requires 'subl.command'
end

dep 'Sublime Text 2.app' do
  #TODO: Fix version error 
  source 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.dmg'
end

dep 'subl.command' do
  # requires 'Sublime Text 2.app'
  target "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"
end
