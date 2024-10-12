local function _1_(_, opts)
  local ts = require("nvim-treesitter.configs")
  return ts.setup(opts)
end
return {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opts = {ensure_installed = {"bash", "c", "html", "lua", "markdown", "vim", "vimdoc"}, highlight = {enable = true, additional_vim_regex_highlighting = {"ruby"}}, indent = {enable = true, disable = {"ruby"}}}, config = _1_}