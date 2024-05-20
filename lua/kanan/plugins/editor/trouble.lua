return {
	"folke/trouble.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "TroubleToggle", "Trouble" },
	opts = { height = 20, use_diagnostic_signs = true },
	keys = {
		{
			"<leader>xr",
			function()
				require("trouble").toggle()
			end,
			desc = "Root Dir Diagnostics (Trouble)",
		},
		{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
		{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
		{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location Lit (Trouble)" },
		{ "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
		{
			"[q",
			function()
				if require("trouble").is_open() then
					require("trouble").previous({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cprev)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Previous Trouble/Quickfix Item",
		},
		{
			"]q",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cnext)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Next Trouble/Quickfix Item",
		},
	},
}
