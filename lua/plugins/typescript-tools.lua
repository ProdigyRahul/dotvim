return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  opts = {
    settings = {
      separate_diagnostic_server = true,
      publish_diagnostic_on = "insert_leave",
      expose_as_code_action = "all",
      tsserver_path = nil,
      tsserver_plugins = {},
      tsserver_max_memory = "auto",
      tsserver_format_options = {},
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        includeCompletionsForModuleExports = true,
        quotePreference = "auto",
        autoImportFileExcludePatterns = { "node_modules/*", ".git/*" },
      },
      jsx_close_tag = {
        enable = true,
        filetypes = { "javascriptreact", "typescriptreact" },
      },
      complete_function_calls = true,
      include_completions_with_insert_text = true,
    },
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gs", ":TSToolsOrganizeImports<CR>", opts)
      vim.keymap.set("n", "ga", ":TSToolsAddMissingImports<CR>", opts)
      vim.keymap.set("n", "gu", ":TSToolsRemoveUnused<CR>", opts)
      vim.keymap.set("n", "gF", ":TSToolsFixAll<CR>", opts)
      vim.keymap.set("n", "gI", ":TSToolsGoToSourceDefinition<CR>", opts)
      vim.keymap.set("n", "gR", ":TSToolsFileReferences<CR>", opts)
      vim.keymap.set("n", "<leader>rF", ":TSToolsRenameFile<CR>", opts)
    end,
  },
}
