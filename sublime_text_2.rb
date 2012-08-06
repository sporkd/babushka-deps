dep 'Sublime Text 2' do
  # requires 'Sublime Text 2.app'
  requires 'Sublime configured'
  requires 'subl.cmd'
end

dep 'Sublime Text 2.app' do
  #TODO: Fix version error 
  source 'http://c758482.r82.cf2.rackcdn.com/Sublime Text 2.0.1.dmg'
end

dep 'Sublime configured' do
  # requires 'Sublime Text 2.app'

  def configs_dir
    "~/Library/Application Support/Sublime Text 2/Packages/User"
  end

  def configs_dir_escaped
    configs_dir.gsub(/([^\\]) /, '\1\\ ')
  end

  met? { "#{configs_dir}.backup".p.exists? }
  meet {
    log shell "cp -R #{configs_dir_escaped} #{configs_dir_escaped}.backup"
    log shell "cp -fp #{load_path.parent}/sublime_text_2/* #{configs_dir_escaped}"
  }
end

dep 'subl.cmd' do
  # requires 'Sublime Text 2.app'
  source "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"
end
