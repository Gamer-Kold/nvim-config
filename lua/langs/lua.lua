local function _1_(tbl)
  if (0 ~= vim.fn.executable("lua-language-server")) then
    tbl.lspconfig.lua_ls.setup(tbl.lsp_conf)
  else
  end
  return nil
end
return _1_