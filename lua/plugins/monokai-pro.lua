return {
  "loctvl842/monokai-pro.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("monokai-pro").setup({
      transparent_background = true,
      terminal_colors = true,
      devicons = true,
      styles = {
        comment = { italic = true },
        keyword = { italic = true },
        type = { italic = true },
        storageclass = { italic = true },
        structure = { italic = true },
        parameter = { italic = true },
        annotation = { italic = true },
        tag_attribute = { italic = true },
      },
      filter = "spectrum",
      day_night = { enable = false },
      inc_search = "background",
      background_clear = {
        "float_win",
        "toggleterm",
        "telescope",
        "which-key",
        "renamer",
        "neo-tree",
        "notify",
        "nvim-tree",
        "bufferline",
      },
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
        },
        indent_blankline = {
          context_highlight = "default",
          context_start_underline = false,
        },
      },
    })
    vim.cmd.colorscheme("monokai-pro-spectrum")
  end,
}
