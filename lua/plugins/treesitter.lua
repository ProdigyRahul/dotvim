-- nvim-treesitter `main` branch: parsers are installed via require("nvim-treesitter").install()
-- and highlighting/folds/indent are enabled per-buffer with vim.treesitter.start().
local ensure_installed = {
  "c", "lua", "vim", "vimdoc", "query",
  "javascript", "typescript", "tsx",
  "html", "css", "scss", "json", "yaml",
  "markdown", "markdown_inline",
  "bash", "dockerfile", "gitignore",
  "python", "rust", "go",
}

-- Filetypes covered by the parsers above (parser name != filetype for some)
local ts_filetypes = {
  "c", "lua", "vim", "help", "query",
  "javascript", "javascriptreact", "typescript", "typescriptreact",
  "html", "css", "scss", "json", "yaml",
  "markdown",
  "sh", "bash", "dockerfile", "gitignore",
  "python", "rust", "go",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      -- Only install missing parsers: install() re-verifies everything it is
      -- given (spawning processes), which costs ~150ms if run unconditionally.
      local installed = {}
      for _, p in ipairs(require("nvim-treesitter.config").get_installed()) do
        installed[p] = true
      end
      local missing = vim.tbl_filter(function(p)
        return not installed[p]
      end, ensure_installed)
      if #missing > 0 then
        require("nvim-treesitter").install(missing)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("RahulTreesitterStart", { clear = true }),
        pattern = ts_filetypes,
        callback = function(ev)
          -- Deferred: first-time query compilation for a language costs ~150ms,
          -- so let the buffer render immediately and attach highlighting after.
          vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(ev.buf) then
              return
            end
            -- Native treesitter highlighting (replaces slow regex syntax)
            if not pcall(vim.treesitter.start, ev.buf) then
              return -- parser not installed (yet); regex syntax stays as fallback
            end
            -- Treesitter-based indentation
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            -- Treesitter-based folds (z* shortcuts), window-local for windows
            -- currently showing this buffer
            for _, win in ipairs(vim.fn.win_findbuf(ev.buf)) do
              vim.wo[win][0].foldmethod = "expr"
              vim.wo[win][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            end
          end)
        end,
        desc = "Enable treesitter highlighting and indent",
      })

      -- Fire for the buffer that triggered the lazy-load (its FileType already ran)
      local ft = vim.bo.filetype
      if vim.tbl_contains(ts_filetypes, ft) then
        vim.api.nvim_exec_autocmds("FileType", { group = "RahulTreesitterStart", pattern = ft })
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      local select_maps = {
        af = "@function.outer",
        ["if"] = "@function.inner",
        ac = "@class.outer",
        ic = "@class.inner",
        aa = "@parameter.outer",
        ia = "@parameter.inner",
      }
      for lhs, query in pairs(select_maps) do
        vim.keymap.set({ "x", "o" }, lhs, function()
          select.select_textobject(query, "textobjects")
        end, { desc = "Select " .. query })
      end

      local move_maps = {
        { "]m", move.goto_next_start, "@function.outer" },
        { "]]", move.goto_next_start, "@class.outer" },
        { "]M", move.goto_next_end, "@function.outer" },
        { "][", move.goto_next_end, "@class.outer" },
        { "[m", move.goto_previous_start, "@function.outer" },
        { "[[", move.goto_previous_start, "@class.outer" },
        { "[M", move.goto_previous_end, "@function.outer" },
        { "[]", move.goto_previous_end, "@class.outer" },
      }
      for _, m in ipairs(move_maps) do
        vim.keymap.set({ "n", "x", "o" }, m[1], function()
          m[2](m[3], "textobjects")
        end, { desc = "Move to " .. m[3] })
      end
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
