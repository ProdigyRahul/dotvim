return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  config = function()
    require("neo-tree").setup({
      open_files_in_last_window = true,  -- KEY FIX: Open in last window, keeps buffers
      open_files_do_not_replace_types = { "terminal", "trouble", "qf", "edgy" },
      window = {
        position = "right",
        width = 35,
        mappings = {
          ["<cr>"] = "open",
          ["s"] = "open_vsplit",
          ["S"] = "open_split",
          ["t"] = "open_tabnew",
          ["P"] = { "toggle_preview", config = { use_float = true } },
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- Show hidden files by default
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            -- ".git",
            -- "node_modules",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
        follow_current_file = {
          enabled = true, -- Highlight current file in tree
        },
      },
    })

    vim.keymap.set('n', '<C-n>', ':Neotree toggle position=right<CR>', {})
  end
}
