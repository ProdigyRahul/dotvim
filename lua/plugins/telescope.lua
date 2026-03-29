local JUNK_DIR_GLOBS = {
  "!**/.git/*",
  "!**/node_modules/*",
  "!**/.next/*",
  "!**/dist/*",
  "!**/build/*",
  "!**/coverage/*",
}

local JUNK_FILE_PATTERNS = {
  ".git/",
  "node_modules/",
  ".next/",
  "dist/",
  "build/",
  "coverage/",
}

local function is_git_worktree(cwd)
  local result = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }, {
    cwd = cwd,
    text = true,
  }):wait()

  return result.code == 0 and vim.trim(result.stdout or "") == "true"
end

local function build_default_find_command(opts)
  local cwd = (opts and opts.cwd) or vim.loop.cwd()

  if is_git_worktree(cwd) then
    return { "git", "ls-files", "--cached", "--others", "--exclude-standard", "--", "." }
  end

  local cmd = { "rg", "--files", "--hidden" }
  for _, glob in ipairs(JUNK_DIR_GLOBS) do
    vim.list_extend(cmd, { "--glob", glob })
  end

  return cmd
end

local function find_files_default()
  require("telescope.builtin").find_files()
end

local function find_files_with_ignored()
  require("telescope.builtin").find_files({
    prompt_title = "Find files (include ignored)",
    hidden = true,
    no_ignore = true,
    find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!.git/*" },
  })
end

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim'
    },
    cmd = { "Telescope" },
    keys = {
      { "<C-p>", find_files_default, desc = "Find files" },
      { "<leader>ff", find_files_default, desc = "Find files" },
      { "<leader>fF", find_files_with_ignored, desc = "Find files (include ignored)" },
      {
        "<leader>fE",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "Env files (.env*)",
            hidden = true,
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--no-ignore-vcs",
              "--glob",
              "!.git/*",
              "--glob",
              "!**/node_modules/*",
              "--glob",
              "!**/.next/*",
              "--glob",
              "!**/dist/*",
              "--glob",
              "!**/build/*",
              "--glob",
              "**/.env*",
            },
          })
        end,
        desc = "Find .env files (include gitignored)",
      },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    },
    config = function()
      local telescope = require('telescope')

      -- Setup telescope with proper configuration
      telescope.setup({
        defaults = {
          -- Defensive UI filtering; the real performance win comes from the command-level excludes.
          file_ignore_patterns = JUNK_FILE_PATTERNS,
          mappings = {
            i = {
              ["<C-h>"] = "which_key"
            }
          }
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = build_default_find_command,
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })

      -- Load extensions after setup
      telescope.load_extension("ui-select")
    end
  }
}
