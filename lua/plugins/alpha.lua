return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "                                                     ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
      dashboard.button("e", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "󰄉  Recently used files", ":Telescope oldfiles <CR>"),
      dashboard.button("t", "󰊄  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", "󰒓  Configuration", ":e $MYVIMRC <CR>"),
      dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
    }

    local function footer()
      local v = vim.version()
      local nvim_ver = string.format("NVIM v%d.%d.%d", v.major, v.minor, v.patch)

      local ok, lazy = pcall(require, "lazy")
      if not ok then
        return nvim_ver
      end

      local stats = lazy.stats() or {}
      local count = tonumber(stats.count) or 0
      local startuptime = tonumber(stats.startuptime)

      if startuptime then
        return string.format("⚡ %d plugins in %.0fms  •  %s", count, startuptime, nvim_ver)
      end

      return string.format("⚡ %d plugins  •  %s", count, nvim_ver)
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Comment"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      once = true,
      callback = function()
        dashboard.section.footer.val = footer()
        if vim.bo.filetype == "alpha" then
          pcall(alpha.redraw)
        end
      end,
      desc = "Refresh Alpha footer with Lazy stats",
    })
  end,
}
