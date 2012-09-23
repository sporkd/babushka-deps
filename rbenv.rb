dep '1.9.2-p320.rbenv'
dep '1.9.3-p194.rbenv'

meta :rbenv do
  template {
    requires 'rbenv'

    def version
      basename
    end

    met? {
      shell('rbenv versions')[/#{version}\b/]
    }
    meet {
      log_block "Installing #{version}" do
        log shell "rbenv install #{version}"
      end
    }
    after {
      log shell "rbenv rehash"
    }
  }
end

dep 'rbenv' do
  requires {
    on :osx, [
      'rbenv.managed',
      'ruby-build.managed',
      'rbenv-bundler.managed'
    ]
  }
end

dep 'rbenv.managed' do
  after {
    unless login_shell("echo $PATH") =~ /\.rbenv\/shims/
      rbenv_init = 'eval "$(rbenv init -)"'
      case shell("echo $SHELL").p.basename
      when 'zsh'
        "~/.zshrc".p.append(rbenv_init)
      when 'bash'
        "~/.bash_profile".p.append(rbenv_init)
      end
    end
  }
end

dep 'ruby-build.managed' do
  requires 'rbenv.managed'
end

dep 'rbenv-bundler.managed' do
  requires 'rbenv.managed'
end
