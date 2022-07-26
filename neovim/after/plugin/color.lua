vim.opt.background = 'dark'
vim.cmd('colorscheme cosme')
vim.g.airline_theme = 'cosme'

local cl = function(t, o)
	vim.api.nvim_set_hl(0, t, o)
end

cl('LineNr', {
	bg = '#222222',
})
