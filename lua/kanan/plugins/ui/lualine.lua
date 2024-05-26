return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		local colorscheme = vim.g.colors_name
		require("lualine").setup({
			options = {
				theme = colorscheme,
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
					{
						"diagnostics",
						symbols = {
							error = " ",
							warn = " ",
							hint = " ",
							info = " ",
						},
					},
				},
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = {
					function()
						return " " .. os.date("%p %I:%M:%S")
					end,
				},
			},
		})
	end,
}
