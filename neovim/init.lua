local set = vim.opt
local cmd = vim.api.nvim_command
local au = vim.api.nvim_create_autocmd
local plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
plug('https://gitlab.com/rawleyIfowler/melange')
plug('clojure-vim/clojure.vim', {['for'] = 'clojure'})
plug('scrooloose/nerdtree', {on = 'NERDTreeToggle'})
plug('tpope/vim-surround')
plug('tpope/vim-fireplace', {['for'] = 'clojure'})
plug('neovim/nvim-lsp')
plug('neovim/nvim-lspconfig')
plug('junegunn/goyo.vim', {['for'] = 'markdown'})
plug('junegunn/fzf', {['dir'] = '~/.fzf', ['do'] = './install --all'})
plug('junegunn/fzf.vim')
plug('jiangmiao/auto-pairs')
plug('guns/vim-clojure-highlight', {['for'] = 'clojure'})
plug('guns/vim-clojure-static', {['for'] = 'clojure'})
plug('luochen1990/rainbow', {['for'] = 'clojure'})
plug('docunext/closetag.vim')
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
vim.keymap.set('n', '', ':NERDTreeToggle')
vim.keymap.set('n', '', ':NERDTreeClose')
---- Ripgrep
vim.keymap.set('n', '', ':Rg')
-- Colors
vim.cmd('syntax enable')
vim.cmd('colorscheme melange')
vim.o.background = 'dark'
-- Clojure specific configurations
require('lspconfig')['clojure_lsp'].setup{}
local clj_augroup = vim.api.nvim_create_augroup('clj_cmds', {clear = true})
au('filetype', {
    pattern = { 'clojure', 'clj' },
    group = clj_augroup,
    desc = 'Change tab size for clojure files',
    callback = function()
        set.tabstop = 2
        set.shiftwidth = 2
        set.softtabstop = 2
    end
})
-- Go specific configurations
require('lspconfig')['gopls'].setup{}
-- C/C++ specific configurations
require('lspconfig')['clangd'].setup{}
