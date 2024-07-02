return {
	"CRAG666/code_runner.nvim",
	event = "VeryLazy",
	opts = {
		filetype = {
			python = {
				"python $filename",
			},
		},
	},
}
