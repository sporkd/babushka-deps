meta :cmd do
  accepts_value_for :source
  accepts_value_for :copy

  def bin_dir
    "/usr/local/bin"
  end

  def bin
    basename
  end

  def bin_file
    "#{bin_dir}/#{bin}"
  end

  template {
    met? { bin_file.p.exists? && bin_file.p.executable? }
    meet {
      if copy == true
        log shell "cp -f '#{source.p}' '#{bin_file.p}'", :sudo => !bin_dir.p.writable?
        unless bin_file.p.executable?
          log shell "chmod +x '#{bin_file.p}'", :sudo => !bin_file.p.writable?
        end
      else
        unless source.p.executable?
          log shell "chmod +x '#{source.p}'", :sudo => !source.p.writable?
        end
        log shell "ln -sf '#{source.p}' '#{bin_file.p}'", :sudo => !bin_dir.p.writable?
      end
    }
  }
end

