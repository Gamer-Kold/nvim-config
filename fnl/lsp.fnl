(local capabilities (let [cmp_lsp (require :cmp_nvim_lsp)]
                      (cmp_lsp.default_capabilities)))
(local lsp_conf {: capabilities})

(local lspconfig (require :lspconfig))
(lspconfig.zls.setup lsp_conf)
(lspconfig.ols.setup lsp_conf)
(lspconfig.gdscript.setup lsp_conf)

; Global mappings
; See `:help vim.diagnostic.*` for documentation on any of the below functions
(vim.keymap.set :n :<leader>de vim.diagnostic.open_float
                {:desc "Open diagnostics"})
(vim.keymap.set :n :<leader>dn vim.diagnostic.goto_prev
                {:desc "Go to previous diagnostic"})
(vim.keymap.set :n :<leader>dm vim.diagnostic.goto_next
                {:desc "Go to next diagnostic"})

(vim.keymap.set :i :<M-o> :<esc>)

(vim.api.nvim_create_autocmd :LspAttach
                             {:group (vim.api.nvim_create_augroup :UserLspConfig
                                                                  {})
                              :callback (fn [ev] 

                                          ; Enable completion triggered by <c-x><c-o>
                                          (tset (. vim.bo ev.buf) :omnifunc
                                                "v:lua.vim.lsp.omnifunc")
                                          (local opts
                                                 (fn [desc]
                                                   {:buffer ev.buf
                                                    :desc (.. "LSP: " desc)}))
                                          ; Go To Commands
                                          (vim.keymap.set :n :gD
                                                          vim.lsp.buf.declaration
                                                          (opts "Go to declaration"))
                                          (vim.keymap.set :n :gd
                                                          vim.lsp.buf.definition
                                                          (opts "Go to defination"))
                                          (vim.keymap.set :n :gi
                                                          vim.lsp.buf.implementation
                                                          (opts "Go to Implementation"))
                                          (vim.keymap.set :n :gr
                                                          vim.lsp.buf.references
                                                          (opts "Go to References"))
                                          (vim.keymap.set :n :<leader>lh
                                                          vim.lsp.buf.hover
                                                          (opts "Hover documentation"))
                                          (vim.keymap.set :n :<leader>lH
                                                          vim.lsp.buf.signature_help
                                                          (opts "Signature help"))
                                          (vim.keymap.set :n :<leader>lt
                                                          vim.lsp.buf.type_definition
                                                          (opts "Type definition"))
                                          (vim.keymap.set :n :<leader>lr
                                                          vim.lsp.buf.rename
                                                          (opts :Rename))
                                          (vim.keymap.set {:n :v} :<leader>ll
                                                          vim.lsp.buf.code_action
                                                          (opts "Code Action"))
                                          (vim.keymap.set :n :<leader>f
                                                          (fn []
                                                            (vim.lsp.buf.format {:async true}))
                                                          (opts "Format buffer"))
                                          ; Workspace commands
                                          (vim.keymap.set :n :<leader>wa
                                                          vim.lsp.buf.add_workspace_folder
                                                          (opts "Add Workspace folder"))
                                          (vim.keymap.set :n :<leader>wr
                                                          vim.lsp.buf.remove_workspace_folder
                                                          (opts "Remove Workspace folder"))
                                          (vim.keymap.set :n :<leader>wl
                                                          (fn []
                                                            (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
                                                          (opts "List Workspace folders")))})
