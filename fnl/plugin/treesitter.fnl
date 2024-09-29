{1 :nvim-treesitter/nvim-treesitter
 :build ":TSUpdate"
 :opts {:ensure_installed [:bash :c :html :lua :markdown :vim :vimdoc]
        :highlight {:enable true :additional_vim_regex_highlighting [:ruby]}
        :indent {:enable true :disable [:ruby]}}
 ; [[ Configure Treesitter ]] See `:help nvim-treesitter`
 :config (fn [_ opts]
           (let [ts (require :nvim-treesitter.configs)] (ts.setup opts)))}
