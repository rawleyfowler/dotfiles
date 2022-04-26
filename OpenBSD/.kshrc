#
# Ralwey Fowler's .kshrc
# Last edited: April 25th, 2022
#

# I use NeoVim exclusively on OpenBSD.
alias vi=nvim
alias vim=nvim
alias ls=colorls

# I'm a noob, I know.
alias sudo=doas

# For some reason ruby on OpenBSD is ruby30 or gem30 or ruby27 etc, sort of nice for version control but annoying to type.
alias ruby=ruby30
alias gem=gem30

# PS1 is the prompt for your shell.
# This translates to '[USER@HOST /curr/dir]$ '
PS1='[${USER}@${HOST} ${PWD}]$ '

export vi vim ls sudo ruby gem PS1
