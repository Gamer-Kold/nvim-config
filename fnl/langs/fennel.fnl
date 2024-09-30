(fn [tbl]
  (if (~= 0 (vim.fn.executable "fennel-ls"))
  (tbl.lspconfig.fennel_ls.setup tbl.lsp_conf)) ; Format fennel code on save
  (let [fennel_group (vim.api.nvim_create_augroup :KodinFennel {:clear true})]
    (vim.api.nvim_create_autocmd :BufWritePost
                                 {:callback (fn [opts]
                                              (vim.cmd (.. "silent! !fnlfmt "
                                                           opts.file))
                                              (if (= vim.v.shell_error 0)
                                                  (let [pos (vim.api.nvim_win_get_cursor 0)]
                                                    (vim.cmd "silent! %!fnlfmt -")
                                                    (vim.api.nvim_win_set_cursor 0
                                                                                 pos))
                                                  (vim.cmd "echom 'error in file'"))
                                              nil)
                                  :group fennel_group
                                  :pattern :*.fnl})) nil)
