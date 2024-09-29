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

local hotpot_path = vim.fn.stdpath("data") .. '/lazy/hotpot.nvim'
if not vim.loop.fs_stat(hotpot_path) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/rktjmp/hotpot.nvim.git',
    '--branch=v0.14.6', -- latest stable release
    hotpot_path,
  }
end
vim.opt.rtp:prepend(hotpot_path)
vim.opt.rtp:prepend(lazypath)

vim.loader.enable()

require("hotpot")

require('lazy').setup("plugin")

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

vim.keymap.set('i', '<M-o>', '<esc>')

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
