if status is-interactive
	set -U fish_greeting
end

alias emacs="emacs --no-x-resources"
alias ruby="ruby30"
alias rake="rake30"
alias gem="gem30"

set -x GOPATH "$HOME/.go"
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin
