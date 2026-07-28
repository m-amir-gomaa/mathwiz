#!/bin/bash
for file in samples/test.*; do
  cat << 'INNER_EOF' >> "$file"

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
INNER_EOF
done
