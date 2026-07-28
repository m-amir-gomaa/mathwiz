local M = {}

M.defaults = {
    enabled = true,
    math_mode = {
        enabled_by_default = true, -- True as requested by user
    },
    features = {
        matrices = true,
        vectors = true,
        operators = true,
        greek = true,
        superscripts = true,
        subscripts = true,
        fractions = true,
        sets = true,
        logic = true,
        calculus = true,
        piecewise = true,
        symbols = true,
        ligatures = true,
    },
    languages = {
        python = { enabled = true },
        c = { enabled = true },
        cpp = { enabled = true },
        rust = { enabled = true },
        go = { enabled = true },
        javascript = { enabled = true },
        typescript = { enabled = true },
        lua = { enabled = true },
        julia = { enabled = true },
    },
    cursor = {
        reveal_on_hover = true, -- Reveal original source when cursor enters the region
    },
}

M.options = {}

function M.setup(user_opts)
    M.options = vim.tbl_deep_extend("force", M.defaults, user_opts or {})
end

return M
