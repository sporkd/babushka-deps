meta :cmd do
  accepts_value_for :source
  accepts_value_for :copy

  def source_esc
    source.gsub(/([^\\]) /, '\1\\ ')
  end

  def bin_dir
    "/usr/local/bin"
  end

  def bin
    basename
  end

  def bin_path
    "#{bin_dir}/#{bin}"
  end

  template {
    met? { bin_path.p.exists? && shell("which '#{bin}'") }
    meet {
      if copy == true
        log shell "cp #{source_esc} #{bin_path}", :sudo => !bin_dir.p.writable?
        unless bin_path.p.executable?
          log shell "chmod +x #{bin_path}", :sudo => !bin_path.p.writable?
        end
      else
        unless source.p.executable?
          log shell "chmod +x #{source_esc}", :sudo => !source.p.writable?
        end
        log shell "ln -s #{source_esc} #{bin_path}", :sudo => !bin_dir.p.writable?
      end
    }
  }
end

