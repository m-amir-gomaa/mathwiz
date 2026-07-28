import glob
import re

extra_mappings = """
    -- Sets
    ["in"] = "∈", subset = "⊂", union = "∪", intersection = "∩",
    -- Logic
    ["and"] = "∧", ["or"] = "∨", ["not"] = "¬",
    -- Calculus & General
    infinity = "∞", sum = "∑", integral = "∫", sqrt = "√", nabla = "∇", approx = "≈"
"""

subscript_logic = """
            local text = vim.treesitter.get_node_text(node, bufnr)
            if greek_map[text] then
                table.insert(symbols, {
                    start_row = range.start_row, start_col = range.start_col,
                    end_row = range.end_row, end_col = range.end_col,
                    replacement = greek_map[text]
                })
            else
                local base, sub = text:match("^([a-zA-Z]+)_([0-9i-n])$")
                if base and sub then
                    local sub_map = {
                        ["0"]="₀", ["1"]="₁", ["2"]="₂", ["3"]="₃", ["4"]="₄",
                        ["5"]="₅", ["6"]="₆", ["7"]="₇", ["8"]="₈", ["9"]="₉",
                        ["i"]="ᵢ", ["j"]="ⱼ", ["k"]="ₖ", ["l"]="ₗ", ["m"]="ₘ", ["n"]="ₙ"
                    }
                    if sub_map[sub] then
                        table.insert(symbols, {
                            start_row = range.start_row, start_col = range.start_col,
                            end_row = range.end_row, end_col = range.end_col,
                            replacement = base .. sub_map[sub]
                        })
                    end
                end
            end
"""

for filepath in glob.glob("lua/mathviz/languages/*.lua"):
    with open(filepath, "r") as f:
        content = f.read()

    # Inject extra_mappings into greek_map
    content = re.sub(
        r'(phi = "φ", omega = "ω",)',
        r'\1\n' + extra_mappings,
        content
    )
    
    # Replace the old greek_map lookup with the new logic for subscripts
    old_logic = """local text = vim.treesitter.get_node_text(node, bufnr)
            if greek_map[text] then
                table.insert(symbols, {
                    start_row = range.start_row,
                    start_col = range.start_col,
                    end_row = range.end_row,
                    end_col = range.end_col,
                    replacement = greek_map[text]
                })
            end"""
    
    # Simple replacement if the old logic matches closely
    if "greek_map[text]" in content:
        # Instead of exact match, just do a regex replace
        content = re.sub(
            r'local text = vim\.treesitter\.get_node_text\(node, bufnr\)[\s\S]*?replacement = greek_map\[text\]\s*\}\)\s*end',
            subscript_logic.strip().replace('\\', '\\\\'),
            content
        )
        
    with open(filepath, "w") as f:
        f.write(content)

