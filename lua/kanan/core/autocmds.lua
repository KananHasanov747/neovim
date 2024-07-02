local api = vim.api

-- nvim-lint autocmds
api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
	callback = function()
		local lint_status, lint = pcall(require, "lint")
		if lint_status then
			lint.try_lint()
		end
	end,
})

api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")
