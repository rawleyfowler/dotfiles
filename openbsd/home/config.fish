if status is-interactive
  set -U fish_greeting
end
alias emacs="emacs --no-x-resources"

# set the workspace path
set -x GOPATH $HOME/.go
# add the go bin path to be able to execute our programs
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin
