meta :cloned do
  accepts_value_for :repo
  accepts_value_for :destination

  template {
    def destination_esc
      destination.gsub(/([^\\]) /, '\1\\ ')
    end

    if repo.to_s.match(/^git@/)
      requires_when_unmet 'github has my public key'
    end

    met? {
      destination.p.exists? &&
      shell("git remote -v", :cd => destination_esc)[repo.to_s]
    }
    meet { shell "git clone #{repo} #{destination_esc}" }
  }
end