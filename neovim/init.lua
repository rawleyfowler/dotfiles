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
plug('norcalli/nvim_utils')
vim.call('plug#end')
pcall(require, 'nvim_utils') 
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
function nnoremap(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
---- NERDTree
nnoremap('n', '<S-w>', ':NERDTreeToggle<cr>')
nnoremap('n', '<S-q>', ':NERDTreeClose<cr>')
---- Ripgrep
nnoremap('n', '<C-f>', ':Rg<cr>')
-- Colors
vim.cmd('syntax enable')
vim.cmd('colorscheme melange')
vim.o.background = 'dark'
-- Clojure/Common Lisp specific configurations
-- Clojure and Common Lisp style is 2 space indent
-- https://guide.clojure.style
vim.cmd([[
    au FileType clojure,clj,lisp,cl,l call rainbow#load()
    let fts=['clojure', 'clj', 'lisp', 'lsp', 'cl', 'l']
    if index(fts, &filetype) != -1
        set ts=2
        set sw=2
        :RainbowToggle
    endif
]])
require('lspconfig')['clojure_lsp'].setup{}
-- Go specific configurations
require('lspconfig')['gopls'].setup{}
-- C/C++ specific configurations
require('lspconfig')['clangd'].setup{}
