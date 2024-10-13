; The list of plugins that don't have enough config to justify their own file
[; Activity Watch plugin to monitor my activity
 ; 'ActivityWatch/aw-watcher-vim'
 ; Neovim fennel support
 :rktjmp/hotpot.nvim
 ; my notetaking system
 {1 :Gamer-Kold/kodnotes.nvim :dependencies [:nvim-telescope/telescope.nvim]}
 ; hblang syntax highligher
 {:dir "~/projects/hblang.vim/"}
 ; automatic detection of indent
 :tpope/vim-sleuth
 ; git plugin 
 :tpope/vim-fugitive
 ; colorscheme
 {1 :mcchrish/zenbones.nvim :dependencies [:rktjmp/lush.nvim]}
 ; also a colorscheme
 :rebelot/kanagawa.nvim
 ; lspconfigs preconfigured for your pleasure
 :neovim/nvim-lspconfig
 ; multicursor support in vim; LOVE THIS
 {1 :mg979/vim-visual-multi
  :init (fn []
          (set vim.g.VM_maps
               {"Find Under" "\\\\<C-n>" "Find Subword Under" "\\\\<C-n>"}))}
 ; java IDE in neovim
 {1 :mfussenegger/nvim-jdtls}
 ; discord presence
 :andweeb/presence.nvim
 ; interactive debugging for lisps
 {1 :Olical/conjure
  :ft [:scheme]
  :config (fn []
            (tset vim.g "conjure#mapping#prefix" :<localleader>c)
            (tset vim.g "conjure#filetype#fennel" :conjure.client.fennel.stdio))}
 ; structural editing for lisps
 {1 :eraserhd/parinfer-rust
  :build "cargo build ;release"
  :config (fn [] (vim.cmd :ParinferOff))}]
