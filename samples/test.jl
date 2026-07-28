# Julia test file for MathViz.nvim

function test_matrices()
    A = [
        1 2 3;
        4 5 6;
    ]
end

function test_symbols()
    alpha = 1
    beta = 2
    subset = 1
    union = 2
    infinity = 3
    integral = 4
    x_1 = 5
    x_i = 6
    sum = 8
    
    if alpha != beta && alpha <= 10 || beta >= 2
        println("neq")
    end
end
