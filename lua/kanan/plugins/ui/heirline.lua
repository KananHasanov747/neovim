-- heirline.nvim - alternative to bufferline.nvim and lualine.nvim
return {
	"rebelot/heirline.nvim",
	-- enabled = false,
	event = { "VimEnter", "BufWinEnter", "FileType" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- "Zeioth/heirline-components.nvim",
		"SmiteshP/nvim-navic",
		{ "lewis6991/gitsigns.nvim", opts = {} },
	},
	opts = function()
		local configs = require("kanan.configs.heirline")

		return configs
	end,
}
