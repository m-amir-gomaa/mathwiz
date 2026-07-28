-- Debug why Go matrix query returns 0
local bufnr = vim.fn.bufadd('/home/qwerty/mathwiz.nvim/samples/test.go')
vim.fn.bufload(bufnr)
local ok, p = pcall(vim.treesitter.get_parser, bufnr, 'go')
if not ok then print('no parser: '..p); return end
local root = p:parse()[1]:root()

local qs = [[
(composite_literal
  (literal_value
    (literal_element (literal_value) @row)
  )
) @matrix
]]
local ok2, q = pcall(vim.treesitter.query.parse, 'go', qs)
if not ok2 then print('query error: '..q); return end

local count = 0
for id, node in q:iter_captures(root, bufnr, 0, -1) do
    count = count + 1
    local text = vim.treesitter.get_node_text(node, bufnr):sub(1,40):gsub('\n',' ')
    print(q.captures[id]..' ['..node:type()..'] => '..text)
end
print('total: '..count)
