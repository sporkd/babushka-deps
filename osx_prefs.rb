dep 'osx prefs' do
  requires 'finder defaults',
           'mathiasbynens defaults'
end

# allow "locate foo" to be run at the command line
dep 'locatedb' do
  puts "We are asking you for your password so that we can execute `sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist`"
  puts "This is so that you can run the command `locate foo`."
  shell "sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist"
end


# Setup Preferences typically configured in the GUI at Finder > Preferences
dep 'finder defaults' do
  # Show these items on the desktop
  shell "defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true"
  shell "defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true"
  shell "defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true"
  shell "defaults write com.apple.finder ShowMountedServersOnDesktop -bool true"

  # Set this to open to the home directory, not "All My Files", if you want All My Files though it's PfAF
  shell "defaults write com.apple.finder NewWindowTarget PfHm"  

  # Always open everything in Finder's list view
  shell 'defaults write com.apple.finder FXPreferredViewStyle Nlsv'
end

dep 'mathiasbynens defaults' do
  # Disable menu bar transparency
  # shell 'defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false'

  # Show remaining battery time; hide percentage
  # shell 'defaults write com.apple.menuextra.battery ShowPercent -string "NO"'
  # shell 'defaults write com.apple.menuextra.battery ShowTime -string "YES"'

  # Always show scrollbars
  # shell 'defaults write NSGlobalDomain AppleShowScrollBars -string "Always"'

  # Expand save panel by default
  shell 'defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true'

  # Expand print panel by default
  shell 'defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true'

  # Disable the “Are you sure you want to open this application?” dialog
  shell 'defaults write com.apple.LaunchServices LSQuarantine -bool false'

  # Display ASCII control characters using caret notation in standard text views
  # Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
  shell 'defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true'

  # Disable opening and closing window animations
  # shell 'defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false'

  # Increase window resize speed for Cocoa applications
  shell 'defaults write NSGlobalDomain NSWindowResizeTime -float 0.001'

  # Disable Resume system-wide
  # shell 'defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false'

  # Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)
  # Commented out, as this is known to cause problems when saving files in Adobe Illustrator CS5 :(
  #echo "0x08000100:0" > ~/.CFUserTextEncoding

  # Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
  # shell 'defaults write NSGlobalDomain AppleKeyboardUIMode -int 3'

  # Enable subpixel font rendering on non-Apple LCDs
  # shell 'defaults write NSGlobalDomain AppleFontSmoothing -int 2'

  # Disable press-and-hold for keys in favor of key repeat
  shell 'defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false'

  # Set a blazingly fast keyboard repeat rate
  shell 'defaults write NSGlobalDomain KeyRepeat -int 0'

  # Disable auto-correct
  shell 'defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false'

  # Enable tap to click (Trackpad) for this user and for the login screen
  # shell 'defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true'
  # shell 'defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1'
  # shell 'defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1'

  # Map bottom right Trackpad corner to right-click
  # shell 'defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2'
  # shell 'defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true'
  # shell 'defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1'
  # shell 'defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true'

  # Require password immediately after sleep or screen saver begins
  shell 'defaults write com.apple.screensaver askForPassword -int 1'
  shell 'defaults write com.apple.screensaver askForPasswordDelay -int 0'

  # Save screenshots to the desktop
  shell 'defaults write com.apple.screencapture location -string "$HOME/Desktop"'

  # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
  shell 'defaults write com.apple.screencapture type -string "png"'

  # Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
  # shell 'defaults write com.apple.finder QuitMenuItem -bool true'

  # Disable window animations and Get Info animations in Finder
  # shell 'defaults write com.apple.finder DisableAllAnimations -bool true'

  # Show all filename extensions in Finder
  shell 'defaults write NSGlobalDomain AppleShowAllExtensions -bool true'

  # Show status bar in Finder
  shell 'defaults write com.apple.finder ShowStatusBar -bool true'

  # Allow text selection in Quick Look
  shell 'defaults write com.apple.finder QLEnableTextSelection -bool true'

  # Disable disk image verification
  # shell 'defaults write com.apple.frameworks.diskimages skip-verify -bool true'
  # shell 'defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true'
  # shell 'defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true'

  # Automatically open a new Finder window when a volume is mounted
  shell 'defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true'
  shell 'defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true'
  shell 'defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true'

  # Display full POSIX path as Finder window title
  shell 'defaults write com.apple.finder _FXShowPosixPathInTitle -bool true'

  # Avoid creating .DS_Store files on network volumes
  shell 'defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true'

  # Disable the warning when changing a file extension
  shell 'defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false'

  # Show item info below desktop icons
  # shell '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist'

  # Enable snap-to-grid for desktop icons
  shell '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist'

  # Disable the warning before emptying the Trash
  shell 'defaults write com.apple.finder WarnOnEmptyTrash -bool false'

  # Empty Trash securely by default
  shell 'defaults write com.apple.finder EmptyTrashSecurely -bool true'

  # Enable AirDrop over Ethernet and on unsupported Macs running Lion
  shell 'defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true'

  # Show the ~/Library folder
  shell 'chflags nohidden ~/Library'

  # Hot corners
  # Top left screen corner → Mission Control
  # shell 'defaults write com.apple.dock wvous-tl-corner -int 2'
  # shell 'defaults write com.apple.dock wvous-tl-modifier -int 0'
  # Top right screen corner → Desktop
  # shell 'defaults write com.apple.dock wvous-tr-corner -int 4'
  # shell 'defaults write com.apple.dock wvous-tr-modifier -int 0'
  # Bottom left screen corner → Start screen saver
  # shell 'defaults write com.apple.dock wvous-bl-corner -int 5'
  # shell 'defaults write com.apple.dock wvous-bl-modifier -int 0'

  # Enable highlight hover effect for the grid view of a stack (Dock)
  # shell 'defaults write com.apple.dock mouse-over-hilte-stack -bool true'

  # Set the icon size of Dock items to 36 pixels
  # shell 'defaults write com.apple.dock tilesize -int 36'

  # Enable spring loading for all Dock items
  # shell 'defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true'

  # Show indicator lights for open applications in the Dock
  # shell 'defaults write com.apple.dock show-process-indicators -bool true'

  # Don’t animate opening applications from the Dock
  # shell 'defaults write com.apple.dock launchanim -bool false'

  # Remove the auto-hiding Dock delay
  # shell 'defaults write com.apple.Dock autohide-delay -float 0'
  # Remove the animation when hiding/showing the Dock
  # shell 'defaults write com.apple.dock autohide-time-modifier -float 0'

  # Enable the 2D Dock
  # shell 'defaults write com.apple.dock no-glass -bool true'

  # Automatically hide and show the Dock
  # shell 'defaults write com.apple.dock autohide -bool true'

  # Make Dock icons of hidden applications translucent
  shell 'defaults write com.apple.dock showhidden -bool true'

  # Enable iTunes track notifications in the Dock
  shell 'defaults write com.apple.dock itunes-notifications -bool true'

  # Add a spacer to the left side of the Dock (where the applications are)
  # shell 'defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}''
  # Add a spacer to the right side of the Dock (where the Trash is)
  # shell 'defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}''

  # Disable shadow in screenshots
  shell 'defaults write com.apple.screencapture disable-shadow -bool true'

  # Disable Safari’s thumbnail cache for History and Top Sites
  shell 'defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2'

  # Enable Safari’s debug menu
  shell 'defaults write com.apple.Safari IncludeInternalDebugMenu -bool true'

  # Make Safari’s search banners default to Contains instead of Starts With
  shell 'defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false'

  # Remove useless icons from Safari’s bookmarks bar
  shell 'defaults write com.apple.Safari ProxiesInBookmarksBar "()"'

  # Add a context menu item for showing the Web Inspector in web views
  shell 'defaults write NSGlobalDomain WebKitDeveloperExtras -bool true'

  # Enable the debug menu in Address Book
  # shell 'defaults write com.apple.addressbook ABShowDebugMenu -bool true'

  # Enable the debug menu in iCal
  # shell 'defaults write com.apple.iCal IncludeDebugMenu -bool true'

  # Only use UTF-8 in Terminal.app
  shell 'defaults write com.apple.terminal StringEncodings -array 4'

  # Enable “focus follows mouse” for Terminal.app and all X11 apps
  # This means you can hover over a window and start typing in it without clicking first
  # shell 'defaults write com.apple.terminal FocusFollowsMouse -bool true'
  # shell 'defaults write org.x.X11 wm_ffm -bool true'

  # Disable the Ping sidebar in iTunes
  # shell 'defaults write com.apple.iTunes disablePingSidebar -bool true'

  # Disable all the other Ping stuff in iTunes
  # shell 'defaults write com.apple.iTunes disablePing -bool true'

  # Make ⌘ + F focus the search input in iTunes
  shell 'defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"'

  # Disable send and reply animations in Mail.app
  shell 'defaults write com.apple.Mail DisableReplyAnimations -bool true'
  shell 'defaults write com.apple.Mail DisableSendAnimations -bool true'

  # Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
  # shell 'defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false'

  # Enable Dashboard dev mode (allows keeping widgets on the desktop)
  # shell 'defaults write com.apple.dashboard devmode -bool true'

  # Reset Launchpad
  # shell 'find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete'

  # Prevent Time Machine from prompting to use new hard drives as backup volume
  # shell 'defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true'

  # Disable local Time Machine backups
  # shell 'hash tmutil &> /dev/null && sudo tmutil disablelocal'

  # Remove Dropbox’s green checkmark icons in Finder
  # shell 'file=/Applications/Dropbox.app/Contents/Resources/check.icns'
  # shell '[ -e "$file" ] && mv -f "$file" "$file.bak"'
  # shell 'unset file'

  # Kill affected applications
  shell 'for app in Finder Dock Mail Safari iTunes iCal Address\ Book SystemUIServer; do killall "$app" > /dev/null 2>&1; done'
  shell 'echo "Done. Note that some of these changes require a logout/restart to take effect."'
end