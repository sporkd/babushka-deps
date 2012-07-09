dep 'rbenv' do
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
    # requires 'benhoskings:yaml headers.managed'

    def version
      basename
    end

    # def configure_opts
    #   yaml_location = shell('brew info libyaml').split("\n").collapse(/\s+\(\d+ files, \S+\)/)
    #   "--with-libyaml-dir='#{yaml_location}'"
    # end

    met? {
      shell('rbenv versions')[/#{version}\b/]
    }
    meet {
      log_block "Installing #{version}" do
        # shell "CONFIGURE_OPTS=\"#{configure_opts}\" rbenv install #{version}", :log => true
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

