dep 'Sublime Text 2' do
  requires 'Sublime Text 2.app'
  requires 'Sublime Text 2 theme.cloned'
  requires 'Sublime Text 2 preferences'
  requires 'subl.cmd'
end

dep 'Sublime Text 2.app' do
  source 'http://c758482.r82.cf2.rackcdn.com/Sublime Text 2.0.1.dmg'
  version '>= 2.0.1'
end

dep 'Sublime Text 2 theme.cloned' do
  requires 'Sublime Text 2.app'
  repo "git://github.com/buymeasoda/soda-theme.git"
  destination  "~/Library/Application Support/Sublime Text 2/Packages/Theme - Soda"
end

dep 'Sublime Text 2 preferences' do
  requires 'Sublime Text 2.app'
  requires 'Sublime Text 2 theme.cloned'

  def configs_dir
    "~/Library/Application Support/Sublime Text 2/Packages/User"
  end

  def configs_dir_backup
    "#{configs_dir}.backup"
  end

  met? { configs_dir_backup.p.exists? }
  meet {
    log shell "cp -R '#{configs_dir.p}' '#{configs_dir_backup.p}'"
    log shell "cp -fp #{load_path.parent}/sublime_text_2/* '#{configs_dir.p}'"
  }
end

dep 'subl.cmd' do
  requires 'Sublime Text 2.app'
  source "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"
end
