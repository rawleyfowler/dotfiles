local M = {}

local function bind(operation, outer_operations)
	outer_operations = outer_operations or { noremap = true }
	return function(l, r, o)
		o = vim.tbl_extend('force',
			outer_operations,
			o or {}
		)
		vim.keymap.set(operation, l, r, o)
	end
end

M.nmap = bind('n', { noremap = false })
M.nnoremap = bind('n')
M.vnoremap = bind('v')
M.xnoremap = bind('x')
M.inoremap = bind('i')

return M
