return {
  "nvimtools/none-ls.nvim",
  enabled = false, -- false if conform.nvim (formatting.lua) is enabled
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
      }
    })
  end
}
