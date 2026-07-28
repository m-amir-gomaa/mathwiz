-- Debug Go symbol captures
local bufnr = vim.fn.bufadd('/home/qwerty/mathwiz.nvim/samples/test.go')
vim.fn.bufload(bufnr)
local ok, p = pcall(vim.treesitter.get_parser, bufnr, 'go')
if not ok then print('no parser: '..p); return end
local root = p:parse()[1]:root()

local qs = [[
(identifier) @symbol
"&&" @symbol
"||" @symbol
"!" @symbol
"*" @symbol
"!=" @op_neq
"<=" @op_leq
">=" @op_geq
]]
local ok2, q = pcall(vim.treesitter.query.parse, 'go', qs)
if not ok2 then print('query error: '..q); return end

local symbols_module = require('mathviz.features.symbols')
local symbol_map = symbols_module.symbol_map

local count = 0
local matched = 0
for id, node in q:iter_captures(root, bufnr, 0, -1) do
    local cname = q.captures[id]
    local text = vim.treesitter.get_node_text(node, bufnr):sub(1,20)
    count = count + 1
    if cname == 'symbol' and symbol_map[text] then
        matched = matched + 1
        if matched <= 10 then
            print('MATCH: '..text..' => '..symbol_map[text])
        end
    elseif cname ~= 'symbol' then
        print('OP: '..cname..' => '..text)
    end
end
print('total captures='..count..', symbol matches='..matched)
