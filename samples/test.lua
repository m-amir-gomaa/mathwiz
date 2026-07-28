-- Lua test file for MathViz.nvim

local function test_matrices()
    local A = {
        {1, 2, 3},
        {4, 5, 6}
    }
end

local function test_symbols()
    local alpha = 1
    local subset = 1
    local union = 2
    local infinity = 3
    local integral = 4
    local x_1 = 5
    local x_i = 6
    local sum = 8
    
    if alpha ~= x_1 and alpha <= 10 or x_i >= 2 then
        print("neq")
    end
end
