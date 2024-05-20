return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<leader>e",
				function()
					local cwd = vim.fn.getcwd()
					local git_root = vim.fs.find(".git", { path = cwd, upward = true })[1]

					require("neo-tree.command").execute({
						toggle = true,
						dir = git_root and vim.fn.fnamemodify(git_root, ":h") or cwd,
					})
				end,
				desc = "Explorer Neotree (Root dir)",
			},
			{
				"<leader>E",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
				end,
				desc = "Explorer Neotree (cwd)",
			},
			{
				"<leader>ge",
				function()
					require("neo-tree.command").execute({ source = "git_status", toggle = true })
				end,
				desc = "Git Explorer",
			},
			{
				"<leader>be",
				function()
					require("neo-tree.command").execute({ source = "buffers", toggle = true })
				end,
				desc = "Buffer Explorer",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		opts = {
			enable_diagnostics = true,
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			defaul_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "󰁕", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			},
		},
		config = function(_, opts)
			-- diagnostic signs are initialized in lsp/lspconfig.lua
			-- vim.diagnostic.config({
			-- 	signs = {
			-- 		text = {
			-- 			[vim.diagnostic.severity.ERROR] = " ",
			-- 			[vim.diagnostic.severity.WARN] = " ",
			-- 			[vim.diagnostic.severity.HINT] = " ",
			-- 			[vim.diagnostic.severity.INFO] = " ",
			-- 		},
			-- 	},
			-- })

			require("neo-tree").setup(opts)
		end,
	},
}
