local function _1_()
  local cmp = require("cmp")
  local function _2_(args)
    local luasnip = require("luasnip")
    return luasnip.lsp_expand(args.body)
  end
  cmp.setup({completion = {autocomplete = false}, snippet = {expand = _2_}, window = {}, mapping = cmp.mapping.preset.insert({["<C-b>"] = cmp.mapping.scroll_docs(-4), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<M-c>"] = cmp.mapping.complete(), ["<C-e>"] = cmp.mapping.abort(), ["<C-n>"] = cmp.mapping.select_next_item(), ["<C-y>"] = cmp.mapping.confirm({select = true})}), sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "luasnip"}, {name = "buffer"}})})
  cmp.setup.filetype("gitcommit", {sources = cmp.config.sources({{name = "git"}, {name = "buffer"}})})
  cmp.setup.cmdline({"/", "?"}, {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})
  return cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "path"}, {name = "cmdline"}})})
end
return {"hrsh7th/nvim-cmp", event = "VimEnter", dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip"}, config = _1_}
