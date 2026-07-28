// C++ test file for MathViz.nvim
#include <iostream>

void test_matrices() {
    int A[3][3] = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };
}

void test_symbols() {
    int alpha = 1;
    int beta = 2;
    
    if (alpha != beta) {
        std::cout << "neq";
    }
    if (alpha <= 10) {}
    if (beta >= 2) {}
    
    // -> operator
    // ptr->method();
}
