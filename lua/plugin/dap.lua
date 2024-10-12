local function _1_()
  local dap = require("dap")
  local function _2_()
    return dap.continue()
  end
  vim.keymap.set("n", "<F5>", _2_)
  local function _3_()
    return dap.step_over()
  end
  vim.keymap.set("n", "<F10>", _3_)
  local function _4_()
    return dap.step_into()
  end
  vim.keymap.set("n", "<F11>", _4_)
  local function _5_()
    return dap.step_out()
  end
  vim.keymap.set("n", "<F12>", _5_)
  local function _6_()
    return dap.toggle_breakpoint()
  end
  vim.keymap.set("n", "<Leader>b", _6_)
  dap.adapters.godot = {type = "server", host = "127.0.0.1", port = 6006}
  dap.configurations.gdscript = {{type = "godot", request = "launch", name = "Launch scene", project = "${workspaceFolder}", launch_scene = true}}
  return nil
end
return {"mfussenegger/nvim-dap", config = _1_}