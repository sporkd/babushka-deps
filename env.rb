dep 'env', :github_username do
  username = shell('whoami')

  requires 'xcode commandline tools'
  requires 'osx prefs'
  requires 'packages'
  requires 'dotfiles'
  requires 'osx applications'
  requires 'benhoskings:zsh'.with(username)

  after {
    log_ok "Done. Your env is ready!"
  }
end