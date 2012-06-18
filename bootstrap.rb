dep 'bootstrap', :github_username do
  github_username.ask("What is your github username").default('sporkd')
  requires 'babushka-deps.cloned'.with(:github_username => github_username)
end

dep 'babushka-deps.cloned', :github_username do
  requires 'github has my public key'.with(:github_username => github_username)
  repo "git@github.com:#{ github_username }/babushka-deps.git"
  destination '~/.babushka/deps'
end
