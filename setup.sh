#!/bin/sh

# if we don't have dotfiles yet, check them out
if [ ! -x ~/dotfiles ] ; then
    git clone https://github.com/lpesk/dotfiles.git ~/dotfiles
fi

cd ~/dotfiles/

# add more files to the list here as needed
for i in zshrc ; do
    ln -sf `pwd`/$i ~/.$i
done

# change shell to zsh
chsh -s $(grep /zsh$ /etc/shells | tail -1)
