set nocompatible

call plug#begin()
Plug 'folke/tokyonight.nvim'
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'ocaml/vim-ocaml', { 'for': 'ocaml' }
Plug 'reasonml-editor/vim-reason-plus', { 'for': 'reason' }
Plug 'rescript-lang/vim-rescript', { 'for': 'rescript' }
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'docunext/closetag.vim'
call plug#end()

syntax on

inoremap <silent><expr> <tab> 
            \ coc#pum#visible() ? coc#pum#next(1) : 
            \ CheckBackspace() ? "\<tab>" :
            \ coc#refresh()
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"
nnoremap <S-w> <cmd>Ex<cr>
nnoremap <C-f> <cmd>Rg<cr>
nnoremap <C-h> <cmd>bprev<cr>
nnoremap <C-l> <cmd>bnext<cr>

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

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

autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set nocursorline

highlight Normal guibg=NONE ctermbg=NONE
highlight Folded guibg=NONE ctermbg=NONE
highlight Question guibg=NONE ctermbg=NONE
highlight WildMenu guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE
