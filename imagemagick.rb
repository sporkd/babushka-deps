dep 'imagemagick' do
  requires 'imagemagick.managed'
end

dep 'imagemagick.managed' do
  provides 'convert'
end
