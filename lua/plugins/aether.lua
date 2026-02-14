return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        bg = "#0f110c",
        dark_bg = "#090a07",
        darker_bg = "#060705",
        lighter_bg = "#2c3027",

        fg = "#e8d4a6",
        dark_fg = "#cfc29a",
        light_fg = "#f2e6ca",
        bright_fg = "#fbf7ee",
        muted = "#838c76",

        red = "#d78951",
        yellow = "#b1b195",
        orange = "#c49d73",
        green = "#89ae97",
        cyan = "#aacabb",
        blue = "#97bfaf",
        purple = "#daad8b",
        brown = "#6b4e2e",

        bright_red = "#ecbb98",
        bright_yellow = "#d9d9c9",
        bright_green = "#bed4c7",
        bright_cyan = "#e2eee8",
        bright_blue = "#cfe3db",
        bright_purple = "#f2decf",

        accent = "#97bfaf",
        cursor = "#fbf7ee",
        foreground = "#fbf7ee",
        background = "#0f110c",
        selection = "#494f41",
        selection_foreground = "#0f110c",
        selection_background = "#fbf7ee",
      },
    },
    config = function(_, opts)
      local ok, aether = pcall(require, "aether")
      if ok and type(aether.setup) == "function" then
        aether.setup(opts)
      end
      vim.cmd.colorscheme("aether")
    end,
  },
}
