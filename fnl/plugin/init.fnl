[; Activity Watch plugin to monitor my activity
 ; 'ActivityWatch/aw-watcher-vim'
 :rktjmp/hotpot.nvim

 {1 :Gamer-Kold/kodnotes.nvim :dependencies [:nvim-telescope/telescope.nvim]}

 {:dir "~/projects/hblang.vim/"}

 :tpope/vim-sleuth

 {1 :mcchrish/zenbones.nvim :dependencies [:rktjmp/lush.nvim]}

 :rebelot/kanagawa.nvim

 :neovim/nvim-lspconfig

 {1 :nvim-treesitter/nvim-treesitter
  :build ":TSUpdate"
  :opts {:ensure_installed [:bash :c :html :lua :markdown :vim :vimdoc]
         :highlight {:enable true :additional_vim_regex_highlighting [:ruby]}
         :indent {:enable true :disable [:ruby]}}
  ; [[ Configure Treesitter ]] See `:help nvim-treesitter`
  :config (fn [_ opts]
            (let [ts (require :nvim-treesitter.configs)] (ts.setup opts)))}
 {1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-lua/plenary.nvim
                 {1 :nvim-telescope/telescope-fzf-native.nvim :build :make}]
  :init (fn []
          (local builtin (require :telescope.builtin))
          (vim.keymap.set :n :<leader>sf builtin.find_files
                          {:desc "Find Files"})
          (vim.keymap.set :n :<leader>sg builtin.live_grep {:desc "Live Grep"})
          (vim.keymap.set :n :<leader>sb builtin.buffers
                          {:desc "Search buffers"})
          (vim.keymap.set :n :<leader>sh builtin.help_tags
                          {:desc "Search help"})
          (vim.keymap.set :n :<leader>sm builtin.man_pages
                          {:desc "Search man pages"}))}

 {1 :mg979/vim-visual-multi
  :init (fn []
          (set vim.g.VM_maps
               {"Find Under" "\\\\<C-n>" "Find Subword Under" "\\\\<C-n>"}))}

 {1 :mfussenegger/nvim-jdtls}

 :andweeb/presence.nvim

 {1 :Olical/conjure
  :ft [:scheme]
  :config (fn []
            (tset vim.g "conjure#mapping#prefix" :<localleader>c)
            (tset vim.g "conjure#filetype#fennel" :conjure.client.fennel.stdio))}

 {1 :eraserhd/parinfer-rust :build "cargo build ;release" :config (fn [] (vim.cmd "ParinferOff"))}

 {1 :folke/which-key.nvim
  :event :VimEnter
  :config (fn []
            (local which-key (require :which-key))
            (which-key.setup)
            (which-key.register {:<leader>s {:name :Search
                                             :_ :which_key_ignore}
                                 :<leader>g {:name "Go To"
                                             :_ :which_key_ignore}
                                 :<leader>d {:name :Diagnostics
                                             :_ :which_key_ignore}
                                 :<leader>l {:name :LSP :_ :which_key_ignore}
                                 :<leader>w {:name :Workspaces
                                             :_ :which_key_ignore}}))}

 {1 :mfussenegger/nvim-dap
  :config (fn []
            (local dap (require :dap))
            (vim.keymap.set :n :<F5> (fn [] (dap.continue)))
            (vim.keymap.set :n :<F10> (fn [] (dap.step_over)))
            (vim.keymap.set :n :<F11> (fn [] (dap.step_into)))
            (vim.keymap.set :n :<F12> (fn [] (dap.step_out)))
            (vim.keymap.set :n :<Leader>b (fn [] (dap.toggle_breakpoint)))
            (set dap.adapters.godot {:type :server :host :127.0.0.1 :port 6006})
            (set dap.configurations.gdscript
                 [{:type :godot
                   :request :launch
                   :name "Launch scene"
                   :project "${workspaceFolder}"
                   :launch_scene true}]))}

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
            (cmp.setup {":completion" {:autocomplete false}
                        :snippet {; REQUIRED - you must specify a snippet engine
                                  :expand (fn [args]
                                            (local luasnip (require :luasnip)) ; For `luasnip` users.
                                            (luasnip.lsp_expand args.body))}
                        :window {}; completion = cmp.config.window.bordered()
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
                                                              {:name :cmdline}])}))}]
