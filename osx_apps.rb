dep 'osx apps' do

  requires 'Firefox.app',
           'Google Chrome.app',
           'Skype.app',
           'Sparrow.app',
           # 'Mailplane.app',
           # 'Transmission.app'
           # 'HipChat'
           # 'OmniGraffle Professional 5.app',

  # Development
  requires 'GitX.app',
           'iTerm.app',
           'MacVim.app',
           'TextMate.app',
           'Sublime Text 2.app'
           # 'Sequel Pro.app',
           # 'VirtualBox.installer' 

  # System utilities
  requires 'Dropbox.app',
  requires 'Growl.installer'

  # Mac App Store Apps (install through the store)
           # 'Cloud.app',
           # 'Twitter.app'
end

dep 'Chromium.app' do
  requires_when_unmet "Chromium.app download cleared"
  source L{
    "http://build.chromium.org/buildbot/snapshots/chromium-rel-mac/#{version}/chrome-mac.zip"
  }
  latest_version {
    shell "curl http://build.chromium.org/buildbot/snapshots/chromium-rel-mac/LATEST"
  }
  current_version {|path|
    IO.read(path / 'Contents/Info.plist').xml_val_for('SVNRevision')
  }
end

# TODO better version handling will make this unnecessary.
dep "Chromium.app download cleared" do
  met? { in_download_dir { !'chrome-mac.zip'.p.exists? } }
  meet { in_download_dir { 'chrome-mac.zip'.p.rm } }
end

dep 'Dropbox.app' do
  source 'http://cdn.dropbox.com/Dropbox%201.4.9.dmg'
end

dep 'Firefox.app' do
  source 'http://www.mozilla.org/products/download.html?product=firefox-13.0.1&os=osx&lang=en-US'
end

dep 'GitX.app' do
  source 'http://frim.frim.nl/GitXStable.app.zip'
end

dep 'Google Chrome.app' do
  source 'https://dl-ssl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg'
end

dep 'iTerm.app' do
  meet {
    handle_source 'http://iterm2.googlecode.com/files/iTerm2_v1_0_0.zip' do |zip|
      in_build_dir do |path|
        app = path / zip.path.without_extension.basename / 'iTerm.app'
        app.copy '/Applications'
      end
    end
  }
end

dep 'Skitch.app' do
  source 'http://get.skitch.com/skitch.zip'
end

dep 'Skype.app' do
  source 'http://www.skype.com/go/getskype-macosx.dmg'
end

dep 'Sparrow.app' do
  source 'http://download.sparrowmailapp.com/release/Sparrow-latest.dmg'
end

dep 'Vim.app' do
  source 'http://macvim.org/OSX/files/binaries/OSX10_4/Vim7.0-univ.tar.bz2'
end
