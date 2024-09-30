(fn [tbl]
  (if (not= 0 (vim.fn.executable :lua-language-server))
      (tbl.lspconfig.lua_ls.setup tbl.lsp_conf))
  nil)
