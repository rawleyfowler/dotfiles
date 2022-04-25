#
# Rawley's .bashrc
# Last edited: April 23, 2022
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim='nvim'
alias vi='nvim'
PS1='[\e[0;32m\u\e[m@\e[0;33m\h\e[m \W]\e[0;33m\$\e[m '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
