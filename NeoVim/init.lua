local set = vim.opt
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug('https://gitlab.com/rawleyIfowler/melange')
Plug('scrooloose/nerdtree', {on = 'NERDTreeToggle'})
Plug('tpope/vim-surround')
Plug('tpope/vim-fireplace', {['for'] = 'clojure'})
Plug('neovim/nvim-lsp')
Plug('neovim/nvim-lspconfig')
Plug('junegunn/goyo.vim', {['for'] = 'markdown'})
Plug('junegunn/fzf', {['dir'] = '~/.fzf', ['do'] = './install --all'})
Plug('junegunn/fzf.vim')
Plug('guns/vim-clojure-highlight', {['for'] = 'clojure'})
Plug('guns/vim-clojure-static', {['for'] = 'clojure'})
Plug('luochen1990/rainbow', {['for'] = 'clojure'})
Plug('docunext/closetag.vim')
vim.call('plug#end')
-- Basic editor configurations
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.number = true
set.termguicolors = true
set.autoindent = true
set.autowrite = true
set.ai = true
set.wildignore = {'*/cache/*', '*/tmp*'}
-- Keybindings
---- NERDTree
vim.keymap.set('n', '<S-w>', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<S-q>', ':NERDTreeClose<CR>')
---- Ripgrep
vim.keymap.set('n', '<C-f>', ':Rg<cr>')
-- Colors
vim.cmd('syntax enable')
vim.cmd('colorscheme melange')
vim.o.background = 'dark'
-- Clojure specific configurations
require('lspconfig')['clojure_lsp'].setup{}
if vim.bo.filetype == 'clojure' then
    set.tabstop = 2
    set.shiftwidth = 2
    set.softtabstop = 2
end
-- Go specific configurations
require('lspconfig')['gopls'].setup{}
-- C/C++ specific configurations
require('lspconfig')['clangd'].setup{}
