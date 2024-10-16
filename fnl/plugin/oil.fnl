{1 :stevearc/oil.nvim
 :opts {}
 :dependencies [{1 :echasnovski/mini.icons
                 :config (fn []
                           ((. (require :mini.icons) :setup) {:style :glyph}))}]
 :config (fn []
           ((. (require :oil) :setup))
           nil)}

