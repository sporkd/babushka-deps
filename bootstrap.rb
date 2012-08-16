dep 'bootstrap' do
  log "You can keep your own babushka deps in ~/.babushka/deps", :as => :stderr
  confirm(
    "Do you hava a babushka-deps git repo to clone?",
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
