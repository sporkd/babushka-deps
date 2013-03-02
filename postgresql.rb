dep 'postgresql' do
  requires 'postgresql.managed'
  requires 'postgresql.launchd'
  requires 'postgres superuser'
end

dep 'postgresql.managed' do
  provides "psql"

  after {
    # http://tammersaleh.com/posts/installing-postgresql-for-rails-3-1-on-lion
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

dep 'postgres superuser', :role do
  role.ask("Role name for postgres superuser").default("admin")
  met? {
    shell "psql postgres -tAc \"SELECT * FROM pg_roles WHERE rolname='#{role}'\""
  }
  meet {
    log shell "createuser --superuser -p #{role}"
  }
end
