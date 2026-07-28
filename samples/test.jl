# Julia test file for MathViz.nvim

function test_matrices()
    A = [
        1 2 3;
        4 5 6;
        7 8 9
    ]
end

function test_symbols()
    alpha = 1
    beta = 2
    
    if alpha != beta
        println("neq")
    end
    if alpha <= 10
    end
    if beta >= 2
    end
end
