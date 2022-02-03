call plug#begin()
	Plug 'jiangmiao/auto-pairs'
	Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
	Plug 'arzg/vim-swift', { 'for': 'swift' }
	Plug 'tyru/open-browser.vim'
	Plug 'junegunn/vim-easy-align'
	Plug 'preservim/NERDTree', { 'on': 'NERDTreeToggle' }
	Plug 'itchyny/lightline.vim'
	Plug 'tpope/vim-surround'
	Plug 'arzg/vim-colors-xcode'
	Plug 'srcery-colors/srcery-vim'
	Plug 'sainnhe/gruvbox-material'
	Plug 'https://github.com/KabbAmine/yowish.vim'
	Plug 'https://github.com/ap/vim-css-color'
	Plug 'neoclide/coc.nvim'
	Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
	Plug 'ap/vim-buftabline'
	Plug 'dracula/vim'
call plug#end()
colorscheme dracula
set bg=dark
syntax on
set ai
set number
set ts=2
set sw=2
set t_Co=256
set background=dark
set nowrap
nmap <C-h> :bp<cr>
nmap <C-l> :bn<cr>
nmap <C-q> :Bclose<cr>
nmap <S-w> :NERDTreeToggle<cr>
inoremap <expr> <Tab>	pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<Tab>" : "\<cr>"
