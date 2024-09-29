(set vim.o.foldmethod :marker)
(set vim.o.tabstop 4)

; Enable relative line numbers
(set vim.o.relativenumber true)
(set vim.o.number true)
(set vim.o.scrolloff 30)

(vim.cmd.colorscheme :kanagawa-dragon)

; Set highlight on search
(set vim.o.hlsearch false)

; Enable mouse mode
(set vim.o.mouse :a)

; Enable break indent
(set vim.o.breakindent true)

; Save undo history
(set vim.o.undofile true)

; Case-insensitive searching UNLESS \C or capital in search
(set vim.o.ignorecase true)
(set vim.o.smartcase true)

; Keep signcolumn on by default
(set vim.wo.signcolumn :yes)

; Decrease update time
(set vim.o.updatetime 250)
(set vim.o.timeoutlen 300)

; Set completeopt to have a better completion experience
(set vim.o.completeopt "menuone,noselect")

; NOTE: You should make sure your terminal supports this
(set vim.o.termguicolors true)
