dep 'mysql' do
  requires 'mysql.managed'
  requires 'mysql db installed'
  requires 'mysql.launchd'
end

dep 'mysql.managed' do
  provides 'mysql'
end

dep 'mysql db installed', :user do
  user.ask("User to run mysql with").default(shell('whoami'))

  met? {
    "/usr/local/var/mysql".p.exists?
  }
  meet {
    install_cmd =  "unset TMPDIR; "
    install_cmd << "mysql_install_db --verbose --user='#{user}' "
    install_cmd << "--basedir=\"$(brew --prefix mysql)\" "
    install_cmd << "--datadir=/usr/local/var/mysql --tmpdir=/tmp"
    login_shell(install_cmd)
  }
end

dep 'mysql.launchd'