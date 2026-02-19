local augroup = vim.api.nvim_create_augroup("RahulAutocommands", { clear = true })

local function is_normal_file_buf(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end

  if vim.bo[bufnr].buftype ~= "" then
    return false
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return false
  end

  return true
end

local function autosave_buf(bufnr)
  if not is_normal_file_buf(bufnr) then
    return
  end

  if not vim.bo[bufnr].modified then
    return
  end

  if not vim.bo[bufnr].modifiable or vim.bo[bufnr].readonly then
    return
  end

  local ok, err = pcall(vim.api.nvim_buf_call, bufnr, function()
    vim.cmd("noautocmd update")
  end)
  if not ok then
    vim.notify(("Auto-save failed: %s"):format(tostring(err)), vim.log.levels.WARN)
  end
end

-- Remember cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
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

-- Close certain windows with q
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function(ev)
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true })
  end,
  desc = "Close certain windows with q",
})

-- Enable wrap and spell for git commits and markdown
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = "Enable wrap and spell for git commits and markdown",
})

-- Auto-save when leaving a file buffer (without triggering formatters/fixers).
vim.api.nvim_create_autocmd("BufLeave", {
  group = augroup,
  callback = function(ev)
    autosave_buf(ev.buf)
  end,
  desc = "Auto-save on buffer leave",
})

-- Keep only one listed file buffer around at a time.
local cleaning = false
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  callback = function(ev)
    if cleaning then
      return
    end

    local current = ev.buf
    if not is_normal_file_buf(current) then
      return
    end

    cleaning = true
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= current and is_normal_file_buf(buf) and vim.bo[buf].buflisted then
        autosave_buf(buf)
        if vim.api.nvim_buf_is_valid(buf) and not vim.bo[buf].modified then
          pcall(vim.api.nvim_buf_delete, buf, { force = false })
        end
      end
    end
    cleaning = false
  end,
  desc = "Single-buffer mode cleanup",
})
