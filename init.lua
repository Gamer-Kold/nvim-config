---@diagnostic disable: missing-fields
---@diagnostic disable: undefined-global
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable relative line numbers
vim.o.relativenumber = true
vim.o.number = true

-- TODO List
-- [ ] Figure out what incremental selection is.
-- [ ] Figure out what the fuck a loclist or a quickfix list is.
-- [ ] Add multicursor keybindings
-- [ ] Add autocompletion

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- Activity Watch plugin to monitor my activity
  'ActivityWatch/aw-watcher-vim',

  'tpope/vim-sleuth',

  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },

  "neovim/nvim-lspconfig",

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = "Find Files" })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = "Search buffers" })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = "Search help" })
      vim.keymap.set('n', '<leader>sm', builtin.man_pages, { desc = "Search man pages" })
    end
  },

  {
    "mg979/vim-visual-multi",
    init = function ()
      vim.g.VM_maps={
        ['Find Under'] = "\\\\<C-n>",
        ['Find Subword Under'] = "\\\\<C-n>",
      }
    end
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },

  {
    "mfussenegger/nvim-jdtls",
    config = function()
      local config = {
        cmd = {'/usr/bin/jdtls'},
        root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
      }
      require('jdtls').start_or_attach(config)
    end
  },

  "andweeb/presence.nvim",

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      require('which-key').register {
        ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = 'Go To', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = 'Diagnostics', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = 'LSP', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = 'Workspaces', _ = 'which_key_ignore' },
      }
    end,
  },
})

vim.cmd.colorscheme "zenbones"

-- Set highlight on search
vim.o.hlsearch = false

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'


-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
-- The line beneath this is called `modeline`. See `:help modeline`

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = "Open diagnostics" })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = function(desc) return { buffer = ev.buf, desc = "LSP: " .. desc } end

    -- Go To Commands
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts("Go to declaration"))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts("Go to defination"))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts("Go to Implementation"))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts("Go to References"))

    vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, opts("Hover documentation"))
    vim.keymap.set('n', '<leader>lH', vim.lsp.buf.signature_help, opts("Signature help"))
    vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, opts("Type definition"))
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts("Rename"))
    vim.keymap.set({ 'n', 'v' }, '<leader>ll', vim.lsp.buf.code_action, opts("Code Action"))

    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts("Format buffer"))

    -- Workspace commands
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts("Add Workspace folder"))
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts("Remove Workspace folder"))
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      opts("List Workspace folders"))
  end,
})
-- Remap for dealing with word wrap
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Moving lines
-- Normal Mode
vim.keymap.set('n', '<a-k>', ":m .-2<CR>==")
vim.keymap.set('n', '<a-j>', ":m .+1<CR>==")
-- Visual Mode
vim.keymap.set('v', '<a-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<a-j>', ":m '>+1<CR>gv=gv")


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
