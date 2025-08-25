return {
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
      
      local autocmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup

      local typescript_group = augroup("TypeScriptImports", { clear = true })

      autocmd("BufWritePre", {
        group = typescript_group,
        pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
        callback = function()
          vim.lsp.buf.format({ async = false })
          vim.cmd("TSToolsOrganizeImports")
          vim.cmd("TSToolsAddMissingImports")
        end,
        desc = "Organize imports and format on save for TypeScript files",
      })

      autocmd("InsertLeave", {
        group = typescript_group,
        pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
        callback = function()
          vim.cmd("TSToolsAddMissingImports")
        end,
        desc = "Add missing imports when leaving insert mode",
      })

      local general_group = augroup("GeneralSettings", { clear = true })

      autocmd("TextYankPost", {
        group = general_group,
        pattern = "*",
        callback = function()
          vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
        end,
        desc = "Highlight yanked text",
      })

      autocmd("BufReadPost", {
        group = general_group,
        pattern = "*",
        callback = function()
          local mark = vim.api.nvim_buf_get_mark(0, '"')
          local lcount = vim.api.nvim_buf_line_count(0)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end,
        desc = "Remember cursor position",
      })

      autocmd("FileType", {
        group = general_group,
        pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
        callback = function()
          vim.cmd("nnoremap <silent> <buffer> q :close<CR>")
        end,
        desc = "Close certain windows with q",
      })

      autocmd("FileType", {
        group = general_group,
        pattern = { "gitcommit", "markdown" },
        callback = function()
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
        end,
        desc = "Enable wrap and spell for git commits and markdown",
      })
    end,
  },
}