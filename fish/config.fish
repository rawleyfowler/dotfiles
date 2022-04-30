# Rawley Fowlers, config.fish. Last updated: April 30th, 2022

if status is-interactive
	set fish_greeting
	set TERM "st"
	set EDITOR "nvim"
	set VISUAL "nvim"
	alias vim='nvim'
	alias vi='nvim'
end

# Paths
set GOPATH $HOME/.go
set PATH $PATH /usr/local/bin /usr/bin /bin /usr/local/go/bin
