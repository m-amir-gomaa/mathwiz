# Python test file for MathViz.nvim

def test_matrices():
    A = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ]
    
    # Vector
    v = [
        [1],
        [2],
        [3]
    ]

def test_symbols():
    alpha = 1
    beta = 2
    
    if alpha != beta:
        pass
    if alpha <= 10:
        pass
    if beta >= 2:
        pass
    
    # Custom arrow mapping
    # A -> B
