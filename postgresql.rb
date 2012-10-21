dep 'postgresql' do
  requires 'postgresql.managed'
  requires 'postgresql.launchd'
end

dep 'postgresql.managed' do
  provides "psql"

  after {
    unless login_shell("echo $PATH") =~ /\/usr\/local\/bin:.*\/usr\/bin(:|$)/
      case shell("echo $SHELL").p.basename
      when 'zsh'
        # "~/.zshrc".p.append(rbenv_init)
        log "/usr/local/bin needs to come before /usr/bin in your $PATH"
      when 'bash'
        # "~/.bash_profile".p.append(rbenv_init)
        log "/usr/local/bin needs to come before /usr/bin in your $PATH"
      end
    end

    unless "/usr/local/var/postgres".p.exists?
      log "Creating your postgres database at /usr/local/var/postgres", :as => :stderr
      log shell "/usr/local/bin/initdb /usr/local/var/postgres -E utf8"
    end
  }
end

dep 'postgresql.launchd'
