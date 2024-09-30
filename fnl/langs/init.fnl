(local capabilities (let [cmp_lsp (require :cmp_nvim_lsp)]
                      (cmp_lsp.default_capabilities)))

(local lspconfig (require :lspconfig))
(local lsp_conf {: capabilities})
(local opts {:lsp_conf lsp_conf : lspconfig})
((require :fennel) opts) 
