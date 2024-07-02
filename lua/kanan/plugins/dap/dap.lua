-- TODO: fix dap and add new features
return {
	"mfussenegger/nvim-dap",
	enabled = false,
	event = "VeryLazy",
	ft = { "python" },
	dependencies = {
		{ "mfussenegger/nvim-dap-python" },
		{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
		{ "nvim-telescope/telescope-dap.nvim" },
	},
	config = function()
		require("telescope").load_extension("dap")
		require("dap-python").setup("python3")

		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup({
			layouts = {
				{
					elements = {
						{ id = "breakpoints", size = 0.15 },
						{ id = "stacks", size = 0.3 },
						{ id = "watches", size = 0.25 },
						{ id = "scopes", size = 0.3 },
					},
					position = "right",
					size = math.floor(vim.o.columns / 3),
				},
				{
					elements = {
						"repl",
						"console",
					},
					size = math.floor(vim.o.lines / 5),
					position = "bottom",
				},
			},
		})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
}
