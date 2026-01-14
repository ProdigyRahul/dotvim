return {
  "luckasRanarison/tailwind-tools.nvim",
  enabled = false, -- Disabled until plugin updates for Neovim 0.11
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    document_color = {
      enabled = true,
      kind = "inline",
      inline_symbol = "●",
      debounce = 200,
    },
    conceal = {
      enabled = false,
      symbol = "…",
      highlight = {
        fg = "#38BDF8",
      },
    },
    custom_filetypes = {},
  },
}