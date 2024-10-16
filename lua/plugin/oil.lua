local function _1_()
  return require("mini.icons").setup({style = "glyph"})
end
local function _2_()
  require("oil").setup()
  return nil
end
return {"stevearc/oil.nvim", opts = {}, dependencies = {{"echasnovski/mini.icons", config = _1_}}, config = _2_}