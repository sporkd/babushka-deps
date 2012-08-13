dep 'github has my public key', :github_username, :github_password do
  requires 'ssh keys'

  def github_api
    'https://api.github.com'
  end

  def public_key
    shell('cat ~/.ssh/id_rsa.pub')
  end

  def hostname
    shell('hostname')
  end

  met? {
    raw_shell('ssh -T git@github.com 2>&1').stdout['successfully authenticated']
  }
  meet {
    github_username.ask("What is your github username")
    github_password.ask("What is your github password")
    auth = "#{github_username}:#{github_password}"
    args = "{\"title\": \"#{hostname}\", \"key\": \"#{public_key}\"}"
    shell "curl -u '#{auth}' -d '#{args}' #{github_api}/user/keys"
  }
end