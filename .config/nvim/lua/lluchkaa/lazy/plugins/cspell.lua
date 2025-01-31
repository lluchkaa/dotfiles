return {
  "davidmh/cspell.nvim",
  enabled = false,
  dependencies = {
    "nvimtools/none-ls.nvim",
  },
  config = function()
    local cspell = require("cspell")
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        cspell.diagnostics.with({
          method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        }),
      },
    })
  end,
}
