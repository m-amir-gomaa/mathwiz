local config = require("mathviz.config")
local commands = require("mathviz.commands")
-- Add parser and renderer requirements here later

local M = {}

local function update_buffer(bufnr)
    if not config.options.enabled then return end
    
    local parser = require("mathviz.parser")
    local extmarks = require("mathviz.renderer.extmarks")
    local matrix_renderer = require("mathviz.renderer.matrix")
    local symbol_renderer = require("mathviz.features.symbols")

    extmarks.clear(bufnr)
    
    local results = parser.parse_buffer(bufnr)
    
    if config.options.features.matrices and results.matrices then
        matrix_renderer.render(bufnr, results.matrices)
    end
    
    if config.options.features.symbols and results.symbols then
        symbol_renderer.render(bufnr, results.symbols)
    end
end

function M.setup(opts)
    config.setup(opts)
    commands.setup()
    
    local group = vim.api.nvim_create_augroup("MathViz", { clear = true })
    
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
        group = group,
        callback = function(args)
            update_buffer(args.buf)
        end,
    })
    
    -- Cursor movement reveal
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = group,
        callback = function(args)
            update_buffer(args.buf)
        end,
    })
end

return M
