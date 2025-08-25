return {
  "smjonas/inc-rename.nvim",
  event = "LspAttach",
  config = function()
    require("inc_rename").setup({
      -- The command name for IncRename
      cmd_name = "IncRename",
      
      -- The highlight group used for highlighting the identifier
      hl_group = "Substitute",
      
      -- Whether to preview changes to other buffers if the identifier is found there
      preview_empty_name = false,
      
      -- Whether to show a message after renaming
      show_message = true,
      
      -- The type of the external input buffer to use (nil uses vim's default)
      -- Options: nil | "dressing" | "noice" | "snacks"
      input_buffer_type = nil,
      
      -- Callback function to run after renaming
      post_hook = nil,
      
      -- Whether to save the inc-rename command in the commandline history
      save_in_cmdline_history = true,
    })
    
    -- Basic keymap for renaming
    vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "LSP incremental rename" })
    
    -- Advanced keymap that pre-fills with current word
    vim.keymap.set("n", "<leader>rN", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true, desc = "LSP rename (prefilled)" })
    
    -- Visual mode support (rename selected text)
    vim.keymap.set("v", "<leader>rn", function()
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")
      
      -- Get the selected text
      local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
      if #lines == 0 then return end
      
      local selected_text
      if #lines == 1 then
        selected_text = string.sub(lines[1], start_pos[3], end_pos[3])
      else
        selected_text = vim.fn.expand("<cword>")
      end
      
      vim.cmd("IncRename " .. selected_text)
    end, { desc = "LSP rename selection" })
    
    -- Integration with noice.nvim if available
    local has_noice = pcall(require, "noice")
    if has_noice then
      require("inc_rename").setup({
        input_buffer_type = "noice",
      })
    end
    
    -- Set up highlight for live preview
    vim.api.nvim_set_hl(0, "IncRenamePreview", { 
      background = vim.api.nvim_get_hl(0, { name = "Visual" }).background,
      foreground = vim.api.nvim_get_hl(0, { name = "WarningMsg" }).foreground,
    })
    
    -- Optional: Override default highlight group
    -- require("inc_rename").setup({
    --   hl_group = "IncRenamePreview",
    -- })
    
    -- Optional: Post-rename hook example
    -- require("inc_rename").setup({
    --   post_hook = function(opts)
    --     vim.notify("Renamed: " .. opts.old_name .. " → " .. opts.new_name, vim.log.levels.INFO)
    --   end,
    -- })
  end,
}