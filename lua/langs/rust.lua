local function _1_(tbl)
  if (0 ~= vim.fn.executable("rust-analyzer")) then
    return tbl.lspconfig.rust_analyzer.setup(tbl.lsp_conf)
  else
    return nil
  end
end
return _1_