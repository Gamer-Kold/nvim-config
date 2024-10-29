local function _1_()
  return require("mini.icons").setup({style = "glyph"})
end
local function _2_()
  local oil = require("oil")
  oil.setup()
  vim.keymap.set("n", "<leader>fo", ":Oil<CR>")
  return vim.keymap.set("n", "<leader>fh", oil.toggle_hidden)
end
return {"stevearc/oil.nvim", opts = {}, dependencies = {{"echasnovski/mini.icons", config = _1_}}, config = _2_}