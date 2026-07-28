if vim.g.loaded_mathviz == 1 then
    return
end
vim.g.loaded_mathviz = 1

-- The user is expected to call require("mathviz").setup(), which
-- will then setup the commands and autocmds. 
-- However, we can setup commands lazily if needed. For now, 
-- we leave this mostly empty or just ensure it's a valid plugin file.
