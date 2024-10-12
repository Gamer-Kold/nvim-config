local capabilities
do
  local cmp_lsp = require("cmp_nvim_lsp")
  capabilities = cmp_lsp.default_capabilities()
end
local lspconfig = require("lspconfig")
local lsp_conf = {capabilities = capabilities}
local opts = {lsp_conf = lsp_conf, lspconfig = lspconfig}
require("langs.fennel")(opts)
require("langs.lua")(opts)
require("langs.rust")(opts)
return nil