local config = require("mathviz.config")
local state = require("mathviz.state")

local M = {}

function M.setup()
    vim.api.nvim_create_user_command("MathVizEnable", function()
        config.options.enabled = true
        print("MathViz enabled")
    end, {})

    vim.api.nvim_create_user_command("MathVizDisable", function()
        config.options.enabled = false
        -- Clear extmarks
        local bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_clear_namespace(bufnr, state.ns_id, 0, -1)
        print("MathViz disabled")
    end, {})

    vim.api.nvim_create_user_command("MathVizToggle", function()
        if config.options.enabled then
            vim.cmd("MathVizDisable")
        else
            vim.cmd("MathVizEnable")
        end
    end, {})

    vim.api.nvim_create_user_command("MathVizMathMode", function()
        local bufnr = vim.api.nvim_get_current_buf()
        local is_active = state.toggle_math_mode(bufnr)
        print("MathViz Math Mode: " .. (is_active and "ON" or "OFF"))
    end, {})
end

return M
