#!/bin/zsh
# Rawley Fowler's .zshrc, last edited May 2022
export ZSH="$HOME/.oh-my-zsh"

#Oh my zsh
ZSH_THEME="afowler"
plugins=(git)
source $ZSH/oh-my-zsh.sh

#PATH
export PATH=$PATH:$HOME/.emacs.d/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
