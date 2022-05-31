#!/bin/zsh
# Rawley Fowler's .zshrc, last edited May 2022
export ZSH="$HOME/.oh-my-zsh"

# Configure brew on startup of new machine
if ! type "brew" > /dev/null; then
    exec /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Configure git, on startup of new machine
if ! type "git" > /dev/null; then
    exec brew install git
    git config --global core.excludesfile ~/.gitignore_global
fi

#Oh my zsh
ZSH_THEME="afowler"
plugins=(git)
source $ZSH/oh-my-zsh.sh

#PATH
export PATH=$PATH:$HOME/.emacs.d/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"
