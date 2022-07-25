local nnoremap = require('rf.binds').nnoremap
local inoremap = require('rf.binds').inoremap

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- cmp
local cmp = require('cmp')
local source_mapping = {
	buffer = '[Buffer]',
	nvim_lsp = '[LSP]',
	nvim_lua = '[Lua]',
	cmp_tabnine = '[TN]',
	path = '[Path]',
}

local lspkind = require('lspkind')

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
	}),

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			if entry.source.name == "cmp_tabnine" then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. " " .. menu
				end
				vim_item.kind = ""
			end
			vim_item.menu = menu
			return vim_item
		end,
	},

	sources = {
		{ name = "cmp_tabnine" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
	},
})

local function config(conf)
	return vim.tbl_deep_extend('force', {
		capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attch = function()
			inoremap('<C-h>', function() vim.lsp.buf.signature_help() end)
		end,
	}, conf or {})
end

-- LSP configurations
local simple_language_servers = { 'tsserver', 'solargraph' }

for _, v in ipairs(simple_language_servers) do
	require('lspconfig')[v].setup(config())
end

require('lspconfig').gopls.setup(config({
	cmd = { 'gopls', 'serve' },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}));

-- Lua snip
local snippets_paths = function()
	local plugs = { 'friendly-snippets' }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. '/.vim/plugged/'

	for _, plug in ipairs(plugs) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require('luasnip.loaders.from_vscode').lazy_load({
	paths = snippets_paths(),
	include = nil,
	exclude = {},
})
