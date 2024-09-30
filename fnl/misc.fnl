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

; Format fennel code on save
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
                                :pattern :*.fnl}))

nil
