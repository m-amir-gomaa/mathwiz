local bufnr = vim.fn.bufadd('/home/qwerty/mathwiz.nvim/samples/test.py')
vim.fn.bufload(bufnr)
local p = vim.treesitter.get_parser(bufnr, 'python')
local tree = p:parse()[1]
local root = tree:root()

local qs = [[
"lambda" @kw
"*" @kw
"and" @kw
"or" @kw
"not" @kw
"in" @kw
]]

local ok, q = pcall(vim.treesitter.query.parse, 'python', qs)
if not ok then print('Q ERR: '..q) return end
for id, node in q:iter_captures(root, bufnr, 0, -1) do
    print(q.captures[id]..' => "'..vim.treesitter.get_node_text(node, bufnr):sub(1,20)..'" (type='..node:type()..')')
end
