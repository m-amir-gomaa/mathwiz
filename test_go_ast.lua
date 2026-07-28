-- Debug Go AST to see matrix structure
local bufnr = vim.fn.bufadd('/home/qwerty/mathwiz.nvim/samples/test.go')
vim.fn.bufload(bufnr)
local ok, p = pcall(vim.treesitter.get_parser, bufnr, 'go')
if not ok then print('no parser: '..p); return end
local root = p:parse()[1]:root()

local function walk(node, depth)
    if depth > 8 then return end
    local text = vim.treesitter.get_node_text(node, bufnr):sub(1,30):gsub('\n',' ')
    print(string.rep('  ',depth)..node:type()..' => "'..text..'"')
    for child in node:iter_children() do walk(child, depth+1) end
end

-- Find composite_literal nodes
local function find(node, typename, depth)
    if node:type() == typename then
        walk(node, 0)
        print('---')
    end
    if depth < 10 then
        for child in node:iter_children() do find(child, typename, depth+1) end
    end
end
find(root, 'composite_literal', 0)
