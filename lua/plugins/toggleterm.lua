return {
  'akinsho/toggleterm.nvim',
  version = "*",
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal float" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal horizontal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal vertical" },
    { "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", desc = "Terminal tab" },
  },
  config = function()
    require("toggleterm").setup({
      -- Size can be a number or function
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      
      -- Open mapping (works in terminal mode)
      open_mapping = [[<C-\>]],
      
      -- Hide line numbers in terminal
      hide_numbers = true,
      
      -- Shade terminal background
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2, -- Darker background
      
      -- Start in insert mode
      start_in_insert = true,
      
      -- Insert mode mappings
      insert_mappings = true,
      
      -- Terminal mode mappings
      terminal_mappings = true,
      
      -- Persist terminal size
      persist_size = true,
      persist_mode = true,
      
      -- Default direction: 'vertical' | 'horizontal' | 'tab' | 'float'
      direction = 'float',
      
      -- Close terminal on exit
      close_on_exit = true,
      
      -- Shell to use
      shell = vim.o.shell,
      
      -- Auto scroll to bottom on terminal output
      auto_scroll = true,
      
      -- Float terminal specific config
      float_opts = {
        border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved'
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      
      -- Window bar configuration
      winbar = {
        enabled = false,
        name_formatter = function(term)
          return term.name
        end
      },
    })
    
    -- Terminal keymaps
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      -- Navigation between windows from terminal
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      -- Exit terminal mode with ESC (but still allow ESC to be sent to terminal)
      vim.keymap.set('t', '<C-x>', [[<C-\><C-n>]], opts)
      -- Send ESC to terminal
      vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], opts)
    end
    
    -- Auto command to set terminal keymaps
    vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
    
    -- Lazygit integration
    local Terminal = require('toggleterm.terminal').Terminal
    
    -- Lazygit terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
        width = function()
          return math.floor(vim.o.columns * 0.95)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.95)
        end,
      },
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })
    
    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end
    
    -- Node terminal
    local node = Terminal:new({
      cmd = "node",
      direction = "float",
      hidden = true,
    })
    
    function _NODE_TOGGLE()
      node:toggle()
    end
    
    -- Python terminal
    local python = Terminal:new({
      cmd = "python3",
      direction = "float",
      hidden = true,
    })
    
    function _PYTHON_TOGGLE()
      python:toggle()
    end
    
    -- Htop terminal
    local htop = Terminal:new({
      cmd = "htop",
      direction = "float",
      hidden = true,
      float_opts = {
        border = "double",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },
    })
    
    function _HTOP_TOGGLE()
      htop:toggle()
    end
    
    -- Custom terminal keymaps
    vim.keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Lazygit" })
    vim.keymap.set("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Node terminal" })
    vim.keymap.set("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Python terminal" })
    vim.keymap.set("n", "<leader>tH", "<cmd>lua _HTOP_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Htop" })
    
    -- Send lines to terminal
    vim.keymap.set("v", "<leader>ts", function()
      require('toggleterm').send_lines_to_terminal("visual_selection", true, { args = vim.v.count })
    end, { desc = "Send selection to terminal" })
    
    -- Multiple terminals management
    vim.keymap.set("n", "<leader>t1", "<cmd>1ToggleTerm<cr>", { desc = "Terminal 1" })
    vim.keymap.set("n", "<leader>t2", "<cmd>2ToggleTerm<cr>", { desc = "Terminal 2" })
    vim.keymap.set("n", "<leader>t3", "<cmd>3ToggleTerm<cr>", { desc = "Terminal 3" })
    vim.keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", { desc = "Toggle all terminals" })

    -- New terminal in tab (always creates new instance)
    vim.keymap.set("n", "<leader>tT", function()
      local terms = require("toggleterm.terminal").get_all()
      local next_id = #terms + 1
      vim.cmd(next_id .. "ToggleTerm direction=tab")
    end, { desc = "New terminal in tab" })
  end,
}