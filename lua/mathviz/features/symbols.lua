local extmarks = require("mathviz.renderer.extmarks")
local config = require("mathviz.config")

local M = {}

function M.render(bufnr, symbols)
    if not symbols then return end

    for _, sym in ipairs(symbols) do
        if config.options.cursor.reveal_on_hover and extmarks.is_cursor_in_range(bufnr, sym.start_row, sym.start_col, sym.end_row, sym.end_col) then
            -- do nothing
        else
            extmarks.set_extmark(bufnr, sym.start_row, sym.start_col, {
                end_row = sym.end_row,
                end_col = sym.end_col,
                virt_text = {{sym.replacement, "MathVizSymbol"}},
                virt_text_pos = "overlay",
            })
        end
    end
end

return M
