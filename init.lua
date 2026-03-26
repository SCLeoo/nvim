-- ========================================================================== --
--                                  SETTINGS                                  --
-- ========================================================================== --

-- 1. Leader Key
-- Default is '\', but Space is much more ergonomic for most users.
-- This key acts as the prefix for all your custom commands.
vim.g.mapleader = " "

-- 2. Syntax Shortcuts (Local variables for cleaner code)
local opt = vim.opt 

-- 3. Line Numbers (The perfect combo for fast movement)
opt.number = true          -- Show the absolute number of the current line
opt.relativenumber = true  -- Show distance from the current line (e.g., "5 lines down")
                           -- This is key for jumping: if you see a 10 above, type "10k".

-- 4. Indentation (Following 2-space preference)
opt.tabstop = 2      -- Number of visual spaces a Tab occupies
opt.shiftwidth = 2   -- Number of spaces inserted for indentation ('>' or '<<')
opt.expandtab = true -- Automatically convert Tabs into spaces
opt.autoindent = true -- Copy indentation from the previous line on Enter

-- 5. Interface & Experience
opt.wrap = false         -- Do not wrap long lines (horizontal scroll preferred)
opt.cursorline = true    -- Highlight the line where the cursor is located
opt.termguicolors = true -- Enable 24-bit RGB colors (required for modern themes)
opt.signcolumn = "yes"   -- Reserve space on the left for git/error icons
opt.splitright = true    -- Vertical splits open to the right
opt.splitbelow = true    -- Horizontal splits open below

-- 6. Clipboard (System synchronization)
-- This allows copy-pasting between Neovim and Windows/Mac/Linux apps.
opt.clipboard:append("unnamedplus")

-- 7. "Black Hole" Deletion
-- These mappings ensure that deleting text doesn't overwrite your clipboard.
-- Normal and Visual mode: 'd' and 'x' send text to the '_' (Black Hole) register.
vim.keymap.set({"n", "v"}, "d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set({"n", "v"}, "x", '"_x', { desc = "Delete character without yanking" })

-- Note: To 'Cut' (Delete and copy), you can still Yank (y) then Delete (d).
-- This keeps your clipboard clean from accidental deletions.

-- ========================================================================== --
--                        PORTABILITY & BOOTSTRAPPING                         --
-- ========================================================================== --

-- 1. Detect Operating System
-- Uses 'vim.uv' (modern Neovim API) to identify the host system for logic/themes.
local sysname = vim.uv.os_uname().sysname

-- 2. The Bootstrapper (Auto-installer)
-- This block checks if 'lazy.nvim' is installed. If not, it clones it from GitHub.
-- This makes your configuration 100% portable to any new machine.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", -- Official manager repo
    "--branch=stable",
    lazypath,
  })
end
-- Add 'lazy' to the Neovim runtime path
vim.opt.rtp:prepend(lazypath)

-- ========================================================================== --
--                               PLUGINS SETUP                                --
-- ========================================================================== --

-- 3. Plugin Configuration
-- This is where the "superpowers" of Neovim are defined.
require("lazy").setup({
  -- Icons (Required for a professional look in nvim-tree)
  { "nvim-tree/nvim-web-devicons" },

  -- Nvim-Tree: The File Explorer
  { 
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Explorer-specific configuration
      require("nvim-tree").setup({
        view = {
          side = "right",        -- Side-bar on the right as preferred
          width = 30,            -- Width of the explorer pane
          relativenumber = true, -- Enable relative numbers inside the tree
          number = true,
        },
        filters = {
          dotfiles = false,      -- Show hidden files (like .env or .gitignore)
        },
      })
    end
  },

-- [TRINITY SECTION] 
-- 
--   -- 1. MASON: The Package Manager for your Tools
--   -- This installs the actual binaries for Java, C#, etc.
--   -- { "williamboman/mason.nvim", config = true },
--   -- { "williamboman/mason-lspconfig.nvim", config = true },
-- 
--   -- 2. LSPCONFIG: The Bridge
--   -- This tells Neovim how to communicate with the installed servers.
--   -- { "neovim/nvim-lspconfig" },
-- 
--   -- 3. NVIM-CMP: The Autocompletion Engine
--   -- The interactive menu that pops up as you type code.
--   -- {
--   --   "hrsh7th/nvim-cmp",
--   --   dependencies = {
--   --     "hrsh7th/cmp-nvim-lsp", -- Links CMP to the LSP data
--   --     "L3MON4D3/LuaSnip",     -- Snippet engine for boilerplate code
--   --     "saadparwaiz1/cmp_luasnip",
--   --   },
--   --   config = function()
--   --     local cmp = require('cmp')
--   --     cmp.setup({
--   --       snippet = {
--   --         expand = function(args) require('luasnip').lsp_expand(args.body) end,
--   --       },
--   --       mapping = cmp.mapping.preset.insert({
--   --         ['<C-Space>'] = cmp.mapping.complete(), -- Manually trigger completion
--   --         ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm with Enter
--   --         ['<Tab>'] = cmp.mapping.select_next_item(),
--   --         ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--   --       }),
--   --       sources = cmp.config.sources({
--   --         { name = 'nvim_lsp' },
--   --         { name = 'luasnip' },
--   --       }, {
--   --         { name = 'buffer' }, -- Suggest words existing in the current file
--   --       })
--   --     })
--   --   end
--   -- },

  -- Themes
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  { "Mofiqul/dracula.nvim", priority = 1000 },
})

-- ========================================================================== --
--                               UI & THEMES                                  --
-- ========================================================================== --

-- 4. OS-Based Color Logic
-- Automatically apply a different theme depending on the environment.
if sysname == "Linux" then
  vim.cmd("colorscheme gruvbox")
elseif sysname == "Windows_NT" then 
  vim.cmd("colorscheme dracula")
else
  -- Catppuccin with transparency setup for macOS/Other
  require("catppuccin").setup({ transparent_background = true })
  vim.cmd("colorscheme catppuccin")
end

-- ========================================================================== --
--                          KEYMAPS & AUTOCOMMANDS                            --
-- ========================================================================== --

-- Focus File Explorer
-- Jump directly to the tree using Space + e.
vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.open({ focus = true })
end, { desc = "Focus File Explorer" })

-- Auto-open on Startup
-- Tells Neovim to open the tree as soon as the editor starts.
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     -- Open the tree but keep focus on the main editor window
--     require("nvim-tree.api").tree.open({ focus = false })
--   end,
-- })
