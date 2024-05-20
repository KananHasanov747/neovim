return {
	{
		"echasnovski/mini.indentscope",
		enabled = false,
		event = "VeryLazy",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function()
			local indentscope = require("mini.indentscope")
			indentscope.setup({
				symbol = "│",
				options = { try_as_border = true },
				draw = {
					animation = function()
						return 0
					end,
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = {
			exclude = {
				filetypes = {
					"dashboard",
				},
			},
			scope = { enabled = false },
		},
	},
}
