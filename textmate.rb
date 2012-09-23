dep 'TextMate' do
  requires 'TextMate.app'
  requires 'mate.cmd'
end

dep 'TextMate.app' do
  source 'https://github.com/downloads/textmate/textmate/TextMate_r9313.tbz'
end

dep 'mate.cmd' do
  requires 'TextMate.app'
  source "/Applications/TextMate.app/Contents/Resources/mate"
end
