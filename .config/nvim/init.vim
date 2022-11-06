set nocompatible

call plug#begin()
Plug 'folke/tokyonight.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'ocaml/vim-ocaml', { 'for': 'ocaml' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'docunext/closetag.vim'
call plug#end()

syntax on

colo tokyonight

set guicursor="disable"
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
set nowrap
set termguicolors
set background=dark
set t_Co=256
