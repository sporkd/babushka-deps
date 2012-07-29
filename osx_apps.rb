dep 'osx apps' do

  # Browsers
  requires 'Firefox.app'
  requires 'Google Chrome.app'
  # requires 'Chromium.app'

  # Mail and Communication
  requires 'Skype.app'
  requires 'Sparrow.app'
  # requires 'HipChat'

  # Development
  requires 'iTerm.app'
  requires 'GitX.app'
  requires 'TextMate.app'

  # Mac App Store Apps (install through the store)
  # requires 'Cloud.app'
  # requires 'Twitter.app'
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

dep 'Firefox.app' do
  source 'http://mozilla.cdn.leaseweb.com/firefox/releases/13.0.1/mac/en-US/Firefox%2013.0.1.dmg'
end

dep 'iTerm.app' do
  source 'http://iterm2.googlecode.com/files/iTerm2_v1_0_0.zip'
end

dep 'GitX.app' do
  source 'http://frim.frim.nl/GitXStable.app.zip'
end

dep 'Google Chrome.app' do
  source 'https://dl-ssl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg'
end

dep 'Skype.app' do
  source 'http://www.skype.com/go/getskype-macosx.dmg'
end

dep 'Sparrow.app' do
  source 'http://download.sparrowmailapp.com/release/Sparrow-latest.dmg'
end

