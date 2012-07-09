dep 'env' do
  requires 'xcode commandline tools'
  requires 'osx prefs'
  requires 'dotfiles'

  requires 'packages'
  requires 'imagemagick'
  requires 'redis'
  requires 'mongodb'
  requires 'pow'

  requires 'osx apps'
  requires 'dropbox'

  after {
    log_ok "Done. Your env is ready!"
  }
end
