return {
	"nvim-telescope/telescope.nvim",
	-- event = "VeryLazy",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			config = function(plugin)
				local ok, err = pcall(require("telescope").load_extension, "fzf")
				if not ok then
					local lib = plugin.dir
					if not vim.fs_stat(lib) then
						require("lazy").build({ plugins = { plugin }, show = false })
					end
				end
			end,
		},
	},
	keys = {
		{ "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
		{
			"<leader>ff",
			function()
				local cwd = vim.fn.getcwd()
				local git_root = vim.fs.find(".git", { path = cwd, upward = true })[1]
				local builtin = require("telescope.builtin")

				if git_root then
					builtin.git_files({
						show_untracked = true,
					})
				else
					builtin.find_files()
				end
			end,
			desc = "Find Files (Root Dir)",
		},
		{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
	},
	opts = function()
		local actions = require("telescope.actions")

		return {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				-- open files in the first window that is an actual file.
				-- use the current window if no other window is available.
				get_selection_window = function()
					local wins = vim.api.nvim_list_wins()
					table.insert(wins, 1, vim.api.nvim_get_current_win())
					for _, win in ipairs(wins) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].buftype == "" then
							return win
						end
					end
					return 0
				end,
				mappings = {
					n = {
						["q"] = actions.close,
					},
				},
			},
			-- optimizing the highlighting
			highlight = {
				enable = true,
				disable = function(_, buf)
					local max_filesize = 10000 * 1024 -- 10 MB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						vim.notify("Treesitter disabled")
						return true
					end
				end,
			},
		}
	end,
}
