// MathWiz Rust Sample - Full Coverage
#![allow(unused, dead_code, non_snake_case)]
// Opens cleanly in Neovim with rust-analyzer (requires Cargo project)

// ── Matrices ──────────────────────────────────────────────────────────────────
fn test_matrices() {
    // Native 2D array — renders as a matrix
    let a = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
    ];

    // Row vector
    let row = [1, 2, 3, 4, 5];

    // Column vector (nested)
    let col = [[1], [2], [3], [4]];
}

// ── Greek Symbols ─────────────────────────────────────────────────────────────
fn test_greek() {
    let alpha = 1.0_f64;
    let beta = 2.0_f64;
    let gamma = 3.0_f64;
    let delta = 4.0_f64;
    let epsilon = 5.0_f64;
    let theta = 0.5_f64;
    let lambda = 0.01_f64;
    let mu = 0.0_f64;
    let sigma = 1.0_f64;
    let phi = 1.618_f64;
    let psi = 0.0_f64;
    let omega = 2.0 * std::f64::consts::PI;
}

// ── Calculus & Analysis ────────────────────────────────────────────────────────
fn test_calculus() {
    let integral = 0.0_f64;
    let iint = 0.0_f64;      // double integral
    let iiint = 0.0_f64;     // triple integral
    let sum = 0.0_f64;
    let prod = 1.0_f64;
    let nabla = [0.0, 0.0, 0.0]; // gradient vector
    let partial = 0.0_f64;   // partial derivative
    let infinity = f64::INFINITY;
    let inf = f64::INFINITY;
    let limit = 0.0_f64;
    let sqrt = f64::sqrt(2.0);
}

// ── Set Theory ────────────────────────────────────────────────────────────────
fn test_sets() {
    let emptyset: Vec<i32> = vec![];
    let union: Vec<i32> = vec![1, 2, 3, 4];
    let intersection: Vec<i32> = vec![2, 3];
    let subset = true;
    let subseteq = true;
    let complement: Vec<i32> = vec![5, 6, 7];
}

// ── Logic & Proofs ────────────────────────────────────────────────────────────
fn test_logic(alpha: bool, beta: bool) -> bool {
    let conj = alpha && beta;   // ∧
    let disj = alpha || beta;   // ∨
    let neg = !alpha;           // ¬
    let implies = !alpha || beta; // ⇒
    let iff = alpha == beta;      // ⇔

    let forall = true;
    let exists = false;
    let therefore = conj && disj;

    therefore
}

// ── Linear Algebra & Probability ─────────────────────────────────────────────
fn test_probability() {
    let approx = 3.14159_f64; // ≈ π
    let equiv = true;
    let propto = 0.5_f64;
    let pm = 1.0_f64;         // ±
    let norm = f64::sqrt(3.0_f64.powi(2) + 4.0_f64.powi(2));
    let times = 3.0_f64 * 4.0_f64; // ×
}

// ── Number Sets ───────────────────────────────────────────────────────────────
// R → ℝ, N → ℕ, Z → ℤ, C → ℂ, Q → ℚ
struct R; // Real numbers
struct N; // Natural numbers
struct Z; // Integers
struct Q; // Rationals

// ── Subscripts & Superscripts ─────────────────────────────────────────────────
fn test_subscripts() {
    let x_1 = 1.0_f64;   // x₁
    let x_2 = 2.0_f64;   // x₂
    let x_i = 3.0_f64;   // xᵢ
    let x_n = 4.0_f64;   // xₙ
    let a_0 = 0.0_f64;   // a₀
    let theta_k = 0.1_f64; // θₖ

    // Superscripts via pow
    let x_sq = f64::powi(x_1, 2); // x²
    let x_cb = f64::powi(x_1, 3); // x³
}

// ── Operators ─────────────────────────────────────────────────────────────────
fn test_operators(alpha: f64, beta: f64) {
    let neq = alpha != beta;   // ≠
    let leq = alpha <= beta;   // ≤
    let geq = alpha >= beta;   // ≥
    let dot = alpha * beta;    // ⋅
    let times = alpha * beta;  // ×
}

fn main() {
    test_matrices();
    test_greek();
    test_calculus();
    test_sets();
    test_logic(true, false);
    test_probability();
    test_subscripts();
    test_operators(1.0, 2.0);
    println!("MathWiz Rust sample loaded successfully.");
}
