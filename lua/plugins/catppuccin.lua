return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "mocha",
    transparent_background = true,
    term_colors = true,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      keywords = { "italic" },
      types = { "italic" },
    },
    -- Extra hue separation for TS/TSX so the buffer doesn't read as one color
    custom_highlights = function(colors)
      return {
        ["@type"] = { fg = colors.yellow },
        ["@type.builtin"] = { fg = colors.yellow, style = { "italic" } },
        ["@constructor"] = { fg = colors.sapphire },
        ["@parameter"] = { fg = colors.maroon, style = { "italic" } },
        ["@variable.parameter"] = { fg = colors.maroon, style = { "italic" } },
        ["@property"] = { fg = colors.lavender },
        ["@variable.member"] = { fg = colors.lavender },
        ["@tag"] = { fg = colors.red },
        ["@tag.attribute"] = { fg = colors.teal, style = { "italic" } },
        ["@tag.delimiter"] = { fg = colors.overlay2 },
        ["@punctuation.bracket"] = { fg = colors.overlay2 },
        ["@keyword.return"] = { fg = colors.pink, style = { "italic" } },
      }
    end,
    integrations = {
      blink_cmp = true,
      gitsigns = true,
      treesitter = true,
      notify = true,
      noice = true,
      neotree = true,
      telescope = { enabled = true },
      illuminate = { enabled = true, lsp = true },
      indent_blankline = { enabled = true },
      mini = { enabled = true, indentscope_color = "surface2" },
      mason = true,
      dap = true,
      dap_ui = true,
      flash = true,
      harpoon = true,
      lsp_trouble = true,
      which_key = true,
      semantic_tokens = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
