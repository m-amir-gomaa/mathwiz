import os

samples = {
    "test.c": """
#include <stdio.h>

void test_matrices() {
    int A[2][3] = {
        {1, 2, 3},
        {4, 5, 6}
    };
}

void test_symbols() {
    int alpha = 1;
    int beta = 2;
    int integral = 0;
    int infinity = 999;
    int x_1 = 5;
    
    if (alpha != beta && alpha <= 10 || beta >= 2) {
        // do something
    }
}
""",
    "test.cpp": """
#include <vector>
#include <iostream>

void test_matrices() {
    std::vector<std::vector<int>> A = {
        {1, 2, 3},
        {4, 5, 6}
    };
}

void test_symbols() {
    int alpha = 1;
    int beta = 2;
    int integral = 0;
    int infinity = 999;
    int x_1 = 5;
    
    if (alpha != beta && alpha <= 10 || beta >= 2) {
        // do something
    }
}
""",
    "test.go": """
package main

func test_matrices() {
    A := [][]int{
        {1, 2, 3},
        {4, 5, 6},
    }
}

func test_symbols() {
    alpha := 1
    beta := 2
    integral := 0
    infinity := 999
    x_1 := 5
    
    if alpha != beta && alpha <= 10 || beta >= 2 {
        // do something
    }
}
""",
    "test.js": """
function test_matrices() {
    const A = [
        [1, 2, 3],
        [4, 5, 6]
    ];
}

function test_symbols() {
    let alpha = 1;
    let beta = 2;
    let integral = 0;
    let infinity = 999;
    let x_1 = 5;
    
    if (alpha !== beta && alpha <= 10 || beta >= 2) {
        // do something
    }
}
""",
    "test.ts": """
function test_matrices() {
    const A: number[][] = [
        [1, 2, 3],
        [4, 5, 6]
    ];
}

function test_symbols() {
    let alpha = 1;
    let beta = 2;
    let integral = 0;
    let infinity = 999;
    let x_1 = 5;
    
    if (alpha !== beta && alpha <= 10 || beta >= 2) {
        // do something
    }
}
"""
}

os.makedirs("samples", exist_ok=True)
for filename, content in samples.items():
    with open(f"samples/{filename}", "w") as f:
        f.write(content.strip() + "\\n")
