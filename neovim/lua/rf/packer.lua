vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	-- Packer
	use 'wbthomason/packer.nvim'

	-- Color theme/aesthetics
	use 'beikome/cosme.vim'
	use 'ajmwagar/vim-emoticons'

	-- tpope
	use 'tpope/vim-surround'
	use 'tpope/vim-rails'

	-- LSP
	use 'neovim/nvim-lsp'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'l3mon4d3/luasnip'
	use 'onsails/lspkind.nvim'

	-- Language specific
	use 'groenewege/vim-less'
	use 'vim-ruby/vim-ruby'
	use 'fatih/vim-go'

	-- Others
	use ('junegunn/fzf', { run = function() vim.fn['fzf#install'](0) end })
	use 'junegunn/fzf.vim'
	use 'ap/vim-css-color'
	use 'jiangmiao/auto-pairs'
	use 'docunext/closetag.vim'

	if packer_bootstrap then
		require('packer').sync()
	end
end)
