# MathWiz Python Sample — Full Coverage
# Run: python3 samples/test.py

import numpy as np
import scipy.linalg as la

# ── Matrices ──────────────────────────────────────────────────────────────────

# Native Python list-of-lists → visual matrix
A = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

# NumPy array → visual matrix
B = np.array([
    [1, 0, 0],
    [0, 1, 0],
    [0, 0, 1]
])

# Identity matrix
I = np.eye(3)

# Row vector
row = np.array([[1, 2, 3, 4, 5]])

# Column vector
col = np.array([[1], [2], [3], [4]])

# ── Greek Symbols ─────────────────────────────────────────────────────────────

alpha = 0.01       # learning rate  → α
beta = 0.9         # momentum       → β
gamma = 0.99       # discount       → γ
delta = 1e-5       # tolerance      → δ
epsilon = 1e-8     # numerical eps  → ε
theta = 0.5        # angle          → θ
lambda_ = 0.001    # regularization → λ
mu = 0.0           # mean           → μ
sigma = 1.0        # std dev        → σ
phi = 1.618        # golden ratio   → φ
psi = 0.0          # wavefunction   → ψ
omega = 2 * 3.14159  # angular freq → ω
pi = 3.14159         # pi           → π
tau = 2 * pi         # full turn    → τ

Alpha = 1.0    # → Α
Beta = 2.0     # → Β
Gamma = 3.0    # → Γ
Delta = 4.0    # → Δ
Sigma = 5.0    # → Σ
Omega = 6.0    # → Ω
Phi = 7.0      # → Φ
Lambda = 8.0   # → Λ

# ── Calculus & Analysis ───────────────────────────────────────────────────────

integral = 0.0     # → ∫
iint = 0.0         # double integral → ∬
iiint = 0.0        # triple integral → ∭
sum_val = 0.0      # → ∑
prod_val = 1.0     # → ∏
nabla = [0, 0, 0]  # gradient → ∇
partial = 0.0      # → ∂
infinity = float("inf")  # → ∞
inf = float("inf")        # → ∞
limit = 0.0        # → lim
sqrt2 = 2 ** 0.5   # → √2

# Superscripts: x**2 → x²
x = 3.0
x_sq = x**2    # → x²
x_cb = x**3    # → x³
x_4th = x**4   # → x⁴

# ── Set Theory ────────────────────────────────────────────────────────────────

emptyset = set()           # → ∅
union = {1, 2} | {3, 4}   # → ∪
intersection = {1,2} & {2,3}  # → ∩
subset = {1} <= {1, 2}     # → ⊂
subseteq = {1} <= {1, 2}   # → ⊆
complement = True          # → ∁
notin = 5 not in {1, 2}   # → ∉

# ── Logic & Proofs ────────────────────────────────────────────────────────────

forall = all([True, True, True])   # → ∀
exists = any([False, True])        # → ∃
therefore = True                   # → ∴
because = True                     # → ∵
implies = True                     # → ⇒
iff = True                         # → ⇔
xor = True ^ False                 # → ⊕

if alpha != beta and alpha <= 1.0 or beta >= 0:  # ≠ ∧ ≤ ∨ ≥
    pass

# ── Number Sets ───────────────────────────────────────────────────────────────

R = float  # Reals → ℝ
N = int    # Naturals → ℕ
Z = int    # Integers → ℤ
C = complex  # Complex → ℂ
Q = float    # Rationals → ℚ

# ── Probability & Statistics ─────────────────────────────────────────────────

E = np.mean(np.array([1, 2, 3, 4, 5]))      # Expected value → 𝔼
Var = np.var(np.array([1, 2, 3, 4, 5]))     # Variance → 𝕍
P = 0.5                                       # Probability → ℙ
expected_value = E                            # → 𝔼
prob = P                                      # → ℙ

approx = 3.14   # ≈ π
equiv = True    # ≡
propto = 0.5    # ∝
pm = 1.0        # ±
plus_minus = 1.0  # ±
norm = la.norm(np.array([3, 4]))  # ‖v‖
times = 3 * 4   # ×
dot = np.dot(np.array([1,2]), np.array([3,4]))  # ⋅

# ── Subscripts ────────────────────────────────────────────────────────────────

x_0 = 0.0  # x₀
x_1 = 1.0  # x₁
x_2 = 2.0  # x₂
x_i = 3.0  # xᵢ
x_n = 4.0  # xₙ
x_k = 5.0  # xₖ
a_0 = 0.0  # a₀
theta_k = 0.1  # θₖ

# ── Piecewise Functions ────────────────────────────────────────────────────────

# Detected as a piecewise block and rendered with ⎧ ⎨ ⎩ brace
piecewise_f = {
    "x**2": "if x > 0",
    "-x**2": "if x < 0",
    "0": "otherwise"
}

# ── Fractions ─────────────────────────────────────────────────────────────────

frac_1 = alpha / beta     # α ∕ β (rendered vertically)
frac_2 = mu / sigma       # μ ∕ σ
frac_3 = 1 / (1 + x)     # 1 ∕ (1 + x)  — sigmoid-style

if __name__ == "__main__":
    print("MathWiz Python sample loaded successfully.")
    print(f"E[X] = {E}")
    print(f"Var[X] = {Var}")
    print(f"||v|| = {norm}")
