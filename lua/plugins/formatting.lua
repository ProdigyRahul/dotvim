return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({
            lsp_format = "fallback",
            async = false,
            timeout_ms = 1000,
          })
        end,
        mode = { "n", "v" },
        desc = "Format file or range",
      },
      {
        "<leader>mp",
        function()
          require("conform").format({
            lsp_format = "fallback",
            async = false,
            timeout_ms = 1000,
          })
        end,
        mode = { "n", "v" },
        desc = "Format file or range",
      },
    },
    config = function()
      -- prettierd (daemon, ~20ms warm) preferred over prettier (cold node start each save)
      local prettier = { "prettierd", "prettier", stop_after_first = true }

      require("conform").setup({
        formatters_by_ft = {
          javascript = prettier,
          typescript = prettier,
          javascriptreact = prettier,
          typescriptreact = prettier,
          svelte = prettier,
          css = prettier,
          html = prettier,
          json = prettier,
          yaml = prettier,
          markdown = prettier,
          graphql = prettier,
          lua = { "stylua" },
        },
        format_on_save = {
          lsp_format = "fallback",
          timeout_ms = 500,
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
  },
}
