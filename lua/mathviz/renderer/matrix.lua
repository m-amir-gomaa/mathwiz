local extmarks = require("mathviz.renderer.extmarks")
local config = require("mathviz.config")
local state = require("mathviz.state")

local M = {}

-- symbols
local brackets = {
    top_left = "⎡",
    top_right = "⎤",
    mid_left = "⎢",
    mid_right = "⎥",
    bot_left = "⎣",
    bot_right = "⎦",
    single_left = "⎡",
    single_right = "⎤",
}

function M.render(bufnr, matrices)
    if not matrices then return end

    for _, mat in ipairs(matrices) do
        -- Skip rendering if cursor is inside the matrix
        if config.options.cursor.reveal_on_hover and extmarks.is_cursor_in_range(bufnr, mat.start_row, mat.start_col, mat.end_row, mat.end_col) then
            -- do nothing for this matrix
        else
            local num_rows = #mat.rows

            -- Render outer brackets (hide them)
            extmarks.set_extmark(bufnr, mat.start_row, mat.start_col, {
                end_col = mat.start_col + 1,
                conceal = "",
                virt_text = {{"", "MathVizHidden"}},
                virt_text_pos = "inline",
            })
            extmarks.set_extmark(bufnr, mat.end_row, mat.end_col - 1, {
                end_col = mat.end_col,
                conceal = "",
                virt_text = {{"", "MathVizHidden"}},
                virt_text_pos = "inline",
            })

            -- Render inner rows
            for i, row in ipairs(mat.rows) do
                local left_sym, right_sym
                
                if num_rows == 1 or mat.start_row == mat.end_row then
                    left_sym = brackets.single_left
                    right_sym = brackets.single_right
                elseif i == 1 then
                    left_sym = brackets.top_left
                    right_sym = brackets.top_right
                elseif i == num_rows then
                    left_sym = brackets.bot_left
                    right_sym = brackets.bot_right
                else
                    left_sym = brackets.mid_left
                    right_sym = brackets.mid_right
                end
                
                -- Replace inner left bracket
                extmarks.set_extmark(bufnr, row.start_row, row.start_col, {
                    end_row = row.start_row,
                    end_col = row.start_col + 1,
                    virt_text = {{left_sym, "MathVizBracket"}},
                    virt_text_pos = "overlay",
                })
                
                -- Replace inner right bracket
                extmarks.set_extmark(bufnr, row.end_row, row.end_col - 1, {
                    end_row = row.end_row,
                    end_col = row.end_col,
                    virt_text = {{right_sym, "MathVizBracket"}},
                    virt_text_pos = "overlay",
                })
                
                -- Hide commas
                if row.commas then
                    for _, comma_pos in ipairs(row.commas) do
                        extmarks.set_extmark(bufnr, comma_pos.row, comma_pos.col, {
                            end_row = comma_pos.row,
                            end_col = comma_pos.col + 1,
                            virt_text = {{" ", "MathVizHidden"}},
                            virt_text_pos = "overlay",
                        })
                    end
                end
            end
            
            -- Hide commas in the outer list if any
            if mat.commas then
                for _, comma_pos in ipairs(mat.commas) do
                    extmarks.set_extmark(bufnr, comma_pos.row, comma_pos.col, {
                        end_row = comma_pos.row,
                        end_col = comma_pos.col + 1,
                        virt_text = {{" ", "MathVizHidden"}},
                        virt_text_pos = "overlay",
                    })
                end
            end
            ::continue_matrix::
        end
    end
end

return M
