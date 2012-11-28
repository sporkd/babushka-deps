meta :launchd, :for => :osx do
  accepts_value_for :destination, "~/Library/LaunchAgents"

  template {
    def plist
      brew_path = Babushka::BrewHelper.brew_path_for(basename)
      Dir["#{brew_path}/*.plist"].first.p.basename.to_s
    end

    def plist_path
      (destination / plist)
    end

    requires 'launchd plist linked'.with(
      :package => basename,
      :plist => plist,
      :destination => destination
    )

    met? {
      shell('launchctl list')[basename]
    }
    meet {
      log shell "launchctl load -w '#{plist_path}'"
    }
  }
end

dep 'launchd plist linked', :package, :plist, :destination, :for => :osx do
  def brew_path
    Babushka::BrewHelper.brew_path_for(package)
  end

  def plist_template
    (brew_path / plist)
  end

  def plist_path
    (destination / plist)
  end

  met? {
    plist_path.exists? && plist_path.symlink? &&
    File.readlink(plist_path) == plist_template.to_s
  }
  meet {
    if plist_path.exists?
      log shell "launchctl unload -w '#{plist_path}'"
      plist_path.remove
    end
    log shell "ln -sfv #{plist_template} #{plist_path}"
  }
end
