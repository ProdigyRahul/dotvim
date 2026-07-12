return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer" },
  config = function()
    require("colorizer").setup({
      filetypes = {
        "css", "scss", "sass", "less", "html",
        "javascript", "typescript", "javascriptreact", "typescriptreact",
        "!vim",
        css = {
          rgb_fn = true,
          hsl_fn = true,
          css = true,
        },
        html = {
          mode = "foreground",
        },
      },
      buftypes = {
        "!prompt",
        "!popup",
      },
      user_commands = true,
      user_default_options = {
        names = false, -- color-name matching disabled for performance
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        AARRGGBB = false,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
        tailwind = "lsp",
        sass = {
          enable = true,
          parsers = { "css" },
        },
        virtualtext = "■",
        virtualtext_inline = true,
        virtualtext_priority = 200,
        always_update = false,
      },
    })

    vim.keymap.set("n", "<leader>ct", "<cmd>ColorizerToggle<cr>", { desc = "Toggle colorizer" })
    vim.keymap.set("n", "<leader>cA", "<cmd>ColorizerAttachToBuffer<cr>", { desc = "Attach colorizer to buffer" })
    vim.keymap.set("n", "<leader>cd", "<cmd>ColorizerDetachFromBuffer<cr>", { desc = "Detach colorizer from buffer" })

    -- Detach from large files where per-line color scanning gets expensive
    vim.api.nvim_create_autocmd("BufReadPost", {
      group = vim.api.nvim_create_augroup("RahulColorizerLargeFile", { clear = true }),
      callback = function(ev)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
        if ok and stats and stats.size > max_filesize then
          require("colorizer").detach_from_buffer(ev.buf)
        end
      end,
    })
  end,
}
