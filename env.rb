dep 'env' do
  requires 'build tools'
  # TODO: Install http://xquartz.macosforge.org and re-login
  requires 'osx prefs'
  requires 'dotfiles'.with(:git_repo => 'git@github.com:sporkd/dotfiles.git')
  requires 'zsh'
  requires 'fish'

  # Homebrew
  requires 'packages'
  requires 'imagemagick'
  requires 'postgresql'
  requires 'redis'
  requires 'mongodb'
  requires 'pow'
  requires 'meld'

  requires '1.9.3-p194.rbenv'

  # Browsers
  requires 'Firefox.app'
  requires 'Google Chrome.app'

  # Development
  requires 'iTerm.app'
  requires 'GitX.app'
  requires 'MacVim'
  requires 'Sublime Text 2'
  requires 'TextMate'

  # Other
  requires 'Skype.app'
  requires 'Dropbox'

  after {
    log_ok "Done. Your env is ready!"
  }
end
