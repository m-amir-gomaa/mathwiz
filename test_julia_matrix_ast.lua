-- Debug Julia matrix AST
local bufnr = vim.fn.bufadd('/home/qwerty/mathwiz.nvim/samples/test.jl')
vim.fn.bufload(bufnr)
local ok, p = pcall(vim.treesitter.get_parser, bufnr, 'julia')
if not ok then print('no parser: '..p); return end
local root = p:parse()[1]:root()
local function walk(node, depth)
    if depth > 7 then return end
    local text = vim.treesitter.get_node_text(node, bufnr):sub(1,30):gsub('\n',' ')
    print(string.rep('  ',depth)..node:type()..' => "'..text..'"')
    for child in node:iter_children() do walk(child, depth+1) end
end
-- Just walk the first few statements
local count = 0
for child in root:iter_children() do
    count = count + 1
    if count <= 2 then walk(child, 0) end
end
