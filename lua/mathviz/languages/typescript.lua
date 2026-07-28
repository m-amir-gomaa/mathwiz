local M = {}

local matrix_query_string = [[
(array
  (array) @row
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
    local ok, query = pcall(vim.treesitter.query.parse, "typescript", matrix_query_string)
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
"!=" @op_neq
"!==" @op_neq
"<=" @op_leq
">=" @op_geq
"=>" @op_arrow
]]

local greek_map = {
    alpha = "α", beta = "β", gamma = "γ", delta = "δ",
    theta = "θ", lambda = "λ", mu = "μ", sigma = "σ",
    phi = "φ", omega = "ω",
    Alpha = "Α", Beta = "Β", Gamma = "Γ", Delta = "Δ",
    Theta = "Θ", Lambda = "Λ", Mu = "Μ", Sigma = "Σ",
    Phi = "Φ", Omega = "Ω"
}

function M.get_symbols(bufnr, root)
    local ok, query = pcall(vim.treesitter.query.parse, "typescript", symbol_query_string)
    if not ok or not query then return {} end

    local symbols = {}
    
    for id, node in query:iter_captures(root, bufnr, 0, -1) do
        local capture_name = query.captures[id]
        local range = get_node_range(node)
        
        if capture_name == "symbol" then
            local text = vim.treesitter.get_node_text(node, bufnr)
            if greek_map[text] then
                table.insert(symbols, {
                    start_row = range.start_row,
                    start_col = range.start_col,
                    end_row = range.end_row,
                    end_col = range.end_col,
                    replacement = greek_map[text]
                })
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
