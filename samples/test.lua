-- Lua test file for MathViz.nvim

local function test_matrices()
    local A = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    }
end

local function test_symbols()
    local alpha = 1
    local beta = 2
    
    if alpha ~= beta then
        print("neq")
    end
    if alpha <= 10 then end
    if beta >= 2 then end
end
