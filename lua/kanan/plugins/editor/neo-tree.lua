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
					require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
				end,
				desc = "Explorer Neotree (Root dir)",
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
		opts = function()
			local git_available = vim.fn.executable("git") == 1
			-- TODO: indentation in "buffers" and "git_status" from left
			local sources = {
				{ source = "filesystem", display_name = "" .. " File" },
				{ source = "buffers", display_name = "󰈙" .. " Bufs" },
				-- { source = "diagnostics", display_name = "󰒡" .. " Diagnostic" },
				{ source = "git_status", display_name = "󰊢" .. " Git" },
			}
			-- if git_available then
			-- 	table.insert(sources, 3, { source = "git_status", display_name = "󰊢" .. " Git" })
			-- end
			return {
				enable_diagnostics = true,
				sources = { "filesystem", "buffers", "git_status" }, --  diagnostics, document_symbols
				-- TODO: buffer keymaps don't work
				source_selector = { -- tabs in neo-tree
					winbar = true,
					content_layout = "center",
					sources = sources,
				},
				open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
				filesystem = {
					bind_to_cwd = false,
					follow_current_file = { enabled = true },
					use_libuv_file_watcher = true,
				},
				default_component_configs = {
					-- indent = {
					-- 	padding = 0,
					-- 	expander_collapsed = "",
					-- 	expander_expanded = "",
					-- },
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "",
						folder_empty_open = "",
						default = "󰈙",
					},
					modified = { symbol = "" },
					git_status = {
						symbols = {
							added = "",
							deleted = "",
							modified = "",
							renamed = "➜",
							untracked = "★",
							ignored = "◌",
							unstaged = "✗",
							staged = "✓",
							conflict = "",
						},
					},
				},
				window = {
					width = 30,
					mappings = {
						["[b"] = "prev_source",
						["]b"] = "next_source",
					},
				},
			}
		end,
	},
}
