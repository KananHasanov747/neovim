return {
	"mfussenegger/nvim-lint",
	enabled = false,
	event = { "InsertLeave", "BufWritePost" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			python = { "mypy" },
		}
	end,
}
