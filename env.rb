dep 'env' do
  requires 'build tools'
  requires 'osx prefs'
  requires 'dotfiles'.with(:git_repo => 'git@github.com:sporkd/dotfiles.git')
  requires 'zsh'

  # Homebrew
  requires 'packages'
  requires 'imagemagick'
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

  # Other
  requires 'Skype.app'
  requires 'Dropbox'

  after {
    log_ok "Done. Your env is ready!"
  }
end
