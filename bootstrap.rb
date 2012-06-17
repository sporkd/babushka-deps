dep 'bootstrap' do
  requires 'babushka-deps.cloned'
  username.default(shell('whoami'))

  if Prompt.confirm("Install xcode commandline tools only?")
    requires 'xcode commandline tools'
  else
    requires 'xcode tools'
  end

  requires 'osx prefs'
  requires 'packages'
  requires 'dotfiles'
  requires 'osx applications'
  requires 'benhoskings:zsh'.with(username)
end

dep 'babushka-deps.cloned' do
  requires 'github has my public key'
  repo 'git@github.com:sporkd/babushka-deps.git'
  destination '~/.babushka/deps'
end