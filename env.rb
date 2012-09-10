dep 'env' do
  requires 'build tools'
  requires 'osx prefs'
  requires 'dotfiles'.with(:repo => 'git@github.com:sporkd/dotfiles.git')

  requires 'packages'
  requires 'imagemagick'
  requires 'redis'
  requires 'mongodb'
  requires 'pow'
  requires 'meld'

  requires 'osx apps'
  requires 'Dropbox'
  requires 'MacVim'
  requires 'Sublime Text 2'

  after {
    log_ok "Done. Your env is ready!"
  }
end
