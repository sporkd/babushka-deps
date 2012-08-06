dep 'dotfiles' do
  requires 'dotfiles installed'
  requires 'zsh'
end

dep 'dotfiles installed' do
  requires 'dotfiles.cloned'
  met? { '~/.zshrc'.p.exists? }
  meet {
    cd '~/.dotfiles' do
      log_block "Installing dotfiles" do
        shell 'rake install', :log => true, :input => "O"
      end
    end
  }
end

dep 'dotfiles.cloned' do
  requires_when_unmet 'github has my public key'
  repo 'git@github.com:sporkd/dotfiles.git'
  destination '~/.dotfiles'
end
