(fn [tbl] 
  (if (not= 0 (vim.fn.executable "rust-analyzer"))
      (tbl.lspconfig.rust_analyzer.setup tbl.lsp_conf)))
