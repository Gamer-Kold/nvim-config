{1 :folke/which-key.nvim
 :event :VimEnter
 :config (fn []
           (local which-key (require :which-key))
           (which-key.setup)
           (which-key.add [{1 :<leader>d :group :Diagnostics}
                           {1 :<leader>g :group "Go To"}
                           {1 :<leader>l :group :LSP}
                           {1 :<leader>s :group :Search}
                           {1 :<leader>w :group :Workspaces}]))}
