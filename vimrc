"Plug calls"
call plug#begin(has('vim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'preservim/NERDTree'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'git@github.com:Valloric/YouCompleteMe.git'
Plug 'mbbill/undotree'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/syntastic'
call plug#end()
"Mappings"
nmap <F3> :NERDTreeToggle<CR>
nmap <F2> :NERDTree-CD
"Sets"
colorscheme gruvbox
set background=dark
let NERDTreeShowHidden=1
set number
let mapleader=" "
set ai
set ls=2
set tabstop=4
set backup
set backupdir=~/.private/vimtmp/
set directory=~/.private/vimtmp/
set shiftwidth=4
set expandtab
set swapfile
set dir=~/.private/vimtmp/
let g:javascript_plugin_flow=1
let g:javascript_conceal_arrow_function='⇒'
set noerrorbells
set smartcase
set ignorecase
set nowrap
if executable('rg')
    let g:rg_derive_root='true'
endif
let g:ctrlp_user_command =['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
