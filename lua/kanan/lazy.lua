local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "kanan.plugins" },
	{ import = "kanan.plugins.lsp" },
	-- { import = "kanan.plugins.ui" },
	-- { import = "kanan.plugins.util" },
	{ import = "kanan.plugins.coding" },
	-- { import = "kanan.plugins.editor" },
}, {
	defaults = {
		lazy = true,
		version = "*",
	},
	install = {
		colorscheme = { "onedark" },
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
})
