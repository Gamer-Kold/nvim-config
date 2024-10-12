local function _1_()
  local which_key = require("which-key")
  which_key.setup()
  return which_key.add({{"<leader>d", group = "Diagnostics"}, {"<leader>g", group = "Go To"}, {"<leader>l", group = "LSP"}, {"<leader>s", group = "Search"}, {"<leader>w", group = "Workspaces"}})
end
return {"folke/which-key.nvim", event = "VimEnter", config = _1_}