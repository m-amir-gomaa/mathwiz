local M = {}

-- Store active buffer states
-- math_mode_active: boolean
M.buffers = {}

-- The extmark namespace
M.ns_id = vim.api.nvim_create_namespace("mathviz")

function M.get_buf_state(bufnr)
    if not M.buffers[bufnr] then
        M.buffers[bufnr] = {
            math_mode_active = require("mathviz.config").options.math_mode.enabled_by_default,
        }
    end
    return M.buffers[bufnr]
end

function M.toggle_math_mode(bufnr)
    local state = M.get_buf_state(bufnr)
    state.math_mode_active = not state.math_mode_active
    return state.math_mode_active
end

return M
