// TypeScript test file for MathViz.nvim

function testMatrices(): void {
    const A: number[][] = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ];
}

function testSymbols(): void {
    let alpha: number = 1;
    let beta: number = 2;
    
    if (alpha !== beta) {
        console.log("neq");
    }
    if (alpha <= 10) {}
    if (beta >= 2) {}
    
    // => operator
    const fn = (x: number): number => x * 2;
}
