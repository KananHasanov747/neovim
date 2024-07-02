return {
	"akinsho/toggleterm.nvim",
	enabled = false,
	cmd = "ToggleTerm",
	event = "VeryLazy",
	opts = {
		size = 20,
	},
	config = function(_, opts)
		local toggleterm = require("toggleterm")

		vim.keymap.set("n", "<leader>t-", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })

		toggleterm.setup(opts)
	end,
}
