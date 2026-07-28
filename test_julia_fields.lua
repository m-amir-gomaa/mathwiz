-- Figure out Julia binary_expression fields
local code = "a != b\na <= b\na >= b\na -> b"
local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(code, '\n'))
vim.bo[bufnr].filetype = 'julia'
local ok, p = pcall(vim.treesitter.get_parser, bufnr, 'julia')
if not ok then print('parser error: '..p); return end
local tree = p:parse()[1]
local root = tree:root()

-- Print AST with field names
local function walk(node, depth)
    local text = vim.treesitter.get_node_text(node, bufnr):sub(1,20):gsub('\n',' ')
    local fields = {}
    for i = 0, node:child_count()-1 do
        local child = node:child(i)
        local field = node:field_name_for_child(i)
        if field then
            table.insert(fields, field.."="..child:type())
        end
    end
    print(string.rep('  ',depth)..node:type()
        ..(#fields > 0 and ' ['..table.concat(fields, ', ')..']' or '')
        ..' => "'..text..'"')
    for child in node:iter_children() do walk(child, depth+1) end
end
walk(root, 0)
