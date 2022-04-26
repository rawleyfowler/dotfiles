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

# PS1 is ripped straight from my .bashrc, it works just fine.
PS1='[\e[0;32m\u\e[m@\e[0;33m\h\e[m \W]\e[0;33m\$\e[m '

export vi vim ls sudo ruby gem PS1
