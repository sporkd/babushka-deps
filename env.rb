dep 'env', :github_username do
  username = shell('whoami')

  github_username.ask("What github account would you like to install from").default('sporkd')
  requires 'babushka-deps.cloned'.with(:github_username => github_username)

  # if Prompt.confirm("Install xcode commandline tools only?")
  #   requires 'xcode commandline tools'
  # else
  #   requires 'xcode tools'
  # end

  # requires 'osx prefs'
  # requires 'packages'
  # requires 'dotfiles'
  # requires 'osx applications'
  # requires 'benhoskings:zsh'.with(username)

  after {
    log "Done. Your env is ready!"
  }
end

dep 'babushka-deps.cloned', :github_username do
  requires 'github has my public key'.with(:github_username => github_username)
  repo "git@github.com:#{ github_username }/babushka-deps.git"
  destination '~/.babushka/deps'
end