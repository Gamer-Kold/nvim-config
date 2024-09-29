{1 :nvim-telescope/telescope.nvim
 :dependencies [:nvim-lua/plenary.nvim
                {1 :nvim-telescope/telescope-fzf-native.nvim :build :make}]
 :init (fn []
         (local builtin (require :telescope.builtin))
         (vim.keymap.set :n :<leader>sf builtin.find_files {:desc "Find Files"})
         (vim.keymap.set :n :<leader>sg builtin.live_grep {:desc "Live Grep"})
         (vim.keymap.set :n :<leader>sb builtin.buffers
                         {:desc "Search buffers"})
         (vim.keymap.set :n :<leader>sh builtin.help_tags {:desc "Search help"})
         (vim.keymap.set :n :<leader>sm builtin.man_pages
                         {:desc "Search man pages"}))}
