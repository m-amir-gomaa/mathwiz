-- Full end-to-end: parse each sample file and collect symbols
vim.opt.runtimepath:append('/home/qwerty/mathwiz.nvim')

local samples = {
    { 'python', '/home/qwerty/mathwiz.nvim/samples/test.py' },
    { 'c',      '/home/qwerty/mathwiz.nvim/samples/test.c' },
    { 'cpp',    '/home/qwerty/mathwiz.nvim/samples/test.cpp' },
    { 'rust',   '/home/qwerty/mathwiz.nvim/samples/test.rs' },
    { 'go',     '/home/qwerty/mathwiz.nvim/samples/test.go' },
    { 'javascript', '/home/qwerty/mathwiz.nvim/samples/test.js' },
    { 'typescript', '/home/qwerty/mathwiz.nvim/samples/test.ts' },
    { 'lua',    '/home/qwerty/mathwiz.nvim/samples/test.lua' },
    { 'julia',  '/home/qwerty/mathwiz.nvim/samples/test.jl' },
}

for _, entry in ipairs(samples) do
    local lang, path = entry[1], entry[2]
    local bufnr = vim.fn.bufadd(path)
    vim.fn.bufload(bufnr)

    local ok_p, p = pcall(vim.treesitter.get_parser, bufnr, lang)
    if not ok_p then print('PARSER FAIL '..lang..': '..tostring(p)); goto continue end

    local tree = p:parse()[1]
    if not tree then print('TREE FAIL: '..lang); goto continue end
    local root = tree:root()

    local ok_m, mod = pcall(require, 'mathviz.languages.'..lang)
    if not ok_m then print('MODULE FAIL '..lang..': '..tostring(mod)); goto continue end

    local ok_s, symbols = pcall(mod.get_symbols, bufnr, root)
    if not ok_s then print('SYMBOLS FAIL '..lang..': '..tostring(symbols)); goto continue end

    local ok_mat, matrices = pcall(mod.get_matrices, bufnr, root)
    if not ok_mat then print('MATRICES FAIL '..lang..': '..tostring(matrices)); goto continue end

    -- Show first 5 symbols
    local shown = {}
    for i = 1, math.min(5, #symbols) do
        table.insert(shown, '"'..symbols[i].replacement..'"')
    end
    print(string.format('OK %-12s  %d symbols, %d matrices  [%s]',
        lang, #symbols, #matrices, table.concat(shown, ', ')))

    ::continue::
end
