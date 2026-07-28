local extmarks = require("mathviz.renderer.extmarks")
local config = require("mathviz.config")
local state = require("mathviz.state")

local M = {}

function M.render(bufnr, fractions)
    if not fractions then return end

    for _, frac in ipairs(fractions) do
        if config.options.cursor.reveal_on_hover and extmarks.is_cursor_in_range(bufnr, frac.start_row, frac.start_col, frac.end_row, frac.end_col) then
            -- do nothing
        else
            -- Conceal the entire fraction
            extmarks.set_extmark(bufnr, frac.start_row, frac.start_col, {
                end_row = frac.end_row,
                end_col = frac.end_col,
                conceal = "",
                virt_text = {{"", "MathVizHidden"}},
                virt_text_pos = "inline",
            })
            
            -- Find the max width for the fraction bar
            local num_text = frac.numerator_text or " "
            local den_text = frac.denominator_text or " "
            local width = math.max(#num_text, #den_text) + 2
            local bar = string.rep("─", width)

            -- Numerator above
            extmarks.set_extmark(bufnr, frac.start_row, frac.start_col, {
                virt_lines = {
                    {{ string.rep(" ", math.floor((width - #num_text)/2)) .. num_text, "MathVizFractionText" }}
                },
                virt_lines_above = true,
            })
            
            -- Fraction bar inline
            extmarks.set_extmark(bufnr, frac.start_row, frac.start_col, {
                virt_text = {{ bar, "MathVizFractionBar" }},
                virt_text_pos = "inline",
            })
            
            -- Denominator below
            extmarks.set_extmark(bufnr, frac.start_row, frac.start_col, {
                virt_lines = {
                    {{ string.rep(" ", math.floor((width - #den_text)/2)) .. den_text, "MathVizFractionText" }}
                },
                virt_lines_above = false,
            })
        end
    end
end

return M
