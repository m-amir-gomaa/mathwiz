local extmarks = require("mathviz.renderer.extmarks")
local config = require("mathviz.config")

local M = {}

function M.render(bufnr, piecewise_blocks)
    if not piecewise_blocks then return end

    for _, block in ipairs(piecewise_blocks) do
        if config.options.cursor.reveal_on_hover and extmarks.is_cursor_in_range(bufnr, block.start_row, block.start_col, block.end_row, block.end_col) then
            -- do nothing
        else
            local num_lines = block.end_row - block.start_row + 1
            if num_lines >= 2 then
                for row = block.start_row, block.end_row do
                    local sym = "⎪"
                    if row == block.start_row then sym = "⎧"
                    elseif row == block.end_row then sym = "⎩"
                    elseif num_lines % 2 == 1 and row == block.start_row + math.floor(num_lines/2) then sym = "⎨"
                    end
                    
                    extmarks.set_extmark(bufnr, row, block.start_col, {
                        virt_text = {{ sym, "MathVizPiecewise" }},
                        virt_text_pos = "inline",
                        -- Hide the dictionary bracket if it's the first/last row
                        conceal = (row == block.start_row or row == block.end_row) and "" or nil
                    })
                end
            end
        end
    end
end

return M
