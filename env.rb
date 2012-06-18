dep 'env', :github_username do
  username = shell('whoami')

  if confirm("Install xcode commandline tools", :default => 'y')
    requires 'xcode commandline tools'
  else
    requires 'xcode tools'
  end

  # requires 'osx prefs'
  # requires 'packages'
  # requires 'dotfiles'
  # requires 'osx applications'
  # requires 'benhoskings:zsh'.with(username)

  after {
    log_ok "Done. Your env is ready!"
  }
end