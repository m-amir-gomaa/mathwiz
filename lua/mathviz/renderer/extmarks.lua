local state = require("mathviz.state")
local config = require("mathviz.config")

local M = {}

function M.clear(bufnr)
    vim.api.nvim_buf_clear_namespace(bufnr, state.ns_id, 0, -1)
end

function M.set_extmark(bufnr, row, col, opts)
    return vim.api.nvim_buf_set_extmark(bufnr, state.ns_id, row, col, opts)
end

function M.is_cursor_in_range(bufnr, start_row, start_col, end_row, end_col)
    local win = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_get_buf(win) ~= bufnr then return false end
    
    local cursor = vim.api.nvim_win_get_cursor(win)
    local crow = cursor[1] - 1 -- 0-indexed
    local ccol = cursor[2]
    
    if crow > start_row and crow < end_row then return true end
    if crow == start_row and crow == end_row then
        return ccol >= start_col and ccol <= end_col
    end
    if crow == start_row and ccol >= start_col then return true end
    if crow == end_row and ccol <= end_col then return true end
    
    return false
end

return M
