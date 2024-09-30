; Remap for dealing with word wrap
(vim.keymap.set :n :j "v:count == 0 ? 'gj' : 'j'" {:expr true :silent true})
(vim.keymap.set :n :k "v:count == 0 ? 'gk' : 'k'" {:expr true :silent true})

; Moving lines
; Normal Mode
(vim.keymap.set :n :<a-k> ":m .-2<CR>==")
(vim.keymap.set :n :<a-j> ":m .+1<CR>==")
; Visual Mode
(vim.keymap.set :v :<a-k> ":m '<-2<CR>gv=gv")
(vim.keymap.set :v :<a-j> ":m '>+1<CR>gv=gv")

; Highlight on yank
(let [highlight_group (vim.api.nvim_create_augroup :YankHighlight {:clear true})]
  (vim.api.nvim_create_autocmd :TextYankPost
                               {:callback (fn []
                                            (vim.highlight.on_yank))
                                :group highlight_group
                                :pattern "*"}))


nil
