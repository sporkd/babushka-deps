dep 'dotfiles' do
  requires 'dotfiles installed'
end

dep 'dotfiles installed' do
  requires 'dotfiles.cloned'
  shell 'cd ~/.dotfiles; rake install'
end

dep 'dotfiles.cloned' do
  requires 'github has my public key'
  repo 'git@github.com:sporkd/dotfiles.git'
  destination '~/.dotfiles'
end
