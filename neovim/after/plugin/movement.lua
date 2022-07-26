local nnoremap = require('rf.binds').nnoremap
local nmap = require('rf.binds').nmap

-- Buffer cycling
nnoremap('<C-h>', ':bprev<cr>')
nnoremap('<C-l>', ':bnext<cr>')

-- Fuzzy finder (fzf)
nmap('<C-f>', ':Rg<cr>')

-- NetRW
nnoremap('<S-w>', ':Ex<cr>')
