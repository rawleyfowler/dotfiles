call plug#begin('~/.config/nvim/autoload/plugged')
	Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
	Plug 'junegunn/fzf.vim'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'romgrk/barbar.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'airblade/vim-rooter'
	Plug 'rktjmp/lush.nvim'
	Plug 'Mofiqul/dracula.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'sheerun/vim-polyglot'
	Plug 'scrooloose/NERDTree'
	Plug 'jiangmiao/auto-pairs'
	Plug 'tpope/vim-fugitive'
	Plug 'scrooloose/syntastic'
	Plug 'leafgarland/typescript-vim'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
lua << END
require'lualine'.setup()
END
