{1 :mfussenegger/nvim-dap
 :config (fn []
           (local dap (require :dap))
           (vim.keymap.set :n :<F5> (fn [] (dap.continue)))
           (vim.keymap.set :n :<F10> (fn [] (dap.step_over)))
           (vim.keymap.set :n :<F11> (fn [] (dap.step_into)))
           (vim.keymap.set :n :<F12> (fn [] (dap.step_out)))
           (vim.keymap.set :n :<Leader>b (fn [] (dap.toggle_breakpoint)))
           (set dap.adapters.godot {:type :server :host :127.0.0.1 :port 6006})
           (set dap.configurations.gdscript
                [{:type :godot
                  :request :launch
                  :name "Launch scene"
                  :project "${workspaceFolder}"
                  :launch_scene true}]))}
