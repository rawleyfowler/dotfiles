local set = vim.opt
local cmd = vim.api.nvim_command
local au = vim.api.nvim_create_autocmd
local plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
plug('https://gitlab.com/rawleyIfowler/melange')
plug('ap/vim-css-color')
plug('ap/vim-buftabline')
plug('dag/vim-fish')
plug('clojure-vim/clojure.vim', {['for'] = 'clojure'})
plug('scrooloose/nerdtree', { on = 'NERDTreeToggle'})
plug('fatih/vim-go', { ['for'] = 'go' })
plug('tree-sitter/tree-sitter')
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
plug('hrsh7th/nvim-cmp')
plug('hrsh7th/cmp-buffer')
plug('hrsh7th/cmp-nvim-lsp')
plug('l3mon4d3/luasnip')
plug('leafgarland/typescript-vim', {['for'] = 'typescript'})
vim.call('plug#end')
pcall(require, 'nvim_utils') 
local cmp = require('cmp')
-- Basic editor configurations
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.number = true
set.termguicolors = true
set.autoindent = true
set.autowrite = true
set.ai = true
set.wildignore = {'*/cache/*', '*/tmp*'}
-- Keybindings
function map(mode, lhs, rhs, opts)
    options = {}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
---- Cycling through buffers
map('n', '<C-h>', ':bprev<cr>', { noremap = true })
map('n', '<C-l>', ':bnext<cr>', { noremap = true })
---- NERDTree
map('n', '<S-w>', ':NERDTreeToggle<cr>', { noremap = true })
map('n', '<S-q>', ':NERDTreeClose<cr>', { noremap = true })
---- Ripgrep
map('n', '<C-f>', ':Rg<cr>')
---- Auto-complete
cmp.setup({
    snippet = {
        expand = function(a)
            -- Enable the lua snips engine
            require('luasnip').lsp_expand(a.body)
        end
    },

    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete()
    }),

    sources = {
        -- Get completions from these sources
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' }
    }
})
local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Colors
vim.cmd('syntax enable')
vim.cmd('colorscheme melange')
vim.o.background = 'dark'
-- Clojure/Common Lisp specific configurations
-- Clojure and Common Lisp style is 2 space indent
-- https://guide.clojure.style
vim.cmd([[
    filetype on
    filetype plugin on
    filetype plugin indent on
    autocmd Filetype clojure,clj,lisp,lsp,cl,l let g:rainbow_active=1 
]])
require('lspconfig')['clojure_lsp'].setup{ capabilities = cmp_capabilities }
-- Go specific configurations
require('lspconfig')['gopls'].setup{ capabilities = cmp_capabilities }
-- C/C++ specific configurations
require('lspconfig')['clangd'].setup{ capabilities = cmp_capabilities }
-- TypeScript specific configurations
require('lspconfig')['tsserver'].setup{ capabilities = cmp_capabilities }
-- 2 Tab space standard languages
vim.cmd([[
    autocmd Filetype clojure,clj,lisp,lsp,cl,l,javascript,js,typescript,ts setlocal tabstop=2 shiftwidth=2
]])
