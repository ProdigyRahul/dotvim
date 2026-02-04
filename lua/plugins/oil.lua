return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    { "<leader>-", function() require("oil").toggle_float() end, desc = "Oil float" },
  },
  config = function()
    require("oil").setup({
      -- Replace netrw as default file explorer
      default_file_explorer = true,
      
      -- Column configuration
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      
      -- Buffer-specific options
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      
      -- Window-specific options
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      
      -- Delete files to trash instead of permanently
      delete_to_trash = true,
      
      -- Skip confirmation for simple operations
      skip_confirm_for_simple_edits = false,
      
      -- Selecting a new/moved/renamed file will prompt to save
      prompt_save_on_select_new_entry = true,
      
      -- Oil will automatically delete hidden buffers after this delay
      cleanup_delay_ms = 2000,
      
      -- Keymaps in oil buffer
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      
      view_options = {
        -- Show hidden files by default
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          return name == ".." or name == ".git"
        end,
        -- Natural sorting (10 comes after 9, not after 1)
        natural_order = true,
        sort = {
          -- Sort order (can be "asc" or "desc")
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      
      -- Configuration for floating window
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
      
      -- Configuration for the preview window
      preview = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        update_on_cursor_moved = true,
      },
      
      -- Configuration for the progress window
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
      
      -- Configuration for SSH servers
      ssh = {
        border = "rounded",
      },
      
      -- Configuration for keymaps help window
      keymaps_help = {
        border = "rounded",
      },
    })
    
  end,
}