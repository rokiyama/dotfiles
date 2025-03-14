#!/bin/sh

readonly dotfiles_dir=$(cd $(dirname $0) && pwd)

echo "dotfiles_dir: $dotfiles_dir"

cd $HOME
ln -s -f $dotfiles_dir/.bash_logout
ln -s -f $dotfiles_dir/.bash_profile
ln -s -f $dotfiles_dir/.bashrc
ln -s -f $dotfiles_dir/.editrc
ln -s -f $dotfiles_dir/.inputrc
ln -s -f $dotfiles_dir/.my.cnf
ln -s -f $dotfiles_dir/.psqlrc
ln -s -f $dotfiles_dir/.vim

[ -d $HOME/.config ] || mkdir $HOME/.config
for f in $dotfiles_dir/dotconfig/*
do
  echo $f
  ln -s -f $f $HOME/.config/ $(basename $f)
done
