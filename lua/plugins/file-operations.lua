return {
  -- File operation utilities
  config = function()
    -- Safe file deletion with confirmation and trash support
    local function delete_file(use_trash)
      local file = vim.fn.expand("%:p")
      if file == "" then
        vim.notify("No file to delete", vim.log.levels.WARN)
        return
      end
      
      local choice = vim.fn.confirm("Delete " .. vim.fn.expand("%:t") .. "?", "&Yes\n&No", 2)
      if choice == 1 then
        local buf = vim.api.nvim_get_current_buf()
        
        -- Try to use trash if available and requested
        local delete_cmd
        if use_trash then
          -- Check if trash-cli is installed
          if vim.fn.executable("trash") == 1 then
            delete_cmd = "trash"
          elseif vim.fn.executable("gio") == 1 then
            delete_cmd = "gio trash"
          else
            -- Fallback to rm if no trash available
            delete_cmd = "rm"
            vim.notify("Trash not available, using rm", vim.log.levels.WARN)
          end
        else
          delete_cmd = "rm"
        end
        
        -- Execute deletion
        local result = vim.fn.system(delete_cmd .. " " .. vim.fn.shellescape(file))
        
        if vim.v.shell_error == 0 then
          vim.notify("Deleted: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
          -- Close buffer without saving
          vim.cmd("bdelete! " .. buf)
        else
          vim.notify("Failed to delete file: " .. result, vim.log.levels.ERROR)
        end
      end
    end
    
    -- Telescope extension for file deletion
    local function telescope_delete_file()
      local action_state = require("telescope.actions.state")
      local actions = require("telescope.actions")
      
      local function delete_selection(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if not selection then
          vim.notify("No file selected", vim.log.levels.WARN)
          return
        end
        
        local file = selection.path or selection.filename or selection.value
        if not file then
          vim.notify("Cannot determine file path", vim.log.levels.ERROR)
          return
        end
        
        local choice = vim.fn.confirm("Delete " .. vim.fn.fnamemodify(file, ":t") .. "?", "&Yes\n&No", 2)
        if choice == 1 then
          -- Use trash if available
          local delete_cmd = "rm"
          if vim.fn.executable("trash") == 1 then
            delete_cmd = "trash"
          elseif vim.fn.executable("gio") == 1 then
            delete_cmd = "gio trash"
          end
          
          local result = vim.fn.system(delete_cmd .. " " .. vim.fn.shellescape(file))
          
          if vim.v.shell_error == 0 then
            vim.notify("Deleted: " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.INFO)
            -- Refresh telescope
            actions.close(prompt_bufnr)
            vim.cmd("Telescope find_files")
          else
            vim.notify("Failed to delete file: " .. result, vim.log.levels.ERROR)
          end
        end
      end
      
      return delete_selection
    end
    
    -- Keymaps for file deletion
    
    -- Delete current file (with trash)
    vim.keymap.set("n", "<leader>df", function() delete_file(true) end, { desc = "Delete file (trash)" })
    
    -- Force delete current file (permanent)
    vim.keymap.set("n", "<leader>dF", function() delete_file(false) end, { desc = "Delete file (permanent)" })
    
    -- Quick delete without confirmation (be careful!)
    vim.keymap.set("n", "<leader>d!", function()
      local file = vim.fn.expand("%:p")
      if file ~= "" then
        vim.cmd("!trash " .. vim.fn.shellescape(file) .. " 2>/dev/null || rm " .. vim.fn.shellescape(file))
        vim.cmd("bdelete!")
        vim.notify("Deleted: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
      end
    end, { desc = "Quick delete (no confirm)" })
    
    -- Telescope integration
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        mappings = {
          n = {
            ["<leader>df"] = telescope_delete_file(),
            ["dd"] = telescope_delete_file(),
          },
          i = {
            ["<C-d>"] = telescope_delete_file(),
          }
        }
      }
    })
    
    -- Alternative: Create/Delete files with oil.nvim (already installed!)
    -- When in oil.nvim buffer:
    -- - dd on a line to mark for deletion
    -- - :w to execute deletions (moves to trash by default)
    -- - Create files by just typing a new filename and :w
    
    vim.keymap.set("n", "<leader>o-", function()
      require("oil").open()
      vim.notify("Use 'dd' to delete files, then ':w' to confirm", vim.log.levels.INFO)
    end, { desc = "Open oil for file operations" })
    
    -- Batch operations helper
    vim.api.nvim_create_user_command("DeleteMatching", function(opts)
      local pattern = opts.args
      if pattern == "" then
        vim.notify("Usage: :DeleteMatching *.tmp", vim.log.levels.ERROR)
        return
      end
      
      local files = vim.fn.glob(pattern, false, true)
      if #files == 0 then
        vim.notify("No files matching: " .. pattern, vim.log.levels.WARN)
        return
      end
      
      local choice = vim.fn.confirm("Delete " .. #files .. " files matching '" .. pattern .. "'?", "&Yes\n&No", 2)
      if choice == 1 then
        for _, file in ipairs(files) do
          vim.fn.system("trash " .. vim.fn.shellescape(file) .. " 2>/dev/null || rm " .. vim.fn.shellescape(file))
        end
        vim.notify("Deleted " .. #files .. " files", vim.log.levels.INFO)
      end
    end, {
      nargs = 1,
      complete = "file"
    })
  end,
}