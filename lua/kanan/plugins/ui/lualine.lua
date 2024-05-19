return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			options = {
				theme = vim.g.colors_name,
				disabled_filetypes = { statusline = { "dashboard" } },
			},
		})
	end,
}
