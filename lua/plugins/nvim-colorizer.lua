return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer" },
  config = function()
    require("colorizer").setup({
      -- Filetypes to enable colorizer
      filetypes = {
        "css", "scss", "sass", "less", "html",
        "javascript", "typescript", "javascriptreact", "typescriptreact",
        "!vim", -- Exclude vim files
        css = { -- Enable extra CSS features
          rgb_fn = true,
          hsl_fn = true,
          css = true,
        },
        html = {
          mode = "foreground", -- Use foreground for better visibility in HTML
        },
        javascript = {
          tailwind = true, -- Enable tailwind colors
        },
        typescript = {
          tailwind = true,
        },
        javascriptreact = {
          tailwind = true,
        },
        typescriptreact = {
          tailwind = true,
        },
      },
      
      -- Buffer types to exclude
      buftypes = {
        "!prompt",
        "!popup",
      },
      
      -- User commands
      user_commands = true, -- Enable :ColorizerToggle etc.
      
      -- Default options for all file types
      user_default_options = {
        -- Color name codes disabled for performance
        names = false,
        
        -- #RGB hex codes
        RGB = true,
        
        -- #RRGGBB hex codes
        RRGGBB = true,
        
        -- #RRGGBBAA hex codes
        RRGGBBAA = true,
        
        -- 0xAARRGGBB hex codes
        AARRGGBB = false,
        
        -- rgb() and rgba() functions
        rgb_fn = true,
        
        -- hsl() and hsla() functions
        hsl_fn = true,
        
        -- CSS features (includes rgb_fn and hsl_fn)
        css = true,
        
        -- CSS functions (includes all CSS color functions)
        css_fn = true,
        
        -- Display mode: 'background' | 'foreground' | 'virtualtext'
        mode = "background",
        
        -- Tailwind colors (false | 'normal' | 'lsp' | 'both')
        -- Using 'lsp' only for better performance
        tailwind = "lsp",
        
        -- Sass colors (object with 'enable' and 'parsers')
        sass = { 
          enable = true, 
          parsers = { "css" } 
        },
        
        -- Virtual text character (for virtualtext mode)
        virtualtext = "■",
        
        -- Virtual text highlight mode
        virtualtext_inline = true,
        
        -- Virtual text priority
        virtualtext_priority = 200,
        
        -- Always update colors (even in inactive buffers)
        always_update = false,
      },
    })
    
    -- Keymaps for quick toggling
    vim.keymap.set("n", "<leader>ct", "<cmd>ColorizerToggle<cr>", { desc = "Toggle colorizer" })
    vim.keymap.set("n", "<leader>ca", "<cmd>ColorizerAttachToBuffer<cr>", { desc = "Attach colorizer to buffer" })
    vim.keymap.set("n", "<leader>cd", "<cmd>ColorizerDetachFromBuffer<cr>", { desc = "Detach colorizer from buffer" })
    
    -- Function to reload colorizer (useful after changing config)
    vim.keymap.set("n", "<leader>cr", function()
      vim.cmd("ColorizerDetachFromBuffer")
      vim.cmd("ColorizerAttachToBuffer")
      vim.notify("Colorizer reloaded", vim.log.levels.INFO)
    end, { desc = "Reload colorizer" })
    
    -- Auto-enable for specific projects with heavy color usage
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = { "*.css", "*.scss", "*.sass", "*.less", "tailwind.config.*" },
      callback = function()
        require("colorizer").attach_to_buffer(0, {
          mode = "background",
          css = true,
          tailwind = "lsp",
        })
      end,
    })
    
    -- Performance optimization for large files
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
        if ok and stats and stats.size > max_filesize then
          require("colorizer").detach_from_buffer(0)
        end
      end,
    })
    
    -- Set up custom highlight groups for better visibility
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        -- Customize virtual text highlight if using virtualtext mode
        vim.api.nvim_set_hl(0, "ColorizerVirtualText", { 
          fg = vim.api.nvim_get_hl(0, { name = "Comment" }).foreground,
        })
      end,
    })
    
    -- Special configuration for Tailwind CSS files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "typescriptreact", "javascriptreact" },
      callback = function()
        -- Enhanced Tailwind support for React files
        require("colorizer").attach_to_buffer(0, {
          mode = "background",
          tailwind = "lsp",
          sass = { enable = false },
          virtualtext_inline = false,
        })
      end,
    })
    
    -- Optional: Command to switch between display modes
    vim.api.nvim_create_user_command("ColorizerMode", function(opts)
      local mode = opts.args
      if mode == "background" or mode == "foreground" or mode == "virtualtext" then
        require("colorizer").detach_from_buffer(0)
        require("colorizer").attach_to_buffer(0, { mode = mode })
        vim.notify("Colorizer mode changed to: " .. mode, vim.log.levels.INFO)
      else
        vim.notify("Invalid mode. Use: background, foreground, or virtualtext", vim.log.levels.ERROR)
      end
    end, {
      nargs = 1,
      complete = function()
        return { "background", "foreground", "virtualtext" }
      end,
    })
  end,
}