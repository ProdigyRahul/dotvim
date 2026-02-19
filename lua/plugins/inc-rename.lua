return {
  "smjonas/inc-rename.nvim",
  event = "LspAttach",
  config = function()
    local input_buffer_type = nil
    local has_noice = pcall(require, "noice")
    if has_noice then
      input_buffer_type = "noice"
    end

    require("inc_rename").setup({
      cmd_name = "IncRename",
      hl_group = "Substitute",
      preview_empty_name = false,
      show_message = true,
      input_buffer_type = input_buffer_type,
      post_hook = nil,
      save_in_cmdline_history = true,
    })

    local function set_keymaps(bufnr)
      local opts = { buffer = bufnr, silent = true }

      vim.keymap.set("n", "<leader>rn", ":IncRename ", vim.tbl_extend("force", opts, { desc = "LSP incremental rename" }))

      vim.keymap.set("n", "<leader>rN", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, vim.tbl_extend("force", opts, { expr = true, desc = "LSP rename (prefilled)" }))

      vim.keymap.set("v", "<leader>rn", function()
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")

        local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
        if #lines == 0 then
          return
        end

        local selected_text
        if #lines == 1 then
          selected_text = string.sub(lines[1], start_pos[3], end_pos[3])
        else
          selected_text = vim.fn.expand("<cword>")
        end

        vim.cmd("IncRename " .. selected_text)
      end, vim.tbl_extend("force", opts, { desc = "LSP rename selection" }))
    end

    set_keymaps(vim.api.nvim_get_current_buf())

    local inc_rename_keymaps = vim.api.nvim_create_augroup("RahulIncRenameKeymaps", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = inc_rename_keymaps,
      callback = function(ev)
        set_keymaps(ev.buf)
      end,
      desc = "IncRename: set buffer-local keymaps",
    })
  end,
}
