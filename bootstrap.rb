dep 'bootstrap' do
  log "Personal babushka deps are kept in ~/.babushka/deps", :as => :stderr
  confirm(
    "Do you hava a babushka-deps git repo to install?",
    :otherwise => "No worries. You can create one later."
  ) do
    requires 'babushka-deps.cloned'
  end
end

dep 'babushka-deps.cloned', :git_repo do
  git_repo.ask("Your babushka-deps repo location").default("git@github.com:sporkd/babushka-deps.git")
  repo git_repo
  destination '~/.babushka/deps'
end
