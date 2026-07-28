-- Test: load each language module and run its query parse
local langs = {'c','cpp','go','javascript','typescript','lua','julia','python','rust'}
-- Add mathwiz path to runtimepath
local mathwiz_path = '/home/qwerty/mathwiz.nvim'
vim.opt.runtimepath:append(mathwiz_path)
package.path = mathwiz_path .. '/lua/?.lua;' .. mathwiz_path .. '/lua/?/init.lua;' .. package.path

for _, lang in ipairs(langs) do
    local ok, mod = pcall(require, 'mathviz.languages.' .. lang)
    if not ok then
        print('LOAD FAIL: ' .. lang .. ' => ' .. tostring(mod))
    elseif type(mod.get_symbols) ~= 'function' then
        print('FAIL: ' .. lang .. ' - no get_symbols')
    else
        print('OK: ' .. lang)
    end
end
