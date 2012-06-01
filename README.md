
Clone
=====

Clone the repository using:

    cd ~
    git clone git://github.com/pitti/dotfiles.git .rcfiles

Get submodules
==============

    git submodule init
    git submodule update


Install symlinks
================

Use the following script to create symlinks of these config files:


    cd ~
    for link in bashrc conkyrc gitconfig muttrc screenrc Xdefaults zshrc; do
      ln -s .rcfiles/$link .$link
    done
