local set = vim.opt
local cmd = vim.api.nvim_command
local au = vim.api.nvim_create_autocmd
local plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
-- You can use my custom melange build, un-comment here.
-- plug('https://gitlab.com/rawleyIfowler/melange')
-- Yeah I use gruvbox now :L
plug('morhetz/gruvbox')
plug('ap/vim-css-color')
plug('ap/vim-buftabline')
plug('dag/vim-fish')
plug('kassio/neoterm')
plug('tpope/vim-dispatch')
plug('radenling/vim-dispatch-neovim')
plug('clojure-vim/clojure.vim', {['for'] = 'clojure'})
plug('Olical/conjure', {['for'] = 'clojure'})
plug('tpope/vim-fireplace', {['for'] = 'clojure'})
plug('guns/vim-clojure-highlight', {['for'] = 'clojure'})
plug('guns/vim-clojure-static', {['for'] = 'clojure'})
plug('clojure-vim/vim-jack-in', {['for'] = 'clojure'})
plug('luochen1990/rainbow')
plug('scrooloose/nerdtree', { on = 'NERDTreeToggle'})
plug('fatih/vim-go', { ['for'] = 'go' })
plug('tree-sitter/tree-sitter')
plug('tpope/vim-surround')
plug('neovim/nvim-lsp')
plug('neovim/nvim-lspconfig')
plug('williamboman/nvim-lsp-installer')
plug('mfussenegger/nvim-jdtls')
plug('junegunn/goyo.vim', {['for'] = 'markdown'})
plug('junegunn/fzf', {['dir'] = '~/.fzf', ['do'] = './install --all'})
plug('junegunn/fzf.vim')
plug('jiangmiao/auto-pairs')
plug('docunext/closetag.vim')
plug('norcalli/nvim_utils')
plug('hrsh7th/nvim-cmp')
plug('hrsh7th/cmp-buffer')
plug('hrsh7th/cmp-nvim-lsp')
plug('saadparwaiz1/cmp_luasnip')
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
-- Colors
vim.cmd('syntax enable')
vim.cmd('colo gruvbox')
vim.o.background = 'light'
-- Rainbow Parens for Clojure, and Lisp
vim.cmd([[
filetype on
filetype plugin on
filetype plugin indent on
autocmd Filetype clojure,clj,lisp,lsp,cl,l :RainbowToggle
]])
-- Auto complete
local opts = { noremap=true, silent=true }
map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end
local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'clojure_lsp', 'gopls', 'clangd', 'tsserver' }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = cmp_capabilities,
        flags = {
            debounce_text_changes = 150,
        }
    }
end
-- Java auto complete/LSP
local jdtls_cfg = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', '~/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher.cocoa.macosx.x86_64_1.2.400.v20211117-0650.jar',
        '-configuration', '~/.local/share/nvim/lsp_servers/jdtls/config_mac'
    },
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
}
if vim.bo.filetype == 'java' then
    require('jdtls').start_or_attach(jdtls_cfg)
end
-- 2 Tab space standard languages
-- Clojure and Common Lisp style is 2 space indent
vim.cmd([[
autocmd Filetype clojure,clj,lisp,lsp,cl,l,javascript,js,typescript,ts setlocal tabstop=2 shiftwidth=2
]])
