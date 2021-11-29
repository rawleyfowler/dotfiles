"Plug"
source $HOME/.config/nvim/vim-plug/plugins.vim
"Sets"
set encoding=utf-8
set guicursor=i:block
set backupdir=~/.private/vimtmp/
set directory=~/.private/vimtmp/
set nobackup
set nowritebackup
set number
set cmdheight=2
set updatetime=200
set shortmess+=c
set signcolumn=yes
set hidden
set noerrorbells
set smartcase
set nowrap
set tabstop=2
set ls=2
set ai
"Mappings"
nmap <F3> :NERDTreeToggle<CR>
nmap <F2> :NERDTree-CD
nmap <C-l> :bn<cr>
nmap <C-h> :bp<cr>
nmap <A-;> :Rg<cr>
inoremap <silent><expr> <TAB>
					\ pumvisible() ? "\<C-n>" :
					\ <SID>check_back_space() ? "\<TAB>" :
					\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silet><expr> <cr> pumvisible() ? coc#_select_confirm()
                                           \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col-1] =~# '\s'
endfunction
