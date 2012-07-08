dep 'rbenv' do
  requires {
    on :osx, [
      'rbenv.managed',
      'ruby-build.managed'
    ]
  }
end

dep 'rbenv.managed'

dep 'ruby-build.managed' do
  requires 'rbenv.managed'
end
