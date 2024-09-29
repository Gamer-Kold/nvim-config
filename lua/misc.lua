vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set("n", "<a-k>", ":m .-2<CR>==")
vim.keymap.set("n", "<a-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<a-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<a-j>", ":m '>+1<CR>gv=gv")
do
  local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {clear = true})
  local function _1_()
    return vim.highlight.on_yank()
  end
  vim.api.nvim_create_autocmd("TextYankPost", {callback = _1_, group = highlight_group, pattern = "*"})
end
do
  local fennel_group = vim.api.nvim_create_augroup("KodinFennel", {clear = true})
  local function _2_(opts)
    return vim.cmd("%!fnlfmt -")
  end
  vim.api.nvim_create_autocmd("BufWritePost", {callback = _2_, group = fennel_group, pattern = "*.fnl"})
end
return nil