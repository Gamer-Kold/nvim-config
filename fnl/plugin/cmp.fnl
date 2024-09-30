{1 :hrsh7th/nvim-cmp
 :event :VimEnter
 :dependencies [:hrsh7th/cmp-nvim-lsp
                :hrsh7th/cmp-buffer
                :hrsh7th/cmp-path
                :hrsh7th/cmp-cmdline
                :L3MON4D3/LuaSnip
                :saadparwaiz1/cmp_luasnip]
 :config (fn []
           (local cmp (require :cmp))
           (cmp.setup {:completion {:autocomplete false}
                       :snippet {; REQUIRED - you must specify a snippet engine
                                 :expand (fn [args]
                                           (local luasnip (require :luasnip)) ; For `luasnip` users.
                                           (luasnip.lsp_expand args.body))}
                       :window {}
                       ;:completion (cmp.config.window.bordered)
                       ; documentation = cmp.config.window.bordered()
                       :mapping (cmp.mapping.preset.insert {:<C-b> (cmp.mapping.scroll_docs -4)
                                                            :<C-f> (cmp.mapping.scroll_docs 4)
                                                            :<M-c> (cmp.mapping.complete)
                                                            :<C-e> (cmp.mapping.abort)
                                                            :<C-n> (cmp.mapping.select_next_item)
                                                            :<C-y> (cmp.mapping.confirm {:select true})})
                       ; Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.)
                       :sources (cmp.config.sources [{:name :nvim_lsp}
                                                     {:name :luasnip}
                                                     ; For luasnip users.
                                                     {:name :buffer}])})
           ; Set configuration for specific filetype.
           (cmp.setup.filetype :gitcommit
                               {:sources (cmp.config.sources [{:name :git}
                                                              ; You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                                                              {:name :buffer}])})
           ; Use buffer source for `/` and `?` (if you enabled `native_menu` this won't work anymore).
           (cmp.setup.cmdline ["/" "?"]
                              {:mapping (cmp.mapping.preset.cmdline)
                               :sources [{:name :buffer}]}) ; Use cmdline & path source for ':' (if you enabled `native_menu` this won't work anymore).
           (cmp.setup.cmdline ":"
                              {:mapping (cmp.mapping.preset.cmdline)
                               :sources (cmp.config.sources [{:name :path}
                                                             {:name :cmdline}])}))}
