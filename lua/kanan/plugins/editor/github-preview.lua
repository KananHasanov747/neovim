return {
	"wallpants/github-preview.nvim",
	cmd = { "GithubPreviewToggle" },
	keys = { "<leader>mpt" },
	opts = {
		host = "localhost",
		port = 8888,
		single_file = false,
		theme = {
			name = "system",
			high_contrast = false,
		},
		scroll = {
			disable = true,
		},
	},
	config = function(_, opts)
		local gpreview = require("github-preview")
		gpreview.setup(opts)

		-- TODO: which key can't see desc
		local fns = gpreview.fns
		vim.keymap.set("n", "<leader>mpt", fns.toggle, { desc = "Github Preview Toggle" })
		vim.keymap.set("n", "<leader>mps", fns.single_file_toggle, { desc = "Github Preview Single File" })
		vim.keymap.set("n", "<leader>mpd", fns.details_tags_toggle, { desc = "Github Preview Details Tags" })
	end,
}
