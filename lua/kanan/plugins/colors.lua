return {
	"navarasu/onedark.nvim",
	lazy = false,
	opts = {
		style = "deep",
	},
	config = function(_, opts)
		require("onedark").setup(opts)
		vim.cmd("colorscheme onedark")
	end,
}
