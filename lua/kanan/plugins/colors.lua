return {
	{
		"navarasu/onedark.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		opts = {
			style = "deep",
		},
		config = function(_, opts)
			require("onedark").setup(opts)
			vim.cmd("colorscheme onedark")
		end,
	},
	{
		"craftzdog/solarized-osaka.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {},
		config = function(_, opts)
			require("solarized-osaka").setup(opts)
			vim.cmd("colorscheme solarized-osaka")
		end,
	},
}
