# .bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim='nvim'
alias vi='nvim'

GOPATH="$HOME/.go"
GEM_HOME="$HOME/.gems"
GEM_PATH="$HOME/.gems"

export GOPATH
export GEM_HOME
export GEM_PATH

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /etc/profile.d/rvm.sh ] && source /etc/profile.d/rvm.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

PATH="/home/rf/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/rf/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/rf/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/rf/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/rf/perl5"; export PERL_MM_OPT;

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# RVM likes the gem root path to be the first element in the path
PATH="$GEM_HOME/bin:/usr/local/bin/go:$GOPATH/bin:$PATH"

PS1='[\u@\h \W]\$ '
export PS1
