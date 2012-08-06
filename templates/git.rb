meta :cloned do
  accepts_value_for :repo
  accepts_value_for :destination

  def destination_esc
    destination.gsub(/([^\\]) /, '\1\\ ')
  end

  template {
    met? { destination.p.exists? && shell("(cd #{destination_esc} && git remote -v)")[repo] }
    meet { shell "git clone #{repo} #{destination_esc}" }
  }
end