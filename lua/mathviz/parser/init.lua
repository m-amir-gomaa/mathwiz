local config = require("mathviz.config")

local M = {}

M.lang_modules = {}

function M.get_lang_module(lang)
    if M.lang_modules[lang] ~= nil then
        return M.lang_modules[lang]
    end

    local ok, mod = pcall(require, "mathviz.languages." .. lang)
    if ok then
        M.lang_modules[lang] = mod
    else
        M.lang_modules[lang] = false
    end
    return M.lang_modules[lang]
end

function M.parse_buffer(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) then return {} end
    
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok or not parser then return {} end

    local lang = parser:lang()
    
    -- Check if language is enabled
    local lang_config = config.options.languages[lang]
    if not lang_config or not lang_config.enabled then return {} end
    
    local lang_mod = M.get_lang_module(lang)
    if not lang_mod then return {} end
    
    local tree = parser:parse()[1]
    if not tree then return {} end
    local root = tree:root()
    
    local results = {
        matrices = {},
        vectors = {},
        symbols = {},
    }

    if lang_mod.get_matrices and config.options.features.matrices then
        results.matrices = lang_mod.get_matrices(bufnr, root)
    end
    
    if lang_mod.get_vectors and config.options.features.vectors then
        results.vectors = lang_mod.get_vectors(bufnr, root)
    end

    if lang_mod.get_symbols and config.options.features.symbols then
        results.symbols = lang_mod.get_symbols(bufnr, root)
    end

    return results
end

return M
