#!/bin/sh

readonly dotfiles_dir=$(cd $(dirname $0) && pwd)

echo "dotfiles_dir: $dotfiles_dir"

cd $HOME
ln -s -f $dotfiles_dir/.bash_logout
ln -s -f $dotfiles_dir/.bash_profile
ln -s -f $dotfiles_dir/.bashrc
ln -s -f $dotfiles_dir/.editrc
ln -s -f $dotfiles_dir/.gitconfig
ln -s -f $dotfiles_dir/.gitignore.global
ln -s -f $dotfiles_dir/.inputrc
ln -s -f $dotfiles_dir/.my.cnf
ln -s -f $dotfiles_dir/.pryrc
ln -s -f $dotfiles_dir/.psqlrc
ln -s -f $dotfiles_dir/.tmux.conf
ln -s -f $dotfiles_dir/.vim

[ -d $HOME/.config ]            || mkdir -p $HOME/.config
[ -d $HOME/.config/nvim ]       || ln -s $dotfiles_dir/nvim                           $HOME/.config/nvim
[ -d $HOME/.config/karabiner ]  || ln -s $dotfiles_dir/karabiner                      $HOME/.config/karabiner

[ -d $HOME/.config/alacritty ]                      || mkdir -p $HOME/.config/alacritty
ln -s -f $dotfiles_dir/alacritty/alacritty.yml                  $HOME/.config/alacritty/alacritty.yml

[ -d $HOME/.config/fish ]                           || mkdir -p $HOME/.config/fish
ln -s -f $dotfiles_dir/fish/config.fish                         $HOME/.config/fish/config.fish
ln -s -f $dotfiles_dir/fish/fishfile                            $HOME/.config/fish/fishfile

[ -d $HOME/.config/powerline ]                      || mkdir -p $HOME/.config/powerline
ln -s -f $dotfiles_dir/powerline/config.json                    $HOME/.config/powerline/config.json

[ -d $HOME/.config/yamllint ]                       || mkdir -p $HOME/.config/yamllint
ln -s -f $dotfiles_dir/yamllint/config                          $HOME/.config/yamllint/config

[ -d /usr/local/opt/alacritty/Applications/Alacritty.app ] && \
  [ ! -d /Applications/Alacritty.app ] && \
  ln -s -f /usr/local/opt/alacritty/Applications/Alacritty.app /Applications/Alacritty.app

return 0
