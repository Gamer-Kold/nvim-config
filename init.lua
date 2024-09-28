---@diagnostic disable: missing-fields
---@diagnostic disable: undefined-global
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.foldmethod = "marker"
vim.o.tabstop = 4

-- Enable relative line numbers
vim.o.relativenumber = true
vim.o.number = true

vim.o.scrolloff = 30

-- TODO List
-- [ ] Figure out what incremental selection is.
-- [x] Figure out what the fuck a loclist or a quickfix list is.
  -- [ ] Figure out if I need to start Makefiles to all my projects
-- [x] Add multicursor keybindings

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
  -- 'ActivityWatch/aw-watcher-vim',
  {
    "Gamer-Kold/kodnotes.nvim",
    dependencies = {
      'nvim-telescope/telescope.nvim',
    }
  },
  {
    dir = "~/projects/hblang.vim/",
  },

  'tpope/vim-sleuth',

  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },

  "rebelot/kanagawa.nvim",

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
    init = function()
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
    init = function()
      vim.g.VM_maps = {
        ['Find Under'] = "\\\\<C-n>",
        ['Find Subword Under'] = "\\\\<C-n>",
      }
    end
  },

--  {
--    "NeogitOrg/neogit",
--    tag="0.0.1",
--    dependencies = {
--      "nvim-lua/plenary.nvim",         -- required
--      "sindrets/diffview.nvim",        -- optional - Diff integration
--      "nvim-telescope/telescope.nvim", -- optional
--    },
--    config = function()
--      require('neogit').setup()
--      vim.keymap.set('n', '<leader>g', ':Neogit<CR>', { desc = "Open git" })
--    end
--  },

  {
    "mfussenegger/nvim-jdtls",
  },

  "andweeb/presence.nvim",
  {
    "Olical/conjure",
    ft={"scheme"},
    config = function ()
      vim.g["conjure#mapping#prefix"] = "<localleader>c"
      vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
    end
  },
  {
    "eraserhd/parinfer-rust",
    build = "cargo build --release",
    config = function ()
      vim.cmd("ParinferOff")
    end,
  },

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
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      vim.keymap.set('n', '<F5>', function() dap.continue() end)
      vim.keymap.set('n', '<F10>', function() dap.step_over() end)
      vim.keymap.set('n', '<F11>', function() dap.step_into() end)
      vim.keymap.set('n', '<F12>', function() dap.step_out() end)
      vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
      dap.adapters.godot = {
        type = "server",
        host = '127.0.0.1',
        port = 6006,
      }

      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "Launch scene",
          project = "${workspaceFolder}",
          launch_scene = true,
        }
      }
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = "VimEnter",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require 'cmp'

      cmp.setup({
        completion = {
          autocomplete = false,
        },
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),

        },
        mapping = cmp.mapping.preset.insert({
          ['<M-b>'] = cmp.mapping.scroll_docs(-4),
          ['<M-f>'] = cmp.mapping.scroll_docs(4),
          ['<M-c>'] = cmp.mapping.complete(), 
          ['<M-e>'] = cmp.mapping.abort(),
          ['<M-m>'] = cmp.mapping.select_prev_item(),
          ['<M-n>'] = cmp.mapping.select_next_item(),
          ['<M-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = 'buffer' },
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  },
})






vim.cmd.colorscheme "kanagawa-dragon"

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

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_conf = {
  capabilities = capabilities
}
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup        (lsp_conf)
lspconfig.zls.setup           (lsp_conf)
lspconfig.rust_analyzer.setup (lsp_conf)
lspconfig.ols.setup           (lsp_conf)
lspconfig.fennel_ls.setup     (lsp_conf)
lspconfig.gdscript.setup      (lsp_conf)

-- Global mappings
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
