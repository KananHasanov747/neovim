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
	{ import = "kanan.plugins.ui" },
	{ import = "kanan.plugins.editor" },
	{ import = "kanan.plugins.util" },
	{ import = "kanan.plugins.lsp" },
	{ import = "kanan.plugins.coding" },
}, {
	enabled = false,
	defaults = {
		lazy = true,
		version = false, -- if use stable (that is, "*"), it'll break the neovim config
	},
	install = {
		colorscheme = { "onedark" }, -- TODO: use vim.g.colors_name
	},
	checker = {
		enabled = true,
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
})
