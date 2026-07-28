# MathWiz.nvim 🧙‍♂️✨

MathWiz is a next-generation Neovim plugin that transforms your source code into beautiful, readable mathematics using Unicode characters and Neovim's blazing-fast `extmarks`. 

The core philosophy: **Your code remains pure ASCII/UTF-8 underneath, but your editor renders it as beautiful math.** Write `alpha_1 = np.array([[1], [2]])`, and read it as `α₁ = [ 1 ]...`. When your cursor enters the math, it instantly reverts to code for seamless editing!

## 🌟 Features

- **Beautiful Matrices**: Visually formats multi-dimensional arrays, matrices, and vectors into gorgeous mathematical matrix notations using robust Unicode box-drawing structures.
- **Greek & Mathematical Symbols**: Instantly maps identifiers like `alpha`, `beta`, `integral`, `sum` into their Unicode equivalents (`α`, `β`, `∫`, `∑`).
- **Subscripts Support**: Automatically maps trailing variables like `x_1` to `x₁`, `theta_i` to `θᵢ`, and supports explicit trailing underscores (`lambda_` → `λ`).
- **Logical & Relational Operators**: Elevates syntax operators. `!=` becomes `≠`, `<= ` becomes `≤`, `&&` becomes `∧`, and `||` becomes `∨`.
- **Zero Hacks. 100% Neovim Standard**: Completely powered by standard Neovim `vim.treesitter` APIs. No buggy regexes, no background binary processes, and no compilation steps. It works out of the box in Nix, MacOS, and Linux identically.

## 🚀 Installation

Install using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "m-amir-gomaa/mathwiz",
    config = function()
        require("mathviz").setup({
            -- Optional configuration here
        })
    end,
}
```

*Note: Requires Neovim 0.9+ and `nvim-treesitter` to be installed and configured.*

## 📖 Complete Language Registry

MathWiz supports an extensive set of languages via Treesitter. Here is the complete reference of what you can type to produce symbols in each language.

### 1. Variables & Greek Symbols (All Languages)
Type any of the following variables in your code. MathWiz intercepts the identifier and displays the mathematical glyph:
- **Greek Letters**: `alpha` (α), `beta` (β), `gamma` (γ), `delta` (δ), `epsilon` (ε), `zeta` (ζ), `eta` (η), `theta` (θ), `iota` (ι), `kappa` (κ), `lambda` (λ), `mu` (μ), `nu` (ν), `xi` (ξ), `omicron` (ο), `pi` (π), `rho` (ρ), `sigma` (σ), `tau` (τ), `upsilon` (υ), `phi` (φ), `chi` (χ), `psi` (ψ), `omega` (ω).
- **Capital Greek**: Type the uppercase variable, e.g., `Gamma` (Γ), `Delta` (Δ), `Theta` (Θ), `Lambda` (Λ), `Xi` (Ξ), `Pi` (Π), `Sigma` (Σ), `Upsilon` (Υ), `Phi` (Φ), `Psi` (Ψ), `Omega` (Ω).
- **Math/Calculus**: `infinity` (∞), `integral` (∫), `sum` (∑), `sqrt` (√), `nabla` (∇), `approx` (≈).
- **Set Theory**: `in` (∈), `subset` (⊂), `union` (∪), `intersection` (∩).

### 2. Subscripts (All Languages)
If you append an underscore and alphanumeric characters to *any variable* (even non-Greek ones), MathWiz turns them into subscripts.
- `x_1` → `x₁`
- `theta_i` → `θᵢ`
- `W_out` → `Wₒᵤₜ`
- `lambda_` → `λ` (Trailing underscore is gracefully dropped. Great for Python's `lambda_` variable conventions!)

### 3. Operators (Language Specific)
MathWiz cleverly hooks into the Treesitter AST to intercept language-specific operators without breaking string literals or comments.

| Operator Meaning | Code Typed | Rendered As | Supported Languages |
| :--- | :--- | :--- | :--- |
| **Not Equal** | `!=` (or `~=` in Lua) | `≠` | C, C++, Rust, Go, Python, JS, TS, Lua, Julia |
| **Less/Eq** | `<=` | `≤` | C, C++, Rust, Go, Python, JS, TS, Lua, Julia |
| **Greater/Eq** | `>=` | `≥` | C, C++, Rust, Go, Python, JS, TS, Lua, Julia |
| **Logical AND** | `&&` (or `and` in Python/Lua) | `∧` | C, C++, Rust, Go, Python, JS, TS, Lua, Julia |
| **Logical OR** | `||` (or `or` in Python/Lua) | `∨` | C, C++, Rust, Go, Python, JS, TS, Lua, Julia |
| **Logical NOT** | `!` (or `not` in Python/Lua) | `¬` | C, C++, Rust, Go, Python, JS, TS, Lua, Julia |
| **Multiply** | `*` | `×` | C, C++, Rust, Go, Python, JS, TS, Lua, Julia |
| **Arrow (Func)** | `->` | `→` | C, C++, Rust, Go, Python, Julia |

### 4. Matrices & Vectors
MathWiz parses multidimensional array literals and renders them gracefully. 
- **Row Vectors** (e.g. `[[1, 2, 3]]`) are cleanly rendered with standard square brackets: `[ 1 2 3 ]`
- **Column & Multi-Row Matrices** (e.g. nested lists formatted across multiple lines) are given robust vertical Unicode brackets:
```python
# What you type:
B = np.array([
    [1, 0, 0],
    [0, 1, 0],
    [0, 0, 1]
])

# What MathWiz renders:
B = np.array(
    ┌ 1  0  0 ┐
    │ 0  1  0 │
    └ 0  0  1 ┘
)
```
*(Note: Flattened matrices typed explicitly on a single line like `[[1], [2]]` are intentionally skipped by the matrix renderer to prevent horizontal box-bracket layout collisions.)*

## ⚙️ Configuration

Default configuration options (passed into `require("mathviz").setup(...)`):

```lua
{
    highlight_groups = {
        symbol = "MathVizSymbol",   -- Highlight group for math symbols
        bracket = "MathVizBracket", -- Highlight group for matrix brackets
    },
    options = {
        cursor = {
            reveal_on_hover = true, -- Reveals the underlying raw code when your cursor enters the math symbol/matrix!
        }
    }
}
```

## 🤝 Contributing

This plugin embraces reproducibility and standards. If your language is missing, simply duplicate one of the query files in `lua/mathviz/languages/` and add your Treesitter AST captures for `@matrix`, `@row`, and `@symbol`.

Built with ✨ and Neovim Extmarks.
