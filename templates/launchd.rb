require 'fileutils'

meta :launchd, :for => :osx do
  template {
    def plist
      brew_path = Babushka::BrewHelper.brew_path_for(basename)
      Dir["#{brew_path}/*.plist"].first.split('/').last
    end

    requires 'launchd plist copied'.with(:package => basename, :plist => plist)

    met? {
      shell('launchctl list')[basename]
    }
    meet {
      log shell "launchctl load -w ~/Library/LaunchAgents/#{plist}"
    }
  }
end

dep 'launchd plist copied', :package, :plist, :for => :osx do
  def brew_path 
    Babushka::BrewHelper.brew_path_for(package)
  end

  met? {
    "~/Library/LaunchAgents/#{plist}".p.exists? &&
    FileUtils.compare_file("#{brew_path}/#{plist}".p, "~/Library/LaunchAgents/#{plist}".p)
  }
  meet {
    log shell "cp #{brew_path}/#{plist} ~/Library/LaunchAgents/"
  }
  after {
    log shell "launchctl unload -w ~/Library/LaunchAgents/#{plist}"
  }
end
