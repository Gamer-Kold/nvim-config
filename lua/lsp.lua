local capabilities
do
  local cmp_lsp = require("cmp_nvim_lsp")
  local cmp_capabilities = cmp_lsp.default_capabilities()
  local client_capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", client_capabilities, cmp_capabilities)
end
local lsp_conf = {capabilities = capabilities}
local lspconfig = require("lspconfig")
lspconfig.zls.setup(lsp_conf)
lspconfig.rust_analyzer.setup(lsp_conf)
lspconfig.ols.setup(lsp_conf)
lspconfig.gdscript.setup(lsp_conf)
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, {desc = "Open diagnostics"})
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_prev, {desc = "Go to previous diagnostic"})
vim.keymap.set("n", "<leader>dm", vim.diagnostic.goto_next, {desc = "Go to next diagnostic"})
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, {desc = "Add diagnostic to Quick Fix list"})
vim.keymap.set("i", "<M-o>", "<esc>")
local function _1_(ev)
  local opts
  local function _2_(desc)
    return {buffer = ev.buf, desc = ("LSP: " .. desc)}
  end
  opts = _2_
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to defination"))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to Implementation"))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Go to References"))
  vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts("Hover documentation"))
  vim.keymap.set("n", "<leader>lH", vim.lsp.buf.signature_help, opts("Signature help"))
  vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, opts("Type definition"))
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts("Rename"))
  vim.keymap.set({"n", "v"}, "<leader>ll", vim.lsp.buf.code_action, opts("Code Action"))
  local function _3_()
    return vim.lsp.buf.format({async = true})
  end
  vim.keymap.set("n", "<leader>lf", _3_, opts("Format buffer"))
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add Workspace folder"))
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove Workspace folder"))
  local function _4_()
    return print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end
  return vim.keymap.set("n", "<leader>wl", _4_, opts("List Workspace folders"))
end
return vim.api.nvim_create_autocmd("LspAttach", {group = vim.api.nvim_create_augroup("UserLspConfig", {}), callback = _1_})