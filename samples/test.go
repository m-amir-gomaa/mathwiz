// Go test file for MathViz.nvim
package main

import "fmt"

func testMatrices() {
    A := [][]int{
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9},
    }
    fmt.Println(A)
}

func testSymbols() {
    alpha := 1
    beta := 2
    
    if alpha != beta {
        fmt.Println("neq")
    }
    if alpha <= 10 {}
    if beta >= 2 {}
}
