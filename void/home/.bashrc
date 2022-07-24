# .bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim='nvim'
alias vi='nvim'

GEM_HOME="$HOME/.gems"
GOPATH="$HOME/.go"
PATH="$GEM_HOME/bin:/usr/local/bin/go:$GOPATH/bin:$PATH"

PS1='[\u@\h \W]\$ '

export GEM_HOME
export GOPATH

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
