local M = {}
local symbols_module = require("mathviz.features.symbols")
local symbol_map = symbols_module.symbol_map
local subscript_map = symbols_module.subscript_map

local matrix_query_string = [[
(composite_literal
  (literal_value
    (literal_element (literal_value) @row)
  )
) @matrix
]]

local function get_node_range(node)
    local start_row, start_col, end_row, end_col = node:range()
    return {
        start_row = start_row,
        start_col = start_col,
        end_row = end_row,
        end_col = end_col,
    }
end

function M.get_matrices(bufnr, root)
    local ok, query = pcall(vim.treesitter.query.parse, "go", matrix_query_string)
    if not ok or not query then return {} end

    local matrices = {}
    local current_matrix = nil
    
    for id, node in query:iter_captures(root, bufnr, 0, -1) do
        local capture_name = query.captures[id]
        
        if capture_name == "matrix" then
            if current_matrix then
                table.insert(matrices, current_matrix)
            end
            local range = get_node_range(node)
            current_matrix = {
                start_row = range.start_row,
                start_col = range.start_col,
                end_row = range.end_row,
                end_col = range.end_col,
                rows = {},
                commas = {}
            }
            for child in node:iter_children() do
                if child:type() == "," then
                    local cr = get_node_range(child)
                    table.insert(current_matrix.commas, {row = cr.start_row, col = cr.start_col})
                end
            end
        elseif capture_name == "row" and current_matrix then
            local range = get_node_range(node)
            local row_obj = {
                start_row = range.start_row,
                start_col = range.start_col,
                end_row = range.end_row,
                end_col = range.end_col,
                commas = {}
            }
            for child in node:iter_children() do
                if child:type() == "," then
                    local cr = get_node_range(child)
                    table.insert(row_obj.commas, {row = cr.start_row, col = cr.start_col})
                end
            end
            table.insert(current_matrix.rows, row_obj)
        end
    end
    
    if current_matrix then
        table.insert(matrices, current_matrix)
    end
    
    return matrices
end

local symbol_query_string = [[
(identifier) @symbol
"&&" @symbol
"||" @symbol
"!" @symbol
"*" @symbol
"!=" @op_neq
"<=" @op_leq
">=" @op_geq
]]





function M.get_symbols(bufnr, root)
    local ok, query = pcall(vim.treesitter.query.parse, "go", symbol_query_string)
    if not ok or not query then return {} end

    local symbols = {}
    
    for id, node in query:iter_captures(root, bufnr, 0, -1) do
        local capture_name = query.captures[id]
        local range = get_node_range(node)
        
        if capture_name == "symbol" then
            local text = vim.treesitter.get_node_text(node, bufnr)
            if symbol_map[text] then
                table.insert(symbols, {
                    start_row = range.start_row,
                    start_col = range.start_col,
                    end_row = range.end_row,
                    end_col = range.end_col,
                    replacement = symbol_map[text]
                })
            else
                local base, sub = text:match("^([a-zA-Z]+)_([a-zA-Z0-9]+)$")
                if base and sub then
                    local sub_repl = ""
                    local valid = true
                    for i = 1, #sub do
                        local char = sub:sub(i, i)
                        if subscript_map[char] then
                            sub_repl = sub_repl .. subscript_map[char]
                        else
                            valid = false
                            break
                        end
                    end
                    if valid then
                        local repl = (symbol_map[base] or base) .. sub_repl
                        table.insert(symbols, {
                            start_row = range.start_row,
                            start_col = range.start_col,
                            end_row = range.end_row,
                            end_col = range.end_col,
                            replacement = repl
                        })
                    end
                end
            end
        elseif capture_name == "op_neq" then
            table.insert(symbols, {
                start_row = range.start_row,
                start_col = range.start_col,
                end_row = range.end_row,
                end_col = range.end_col,
                replacement = "≠"
            })
        elseif capture_name == "op_leq" then
            table.insert(symbols, {
                start_row = range.start_row,
                start_col = range.start_col,
                end_row = range.end_row,
                end_col = range.end_col,
                replacement = "≤"
            })
        elseif capture_name == "op_geq" then
            table.insert(symbols, {
                start_row = range.start_row,
                start_col = range.start_col,
                end_row = range.end_row,
                end_col = range.end_col,
                replacement = "≥"
            })
        elseif capture_name == "op_arrow" then
            table.insert(symbols, {
                start_row = range.start_row,
                start_col = range.start_col,
                end_row = range.end_row,
                end_col = range.end_col,
                replacement = "→"
            })
        end
    end
    
    return symbols
end

return M
