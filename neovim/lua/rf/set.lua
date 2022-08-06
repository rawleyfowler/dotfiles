local set = vim.opt

set.nu = true
set.tabstop = 2
set.shiftwidth = 2
set.hlsearch = false
set.incsearch = true
set.smartindent = true
set.wrap = false
set.encoding = 'utf-8'
set.guifont = 'Iosevka Nerd Font Mono 14'

vim.cmd([[
set rtp^="home/rf/.opam/default/share/ocp-indent/vim"
]])

-- Lower update time the better (ms)
set.updatetime = 50
