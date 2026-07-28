-- Test Julia operators
local ops = {'&&', '||', '&', '|', '!', '~', '*', 'and', 'or', '¬', '∧', '∨', '==', '!=', '<=', '>=', '->'}
for _, op in ipairs(ops) do
    local ok, q = pcall(vim.treesitter.query.parse, 'julia', '"'..op..'" @s')
    print(op..'='..(ok and 'Y' or 'N'))
end
print("--- identifier types ---")
local ok, q = pcall(vim.treesitter.query.parse, 'julia', '(identifier) @s')
print("identifier="..(ok and 'Y' or 'N'))
