#!/bin/sh

# if we don't have dotfiles yet, check them out
if [ ! -x ~/dotfiles ] ; then
    git clone https://github.com/lpesk/dotfiles.git ~/dotfiles
fi

cd ~/dotfiles/

# add more files to the list here as needed
#
# TODO: maybe add an option to this script to control which files to
# symlink/load from emacs.d/config/
for i in emacs.d tmux.conf zshenv zshrc ; do
    ln -sfn `pwd`/$i ~/.$i
done

# change shell to zsh
# TODO: maybe check the current shell first and only change if != zsh?
chsh -s $(grep /zsh$ /etc/shells | tail -1)
