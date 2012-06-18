dep 'github has my public key', :github_username, :github_password do
  requires 'ssh keys'

  met? { raw_shell('ssh -T git@github.com 2>&1').stdout['successfully authenticated'] }
  prepare {
    set :hostname, shell('hostname')
    set :public_key, shell('cat ~/.ssh/id_rsa.pub')
    set :github_api, 'https://api.github.com'
  }
  meet {
    github_username ||= get_value("Enter your github username")
    github_password ||= get_value("Enter your github password")
    auth = "#{ github_username }:#{ github_password }"
    args = "{\"title\": \"#{var :hostname}\", \"key\": \"#{var :public_key}\"}"
    shell "curl -u '#{auth}' -d '#{args}' #{var :github_api}/user/keys"
  }
end