dep 'rbenv' do
  requires 'dotfiles'
  requires {
    on :osx, [
      'rbenv.managed',
      'ruby-build.managed'
    ]
  }
end

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
        shell "rbenv install #{version}", :log => true
      end
    }
    after {
      log shell "rbenv rehash"
    }
  }
end

dep 'rbenv.managed'

dep 'ruby-build.managed' do
  requires 'rbenv.managed'
end

dep '1.9.2-p320.rbenv'
dep '1.9.3-p194.rbenv'
