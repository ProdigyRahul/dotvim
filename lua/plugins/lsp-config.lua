return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "eslint",
          "tailwindcss",
          "emmet_ls",
          "jsonls",
          "cssls",
          "html"
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- mason must load first so its bin dir is on PATH before servers spawn
    dependencies = { "saghen/blink.cmp", "williamboman/mason.nvim" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      -- TypeScript is now handled by typescript-tools.nvim for better performance
      -- See lua/plugins/typescript-tools.lua for TypeScript configuration

      -- Global config for all LSP servers (capabilities from nvim-cmp)
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      local servers = { 'lua_ls', 'eslint', 'tailwindcss', 'emmet_ls', 'jsonls', 'cssls', 'html' }

      -- nvim-lspconfig ships its own lsp/<server>.lua files, and they sit later in the
      -- runtimepath than ours, so they win the merge. Servers like tailwindcss end up with
      -- lspconfig's async root_dir *and* our root_markers. When that root_dir finds no
      -- marker it calls on_dir(nil), which makes vim.lsp.start() re-resolve the root with
      -- vim.fs.root(bufnr, root_markers) from inside a vim.schedule() -- one tick later,
      -- when the buffer may already be wiped: "vim/fs:483: Invalid buffer id: N".
      -- So resolve the root here, while the buffer is still valid, and never pass back nil.
      for _, name in ipairs(servers) do
        local resolved = vim.lsp.config[name] or {}
        local root_dir = resolved.root_dir
        if type(root_dir) == 'function' then
          local markers = resolved.root_markers or {}
          vim.lsp.config(name, {
            root_dir = function(bufnr, on_dir)
              if not vim.api.nvim_buf_is_valid(bufnr) then
                return
              end
              root_dir(bufnr, function(dir)
                -- The upstream callback may itself be deferred; re-check the buffer.
                if not vim.api.nvim_buf_is_valid(bufnr) then
                  return
                end
                dir = dir or vim.fs.root(bufnr, markers)
                if dir then
                  on_dir(dir)
                end
              end)
            end,
          })
        end
      end

      -- Enable all servers (configs loaded from lsp/ folder)
      vim.lsp.enable(servers)

      local lsp_keymaps = vim.api.nvim_create_augroup("RahulLspKeymaps", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_keymaps,
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show hover information" }))
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
        end,
        desc = "LSP: set buffer-local keymaps",
      })

      -- Diagnostic configuration with modern sign definitions
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end
  }
}
