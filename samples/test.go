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

    // Advanced math symbols
    let subset = 1;
    let union = 2;
    let infinity = 3;
    let integral = 4;
    let x_1 = 5; // subscript
    let x_i = 6;
    let x_2 = 7;
    let sum = 8;
    let and_op = (subset && union); // logic
