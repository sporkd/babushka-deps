dep 'MacVim' do
  requires 'mvim.cmd'
end

dep 'MacVim.app' do
  source 'https://github.com/downloads/b4winckler/macvim/MacVim-snapshot-64.tbz'
end

dep 'mvim.cmd' do
  requires 'MacVim.app'
  source "#{Babushka::BuildPrefix}/MacVim-snapshot-64.tbz/MacVim-snapshot-64/mvim"
end

