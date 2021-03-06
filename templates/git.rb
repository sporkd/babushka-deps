meta :cloned do
  accepts_value_for :repo
  accepts_value_for :destination

  template {
    if repo.to_s.match(/^git@/)
      requires_when_unmet 'github has my public key'
    end

    met? {
      destination.p.exists? &&
      shell("git remote -v", :cd => destination)[repo.to_s]
    }
    meet { shell "git clone #{repo} '#{destination.p}'" }
  }
end
