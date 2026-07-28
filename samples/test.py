# Python Max Coverage Sample

import numpy as np
import torch
import jax.numpy as jnp
import tensorflow as tf

def test_matrices():
    # Native
    A = [
        [1, 2, 3],
        [4, 5, 6]
    ]
    
    # ML Frameworks
    B = np.array([
        [1, 2],
        [3, 4]
    ])
    
    C = torch.tensor([
        [5, 6],
        [7, 8]
    ])

    D = jnp.array([
        [9, 10]
    ])

    E = tf.constant([
        [11, 12]
    ])

def test_symbols():
    alpha = 1
    beta = 2
    subset = 1
    union = 2
    infinity = 3
    integral = 4
    x_1 = 5
    x_i = 6
    sum = 8
    
    if alpha != beta and alpha <= 10 or beta >= 2:
        pass
        
    x_2 = x_1 ** 2

def test_fractions_and_piecewise():
    # Fraction
    x = alpha / beta
    
    # Piecewise
    f = {
        x**2: x > 0,
        0: "otherwise"
    }
