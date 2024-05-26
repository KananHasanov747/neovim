return {
	"nvimdev/dashboard-nvim",
	lazy = false,
	-- event = "VimEnter",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	opts = function()
		local logo = [[
          ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗          Z
          ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║      Z    
          ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║   z       
          ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ z         
          ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║           
          ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝           
    ]]

		logo = string.rep("\n", 8) .. logo .. "\n\n"

		local opts = {
			theme = "doom",
			hide = {
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action =  function()
		        local utils = require("telescope.utils")
		        local builtin = require("telescope.builtin")

		        local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })

            if ret == 0 then
              builtin.git_files({ show_untracked = true })
            else
              builtin.find_files()
            end
          end,                                                                                       desc = " Find File",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                                            desc = " New File",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                                           desc = " Recent Files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                                                          desc = " Find Text",       icon = " ", key = "g" },
          -- { action = [[lua LazyVim.telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',                                            desc = " Restore Session", icon = " ", key = "s" },
          -- { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                                                         desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                                           desc = " Quit",            icon = " ", key = "q" },
        },
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
		end

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return opts
	end,
}
