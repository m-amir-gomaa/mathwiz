-- Debug Julia symbols
local bufnr = vim.fn.bufadd('/home/qwerty/mathwiz.nvim/samples/test.jl')
vim.fn.bufload(bufnr)
local ok, p = pcall(vim.treesitter.get_parser, bufnr, 'julia')
if not ok then print('no julia parser: '..p); return end
local root = p:parse()[1]:root()

-- Check what nodes exist in the file
local qs = [[(identifier) @symbol (operator) @symbol "->" @op_arrow]]
local ok2, q = pcall(vim.treesitter.query.parse, 'julia', qs)
if not ok2 then print('query error: '..q); return end

local symbols_module = require('mathviz.features.symbols')
local symbol_map = symbols_module.symbol_map

local matched = {}
local total = 0
for id, node in q:iter_captures(root, bufnr, 0, -1) do
    local cname = q.captures[id]
    local text = vim.treesitter.get_node_text(node, bufnr):sub(1,20)
    total = total + 1
    if cname == 'symbol' and symbol_map[text] then
        table.insert(matched, text..' => '..symbol_map[text])
    end
end
print('total='..total..', matched='..#matched)
for i=1,math.min(15,#matched) do print(matched[i]) end
