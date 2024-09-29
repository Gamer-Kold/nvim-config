local function _1_(_, opts)
  local ts = require("nvim-treesitter.configs")
  return ts.setup(opts)
end
local function _2_()
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>sf", builtin.find_files, {desc = "Find Files"})
  vim.keymap.set("n", "<leader>sg", builtin.live_grep, {desc = "Live Grep"})
  vim.keymap.set("n", "<leader>sb", builtin.buffers, {desc = "Search buffers"})
  vim.keymap.set("n", "<leader>sh", builtin.help_tags, {desc = "Search help"})
  return vim.keymap.set("n", "<leader>sm", builtin.man_pages, {desc = "Search man pages"})
end
local function _3_()
  vim.g.VM_maps = {["Find Under"] = "\\\\<C-n>", ["Find Subword Under"] = "\\\\<C-n>"}
  return nil
end
local function _4_()
  vim.g["conjure#mapping#prefix"] = "<localleader>c"
  vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
  return nil
end
local function _5_()
  return vim.cmd("ParinferOff")
end
local function _6_()
  local which_key = require("which-key")
  which_key.setup()
  return which_key.register({["<leader>s"] = {name = "Search", _ = "which_key_ignore"}, ["<leader>g"] = {name = "Go To", _ = "which_key_ignore"}, ["<leader>d"] = {name = "Diagnostics", _ = "which_key_ignore"}, ["<leader>l"] = {name = "LSP", _ = "which_key_ignore"}, ["<leader>w"] = {name = "Workspaces", _ = "which_key_ignore"}})
end
local function _7_()
  local dap = require("dap")
  local function _8_()
    return dap.continue()
  end
  vim.keymap.set("n", "<F5>", _8_)
  local function _9_()
    return dap.step_over()
  end
  vim.keymap.set("n", "<F10>", _9_)
  local function _10_()
    return dap.step_into()
  end
  vim.keymap.set("n", "<F11>", _10_)
  local function _11_()
    return dap.step_out()
  end
  vim.keymap.set("n", "<F12>", _11_)
  local function _12_()
    return dap.toggle_breakpoint()
  end
  vim.keymap.set("n", "<Leader>b", _12_)
  dap.adapters.godot = {type = "server", host = "127.0.0.1", port = 6006}
  dap.configurations.gdscript = {{type = "godot", request = "launch", name = "Launch scene", project = "${workspaceFolder}", launch_scene = true}}
  return nil
end
local function _13_()
  local cmp = require("cmp")
  local function _14_(args)
    local luasnip = require("luasnip")
    return luasnip.lsp_expand(args.body)
  end
  cmp.setup({[":completion"] = {autocomplete = false}, snippet = {expand = _14_}, window = {}, mapping = cmp.mapping.preset.insert({["<C-b>"] = cmp.mapping.scroll_docs(-4), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<M-c>"] = cmp.mapping.complete(), ["<C-e>"] = cmp.mapping.abort(), ["<C-n>"] = cmp.mapping.select_next_item(), ["<C-y>"] = cmp.mapping.confirm({select = true})}), sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "luasnip"}, {name = "buffer"}})})
  cmp.setup.filetype("gitcommit", {sources = cmp.config.sources({{name = "git"}, {name = "buffer"}})})
  cmp.setup.cmdline({"/", "?"}, {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})
  return cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "path"}, {name = "cmdline"}})})
end
return {"rktjmp/hotpot.nvim", {"Gamer-Kold/kodnotes.nvim", dependencies = {"nvim-telescope/telescope.nvim"}}, {dir = "~/projects/hblang.vim/"}, "tpope/vim-sleuth", {"mcchrish/zenbones.nvim", dependencies = {"rktjmp/lush.nvim"}}, "rebelot/kanagawa.nvim", "neovim/nvim-lspconfig", {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opts = {ensure_installed = {"bash", "c", "html", "lua", "markdown", "vim", "vimdoc"}, highlight = {enable = true, additional_vim_regex_highlighting = {"ruby"}}, indent = {enable = true, disable = {"ruby"}}}, config = _1_}, {"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim", {"nvim-telescope/telescope-fzf-native.nvim", build = "make"}}, init = _2_}, {"mg979/vim-visual-multi", init = _3_}, {"mfussenegger/nvim-jdtls"}, "andweeb/presence.nvim", {"Olical/conjure", ft = {"scheme"}, config = _4_}, {"eraserhd/parinfer-rust", build = "cargo build ;release", config = _5_}, {"folke/which-key.nvim", event = "VimEnter", config = _6_}, {"mfussenegger/nvim-dap", config = _7_}, {"hrsh7th/nvim-cmp", event = "VimEnter", dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip"}, config = _13_}}