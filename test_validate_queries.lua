-- Validate all language queries
local results = {}
local langs = {
    { "c", [[
(identifier) @symbol
"&&" @symbol
"||" @symbol
"!" @symbol
"*" @symbol
"!=" @op_neq
"<=" @op_leq
">=" @op_geq
"->" @op_arrow
]] },
    { "cpp", [[
(identifier) @symbol
"&&" @symbol
"||" @symbol
"!" @symbol
"*" @symbol
"and" @symbol
"or" @symbol
"not" @symbol
"!=" @op_neq
"<=" @op_leq
">=" @op_geq
"->" @op_arrow
]] },
    { "go", [[
(identifier) @symbol
"&&" @symbol
"||" @symbol
"!" @symbol
"*" @symbol
"!=" @op_neq
"<=" @op_leq
">=" @op_geq
"->" @op_arrow
]] },
    { "javascript", [[
(identifier) @symbol
"&&" @symbol
"||" @symbol
"!" @symbol
"*" @symbol
"!=" @op_neq
"!==" @op_neq
"<=" @op_leq
">=" @op_geq
"=>" @op_arrow
]] },
    { "typescript", [[
(identifier) @symbol
"&&" @symbol
"||" @symbol
"!" @symbol
"*" @symbol
"!=" @op_neq
"!==" @op_neq
"<=" @op_leq
">=" @op_geq
"=>" @op_arrow
]] },
    { "lua", [[
(identifier) @symbol
"and" @symbol
"or" @symbol
"not" @symbol
"*" @symbol
"~=" @op_neq
"<=" @op_leq
">=" @op_geq
]] },
    { "julia", [[
(identifier) @symbol
(operator) @symbol
"!=" @op_neq
"<=" @op_leq
">=" @op_geq
"->" @op_arrow
]] },
    { "python", [[
(identifier) @symbol
"lambda" @symbol
"*" @symbol
"and" @symbol
"or" @symbol
"not" @symbol
"in" @symbol
"!=" @op_neq
"<=" @op_leq
">=" @op_geq
"->" @op_arrow
(binary_operator left: (identifier) @base operator: "**" right: (integer) @exp) @superscript
]] },
    { "rust", [[
(identifier) @symbol
(field_identifier) @symbol
"*" @symbol
"&&" @symbol
"||" @symbol
"!" @symbol
"==" @symbol
"!=" @op_neq
"<=" @op_leq
">=" @op_geq
"->" @op_arrow
]] },
}

for _, entry in ipairs(langs) do
    local lang, qs = entry[1], entry[2]
    local ok, q = pcall(vim.treesitter.query.parse, lang, qs)
    if ok then
        print("OK: " .. lang)
    else
        print("FAIL: " .. lang .. " => " .. tostring(q))
    end
end
