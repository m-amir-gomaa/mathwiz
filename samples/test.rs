// Rust Max Coverage Sample

use ndarray::arr2;

fn test_matrices() {
    let native = [
        [1, 2, 3],
        [4, 5, 6]
    ];
    
    let ml_arr = arr2![
        [1, 2],
        [3, 4]
    ];
}

fn test_symbols() {
    let alpha = 1;
    let beta = 2;
    let subset = 1;
    let union = 2;
    let infinity = 3;
    let integral = 4;
    let x_1 = 5;
    let x_i = 6;
    let sum = 8;
    
    if alpha != beta && alpha <= 10 || beta >= 2 {
        // ...
    }
}
