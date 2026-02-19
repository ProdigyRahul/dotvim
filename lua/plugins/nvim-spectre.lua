return {
  "nvim-pack/nvim-spectre",
  cmd = { "Spectre" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
    { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Search current word" },
    { "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', mode = "v", desc = "Search current selection" },
    { "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Search in current file" },
  },
  config = function()
    local excluded_dirs = {
      "node_modules",
      ".git",
      "dist",
      "build",
      ".next",
      "__pycache__",
      ".cache",
      ".pytest_cache",
      "coverage",
    }

    local rg_args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    }
    for _, dir in ipairs(excluded_dirs) do
      table.insert(rg_args, "--glob")
      table.insert(rg_args, "!" .. dir .. "/*")
    end

    require('spectre').setup({
      -- Color devicons
      color_devicons = true,
      
      -- Open command
      open_cmd = 'vnew',
      
      -- Live update when typing (can be slow on large projects)
      live_update = false,
      
      -- Show line number for search results
      lnum_for_results = false,
      
      -- Line separator style
      line_sep_start = '┌-----------------------------------------',
      result_padding = '¦  ',
      line_sep       = '└-----------------------------------------',
      
      -- Highlight groups
      highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete"
      },
      
      -- Keymaps
      mapping = {
        -- Toggle line
        ['toggle_line'] = {
          map = "dd",
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "toggle current item"
        },
        -- Enter file
        ['enter_file'] = {
          map = "<cr>",
          cmd = "<cmd>lua require('spectre').enter_file()<CR>",
          desc = "goto current file"
        },
        -- Send to quickfix
        ['send_to_qf'] = {
          map = "<leader>q",
          cmd = "<cmd>lua require('spectre').send_to_qf()<CR>",
          desc = "send all items to quickfix"
        },
        -- Replace command
        ['replace_cmd'] = {
          map = "<leader>c",
          cmd = "<cmd>lua require('spectre').replace_cmd()<CR>",
          desc = "input replace command"
        },
        -- Show options
        ['show_option_menu'] = {
          map = "<leader>o",
          cmd = "<cmd>lua require('spectre').show_options()<CR>",
          desc = "show options"
        },
        -- Run current replace
        ['run_current_replace'] = {
          map = "<leader>rc",
          cmd = "<cmd>lua require('spectre').run_current_replace()<CR>",
          desc = "replace current line"
        },
        -- Run replace
        ['run_replace'] = {
          map = "<leader>R",
          cmd = "<cmd>lua require('spectre').run_replace()<CR>",
          desc = "replace all"
        },
        -- Change view mode
        ['change_view_mode'] = {
          map = "<leader>v",
          cmd = "<cmd>lua require('spectre').change_view()<CR>",
          desc = "change result view mode"
        },
        -- Change replace method
        ['change_replace_sed'] = {
          map = "trs",
          cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
          desc = "use sed to replace"
        },
        ['change_replace_oxi'] = {
          map = "tro",
          cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
          desc = "use oxi to replace"
        },
        -- Toggle ignore case
        ['toggle_ignore_case'] = {
          map = "ti",
          cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
          desc = "toggle ignore case"
        },
        -- Toggle ignore hidden
        ['toggle_ignore_hidden'] = {
          map = "th",
          cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
          desc = "toggle search hidden"
        },
        -- Resume last search
        ['resume_last_search'] = {
          map = "<leader>l",
          cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
          desc = "resume last search"
        },
      },
      
      -- Find engine (ripgrep)
      find_engine = {
        ['rg'] = {
          cmd = "rg",
          args = rg_args,
          options = {
            ['ignore-case'] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case"
            },
            ['hidden'] = {
              value = "--hidden",
              desc = "hidden file",
              icon = "[H]"
            },
            ['line'] = {
              value = "-x",
              desc = "only match whole line",
              icon = "[L]"
            },
            ['word'] = {
              value = "-w",
              desc = "only match whole word",
              icon = "[W]"
            },
          }
        },
      },
      
      -- Replace engine
      replace_engine = {
        ['sed'] = {
          cmd = "sed",
          args = nil,
          options = {
            ['ignore-case'] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case"
            },
          }
        },
        ['oxi'] = {
          cmd = 'oxi',
          args = {},
          options = {
            ['ignore-case'] = {
              value = "-i",
              icon = "[I]",
              desc = "ignore case"
            },
          }
        }
      },
      
      -- Default options
      default = {
        find = {
          cmd = "rg",
          options = { "ignore-case" }
        },
        replace = {
          cmd = "sed"
        }
      },
      
      -- Replace command (for vim command)
      replace_vim_cmd = "cdo",
      
      -- Auto open target window
      is_open_target_win = true,
      
      -- Insert mode on open
      is_insert_mode = false,
      
      -- Block UI when processing
      is_block_ui_break = false,
    })
    
    -- Custom functions for common use cases
    
    -- Search in specific directory
    vim.keymap.set("n", "<leader>sd", function()
      require('spectre').open({
        cwd = vim.fn.input("Directory: ", vim.fn.getcwd() .. "/", "dir")
      })
    end, { desc = "Search in directory" })
    
    -- Search with file pattern
    vim.keymap.set("n", "<leader>sf", function()
      require('spectre').open({
        path = vim.fn.input("File pattern: ", "**/*.", "file")
      })
    end, { desc = "Search with file pattern" })
    
    -- Replace in current file only
    vim.keymap.set("n", "<leader>sr", function()
      require('spectre').open_file_search({
        select_word = true,
        path = vim.fn.expand("%:p")
      })
    end, { desc = "Replace in current file" })
    
    -- Search in git files only
    vim.keymap.set("n", "<leader>sg", function()
      require('spectre').open({
        cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
      })
    end, { desc = "Search in git repository" })
  end,
}
