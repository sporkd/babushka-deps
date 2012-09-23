dep 'GitX' do
  requires 'GitX.app'
  requires 'gitx.cmd'
end

dep 'GitX.app' do
  source 'http://frim.frim.nl/GitXStable.app.zip'
end

dep 'gitx.cmd' do
  requires 'GitX.app'
  source "/Applications/GitX.app/Contents/Resources/gitx"
end
