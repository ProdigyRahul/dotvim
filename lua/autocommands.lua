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

local function is_editable_file_buf(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end

  if vim.bo[bufnr].buftype ~= "" then
    return false
  end

  return vim.bo[bufnr].filetype ~= "neo-tree" and vim.bo[bufnr].filetype ~= "layout-spacer"
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

local function close_empty_windows(current_win)
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if win ~= current_win and vim.api.nvim_win_is_valid(win) then
      local buf = vim.api.nvim_win_get_buf(win)
      local lines = vim.api.nvim_buf_get_lines(buf, 0, 1, false)
      local is_empty = vim.bo[buf].buftype == ""
        and vim.bo[buf].filetype == ""
        and vim.api.nvim_buf_get_name(buf) == ""
        and not vim.bo[buf].modified
        and #lines == 1
        and lines[1] == ""

      if is_empty then
        pcall(vim.api.nvim_win_close, win, true)
      end
    end
  end
end

local function find_spacer_window()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "layout-spacer" then
      return win
    end
  end
end

local function find_neotree_window()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "neo-tree" then
      return win
    end
  end
end

local function create_spacer_window(anchor_win, width)
  local current_win = vim.api.nvim_get_current_win()
  local spacer_buf = vim.api.nvim_create_buf(false, true)

  vim.bo[spacer_buf].buftype = "nofile"
  vim.bo[spacer_buf].bufhidden = "wipe"
  vim.bo[spacer_buf].swapfile = false
  vim.bo[spacer_buf].modifiable = false
  vim.bo[spacer_buf].filetype = "layout-spacer"

  vim.api.nvim_set_current_win(anchor_win)
  vim.cmd("botright vsplit")

  local spacer_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(spacer_win, spacer_buf)
  vim.wo[spacer_win].number = false
  vim.wo[spacer_win].relativenumber = false
  vim.wo[spacer_win].signcolumn = "no"
  vim.wo[spacer_win].foldcolumn = "0"
  vim.wo[spacer_win].spell = false
  vim.wo[spacer_win].list = false
  vim.wo[spacer_win].wrap = false
  vim.wo[spacer_win].cursorline = false
  vim.wo[spacer_win].winfixwidth = true
  vim.wo[spacer_win].winbar = ""
  vim.wo[spacer_win].statuscolumn = ""
  vim.wo[spacer_win].colorcolumn = ""
  vim.wo[spacer_win].fillchars = "eob: "
  vim.api.nvim_win_set_width(spacer_win, width)

  vim.api.nvim_set_current_win(current_win)

  return spacer_win
end

local layout_locked = false

local function apply_code_width_layout()
  if layout_locked then
    return
  end

  layout_locked = true

  local editable_wins = {}
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if is_editable_file_buf(buf) then
      table.insert(editable_wins, win)
    end
  end

  local spacer_win = find_spacer_window()
  local neotree_win = find_neotree_window()

  if #editable_wins ~= 1 then
    if spacer_win and vim.api.nvim_win_is_valid(spacer_win) then
      pcall(vim.api.nvim_win_close, spacer_win, true)
    end
    layout_locked = false
    return
  end

  local code_win = editable_wins[1]
  local sidebar_width = math.max(24, math.floor(vim.o.columns * 0.30))
  vim.wo[code_win].winfixwidth = false

  if neotree_win and vim.api.nvim_win_is_valid(neotree_win) then
    if spacer_win and vim.api.nvim_win_is_valid(spacer_win) then
      pcall(vim.api.nvim_win_close, spacer_win, true)
    end
    vim.wo[neotree_win].winfixwidth = true
    pcall(vim.api.nvim_win_set_width, neotree_win, sidebar_width)
  else
    if not (spacer_win and vim.api.nvim_win_is_valid(spacer_win)) then
      spacer_win = create_spacer_window(code_win, sidebar_width)
    end
    vim.wo[spacer_win].winfixwidth = true
    pcall(vim.api.nvim_win_set_width, spacer_win, sidebar_width)
  end

  pcall(vim.api.nvim_set_current_win, code_win)
  layout_locked = false
end

local function schedule_code_width_layout()
  vim.schedule(function()
    if vim.v.exiting ~= vim.NIL and vim.v.exiting ~= 0 then
      return
    end
    pcall(apply_code_width_layout)
  end)
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
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = ""
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
    close_empty_windows(vim.api.nvim_get_current_win())
    cleaning = false
    schedule_code_width_layout()
  end,
  desc = "Single-buffer mode cleanup",
})

vim.api.nvim_create_autocmd({ "VimEnter", "TabEnter", "VimResized", "WinNew", "WinClosed" }, {
  group = augroup,
  callback = function()
    schedule_code_width_layout()
  end,
  desc = "Keep code window at 70 percent width",
})
