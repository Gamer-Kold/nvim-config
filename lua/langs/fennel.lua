local function _1_(tbl)
  if (0 ~= vim.fn.executable("fennel-ls")) then
    tbl.lspconfig.fennel_ls.setup(tbl.lsp_conf)
  else
  end
  do
    local fennel_group = vim.api.nvim_create_augroup("KodinFennel", {clear = true})
    local function _3_(opts)
      vim.cmd(("silent! !fnlfmt " .. opts.file))
      if (vim.v.shell_error == 0) then
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd("silent! %!fnlfmt -")
        vim.api.nvim_win_set_cursor(0, pos)
      else
        vim.cmd("echom 'error in file'")
      end
      return nil
    end
    vim.api.nvim_create_autocmd("BufWritePost", {callback = _3_, group = fennel_group, pattern = "*.fnl"})
  end
  return nil
end
return _1_