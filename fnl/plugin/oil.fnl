{1 :stevearc/oil.nvim
 :opts {}
 :dependencies [{1 :echasnovski/mini.icons
                 :config (fn []
                           ((. (require :mini.icons) :setup) {:style :glyph}))}]
 :config (fn []
           (let [oil (require :oil)]
             (oil.setup)
             (vim.keymap.set :n :<leader>fo ":Oil<CR>")
             (vim.keymap.set :n "<leader>fh" oil.toggle_hidden)))}

