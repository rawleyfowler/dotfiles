if status is-interactive
	set -U fish_greeting
end

alias emacs="emacs --no-x-resources"

set -x GEM_HOME "$HOME/.local/ruby"
set -x GEM_PATH "$HOME/.local/ruby/gems"
set -x GOPATH "$HOME/.go"
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin $HOME/.local/ruby/3.0/bin
