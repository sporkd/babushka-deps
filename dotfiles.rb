dep 'dotfiles' do
  requires 'dotfiles installed'
end

dep 'dotfiles installed' do
  requires 'dotfiles.cloned'
  shell 'cd ~/.dotfiles; rake install'
end

dep 'dotfiles.cloned' do
  repo 'git@github.com:sporkd/dotfiles.git'
  destination '~/.dotfiles'
end
