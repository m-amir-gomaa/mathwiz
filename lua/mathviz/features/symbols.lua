local M = {}

M.symbol_map = {
    -- Greek
    alpha = "α", beta = "β", gamma = "γ", delta = "δ", epsilon = "ε", zeta = "ζ", eta = "η",
    theta = "θ", iota = "ι", kappa = "κ", lambda = "λ", mu = "μ", nu = "ν", xi = "ξ",
    omicron = "ο", pi = "π", rho = "ρ", sigma = "σ", tau = "τ", upsilon = "υ", phi = "φ",
    chi = "χ", psi = "ψ", omega = "ω",
    Alpha = "Α", Beta = "Β", Gamma = "Γ", Delta = "Δ", Epsilon = "Ε", Zeta = "Ζ", Eta = "Η",
    Theta = "Θ", Iota = "Ι", Kappa = "Κ", Lambda = "Λ", Mu = "Μ", Nu = "Ν", Xi = "Ξ",
    Omicron = "Ο", Pi = "Π", Rho = "Ρ", Sigma = "Σ", Tau = "Τ", Upsilon = "Υ", Phi = "Φ",
    Chi = "Χ", Psi = "Ψ", Omega = "Ω",

    -- Calculus & Analysis
    integral = "∫", iint = "∬", iiint = "∭",
    sum = "∑", prod = "∏", product = "∏",
    partial = "∂", df_dx = "∂", nabla = "∇", grad = "∇",
    limit = "lim", lim = "lim",
    infinity = "∞", inf = "∞",
    d = "d",

    -- Set Theory & Topology
    ["in"] = "∈", notin = "∉",
    subset = "⊂", subseteq = "⊆", supset = "⊃", supseteq = "⊇",
    union = "∪", intersection = "∩", intersect = "∩",
    emptyset = "∅", empty_set = "∅", complement = "∁",

    -- Logic & Proofs
    forall = "∀", for_all = "∀", exists = "∃", nexists = "∄",
    implies = "⇒", iff = "⇔",
    therefore = "∴", because = "∵",
    ["and"] = "∧", ["or"] = "∨", ["not"] = "¬", xor = "⊕",

    -- Linear Algebra, Probability, & ML Constants
    approx = "≈", equiv = "≡", propto = "∝",
    pm = "±", plus_minus = "±", mp = "∓",
    times = "×", div = "÷", dot = "⋅", circ = "∘",
    norm = "‖",

    -- Number Sets (Double-struck)
    R = "ℝ", C = "ℂ", N = "ℕ", Z = "ℤ", Q = "ℚ",
    
    -- Probability
    E = "𝔼", expected_value = "𝔼", Var = "𝕍", P = "ℙ", prob = "ℙ",
    
    -- General
    sqrt = "√"
}

M.subscript_map = {
    ["0"] = "₀", ["1"] = "₁", ["2"] = "₂", ["3"] = "₃", ["4"] = "₄",
    ["5"] = "₅", ["6"] = "₆", ["7"] = "₇", ["8"] = "₈", ["9"] = "₉",
    a = "ₐ", e = "ₑ", h = "ₕ", i = "ᵢ", j = "ⱼ", k = "ₖ", l = "ₗ",
    m = "ₘ", n = "ₙ", o = "ₒ", p = "ₚ", r = "ᵣ", s = "ₛ", t = "ₜ",
    u = "ᵤ", v = "ᵥ", x = "ₓ"
}

function M.render(bufnr, symbols)
    if not symbols then return end
    local extmarks = require("mathviz.renderer.extmarks")
    local config = require("mathviz.config")
    
    for _, sym in ipairs(symbols) do
        if config.options.cursor.reveal_on_hover and extmarks.is_cursor_in_range(bufnr, sym.start_row, sym.start_col, sym.end_row, sym.end_col) then
            -- do nothing
        else
            extmarks.set_extmark(bufnr, sym.start_row, sym.start_col, {
                end_row = sym.end_row,
                end_col = sym.end_col,
                conceal = "",
                virt_text = {{ sym.replacement, "MathVizSymbol" }},
                virt_text_pos = "overlay",
            })
        end
    end
end

return M
