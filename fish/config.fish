if status is-interactive
	set fish_greeting
	set TERM "st"
	set EDITOR "nvim"
	set VISUAL "nvim"
	alias vim='nvim'
	alias vi='nvim'
end
# I build Go
export GOPATH=$HOME/.go
export PATH=$PATH:/usr/local/go/bin
