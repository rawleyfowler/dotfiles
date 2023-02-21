if status is-interactive
	set -U fish_greeting
end

set -x GEM_HOME "$HOME/.local/ruby"
set -x GOPATH "$HOME/.go"
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin $HOME/.local/ruby/bin

alias vim="nvim"
alias vi="nvim"
