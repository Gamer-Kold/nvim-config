local root = vim.fs.dirname(vim.fs.find({'gradlew', 'Makefile', '.git', 'mvnw'}, { upward = true })[1])
local config = {
  cmd = {
    'jdtls',
    "-data " .. vim.fs.dirname(root) .. '/work_' .. vim.fs.basename(root),
  },
  root_dir = root,
}
require('jdtls').start_or_attach(config)
