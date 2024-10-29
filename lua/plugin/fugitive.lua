local function _1_()
  return vim.keymap.set("n", "<leader>g", ":Git<CR>")
end
return {"tpope/vim-fugitive", config = _1_}