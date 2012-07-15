meta :command do
  accepts_value_for :target

  def command
    basename
  end

  def target_path
    target.gsub(' ', '\ ')
  end

  template {
    met? { "/usr/local/bin/#{command}".p.exists? }
    meet {
      # log shell "chmod +x #{target}"
      cd '/usr/local/bin' do |path|
        log shell "ln -s #{target_path} ./#{command}", :sudo => !path.writable?
      end 
    }
  }
end

