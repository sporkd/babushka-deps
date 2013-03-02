require 'fileutils'

dep 'Sublime Text 2' do
  requires 'Sublime Text 2.app'
  requires 'Sublime Text 2 theme.cloned'
  requires 'Sublime Text 2 color schemes'
  requires 'Sublime Text 2 preferences'
  requires 'subl.cmd'
end

dep 'Sublime Text 2.app' do
  source 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg'
  version '>= 2.0.1'
  prefix %w[/Applications]

  def bin_dir
    (app_location / provides / "Contents/SharedSupport/bin")
  end

  after {
    system("'#{bin_dir}'/subl --background &")
    sleep 4
    log shell "kill `ps -A | awk '/Sublime Text 2.app/{print $1}' | head -1`"
  }
end

dep 'subl.cmd' do
  requires 'Sublime Text 2.app'
  source "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"
end

dep 'Sublime Text 2 backup' do
  requires 'Sublime Text 2.app'

  def preferences_dir
    "#{sublime_text_2_packages_dir}/User"
  end

  def preferences_dir_backup
    "#{preferences_dir}.backup"
  end

  met? { preferences_dir_backup.p.exists? }
  meet {
    log shell "cp -R '#{preferences_dir.p}' '#{preferences_dir_backup.p}'"
  }
end

dep 'Sublime Text 2 theme.cloned' do
  requires 'Sublime Text 2 backup'
  repo "git://github.com/buymeasoda/soda-theme.git"
  destination  "~/Library/Application Support/Sublime Text 2/Packages/Theme - Soda"
end

dep 'Sublime Text 2 color schemes' do
  def templates_dir
    "#{load_path.parent}/sublime_text_2/color_schemes"
  end

  def templates_paths
    templates_dir.p.glob("*.tmTheme")
  end

  def color_schemes_dir
    "#{sublime_text_2_packages_dir}/Color Scheme - Default"
  end

  met? {
    color_schemes = templates_paths.collect do |path|
      template = (templates_dir / path.p.basename)
      target = (color_schemes_dir / path.p.basename)
      target.exists? && FileUtils.compare_file(template, target)
    end
    color_schemes.empty? || (color_schemes.uniq == [true])
  }
  meet {
    log shell "cp -fp '#{templates_dir.p}'/* '#{color_schemes_dir.p}'"
  }
end

dep 'Sublime Text 2 preferences' do
  requires 'Sublime Text 2 theme.cloned'
  requires 'Sublime Text 2 color schemes'

  def templates_dir
    "#{load_path.parent}/sublime_text_2/settings"
  end

  def templates_paths
    templates_dir.p.glob("*-{settings,keymap}")
  end

  def preferences_dir
    "#{sublime_text_2_packages_dir}/User"
  end

  met? {
    preferences = templates_paths.collect do |path|
      template = (templates_dir / path.p.basename)
      target = (preferences_dir / path.p.basename)
      target.exists? && FileUtils.compare_file(template, target)
    end
    preferences.empty? || (preferences.uniq == [true])
  }
  meet {
    log shell "cp -fp '#{templates_dir.p}'/* '#{preferences_dir.p}'"
  }
end

def sublime_text_2_packages_dir
  "~/Library/Application Support/Sublime Text 2/Packages"
end
