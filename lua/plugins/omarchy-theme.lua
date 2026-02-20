-- Reads active theme from omarchy and applies it.
-- Supports hot-reloading on :Lazy reload.

local THEME_FILE = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")
local TRANSPARENCY_FILE = vim.fn.stdpath("config") .. "/plugin/after/transparency.lua"

local function get_colorscheme()
	if vim.fn.filereadable(THEME_FILE) == 0 then
		return nil
	end
	-- The omarchy neovim.lua uses LazyVim-style spec — we just parse the colorscheme name from it
	local ok, spec = pcall(dofile, THEME_FILE)
	if not ok or type(spec) ~= "table" then
		return nil
	end
	for _, s in ipairs(spec) do
		if type(s) == "table" then
			-- Omarchy uses { "LazyVim/LazyVim", opts = { colorscheme = "..." } }
			if s[1] == "LazyVim/LazyVim" and type(s.opts) == "table" and s.opts.colorscheme then
				return s.opts.colorscheme
			end
			-- Fallback: direct colorscheme field
			if s.colorscheme then
				return s.colorscheme
			end
		end
	end
	return nil
end

local function apply_theme()
	local colorscheme = get_colorscheme()
	if not colorscheme then
		return
	end

	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.o.background = "dark"

	-- Ensure plugin is loaded (it may be lazy)
	local ok = pcall(vim.cmd.colorscheme, colorscheme)
	if not ok then
		pcall(function()
			require("lazy.core.loader").colorscheme(colorscheme)
		end)
		pcall(vim.cmd.colorscheme, colorscheme)
	end

	-- Re-apply transparency after colorscheme resets highlights
	if vim.fn.filereadable(TRANSPARENCY_FILE) == 1 then
		vim.defer_fn(function()
			vim.cmd.source(TRANSPARENCY_FILE)
			vim.cmd("redraw!")
		end, 10)
	end
end

return {
	{
		name = "omarchy-theme",
		dir = vim.fn.stdpath("config"),
		lazy = false,
		priority = 900,
		config = function()
			-- Apply on startup after all plugins are loaded
			vim.defer_fn(apply_theme, 0)

			-- Hot-reload when :Lazy reload is triggered
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyReload",
				callback = function()
					vim.schedule(apply_theme)
				end,
			})
		end,
	},
}
