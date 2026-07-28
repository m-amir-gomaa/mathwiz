-- Inspect julia AST for logic and set operations
local code = [[
a && b
a || b
!a
a * b
a == b
a != b
a <= b
a >= b
intersection(a, b)
union(a, b)
]]
local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(code, '\n'))
vim.bo[bufnr].filetype = 'julia'
local ok, p = pcall(vim.treesitter.get_parser, bufnr, 'julia')
if not ok then print('parser error: '..p); return end
local tree = p:parse()[1]
local root = tree:root()
local function walk(node, depth)
    local text = vim.treesitter.get_node_text(node, bufnr):sub(1,30):gsub('\n',' ')
    print(string.rep('  ', depth) .. node:type() .. ' => "' .. text .. '"')
    for child in node:iter_children() do
        walk(child, depth+1)
    end
end
walk(root, 0)
