meta :cmd do
  accepts_value_for :source
  accepts_value_for :softlink

  def src_path
    source.gsub(' ', '\ ')
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
      if softlink == true
        unless source.p.executable?
          log shell "chmod +x #{src_path}", :sudo => !source.p.writable?
        end
        log shell "ln -s #{src_path} #{bin_path}", :sudo => !bin_dir.p.writable?
      else
        log shell "cp #{src_path} #{bin_path}", :sudo => !bin_dir.p.writable?
        unless bin_path.p.executable?
          log shell "chmod +x #{bin_path}", :sudo => !bin_path.p.writable?
        end
      end
    }
  }
end

