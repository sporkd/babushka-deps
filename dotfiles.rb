dep 'dotfiles' do
  requires 'dotfiles symlinked'
end

dep 'dotfiles.cloned' do
  repo 'git@github.com:sporkd/dotfiles.git'
  destination '~/.dotfiles'
end

dep 'dotfiles symlinked' do
  requires 'dotfiles.cloned'
  shell 'cd ~/.dotfiles; rake install'
end
