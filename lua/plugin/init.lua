local function _1_()
  vim.g.VM_maps = {["Find Under"] = "\\\\<C-n>", ["Find Subword Under"] = "\\\\<C-n>"}
  return nil
end
local function _2_()
  vim.g["conjure#mapping#prefix"] = "<localleader>c"
  vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
  return nil
end
local function _3_()
  return vim.cmd("ParinferOff")
end
return {"rktjmp/hotpot.nvim", {"Gamer-Kold/kodnotes.nvim", dependencies = {"nvim-telescope/telescope.nvim"}}, {url = "https://git.ablecorp.us/kodin/hblang.vim"}, "tpope/vim-sleuth", {"mcchrish/zenbones.nvim", dependencies = {"rktjmp/lush.nvim"}}, "rebelot/kanagawa.nvim", "neovim/nvim-lspconfig", {"mg979/vim-visual-multi", init = _1_}, {"mfussenegger/nvim-jdtls"}, "andweeb/presence.nvim", {"Olical/conjure", ft = {"scheme"}, config = _2_}, {"eraserhd/parinfer-rust", build = "cargo build ;release", config = _3_}}