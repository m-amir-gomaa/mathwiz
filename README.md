# MathViz.nvim

`mathviz.nvim` is a Neovim plugin that adds an optional **visual mathematical and programming notation layer** on top of ordinary source code.

The primary motivation is to reduce the cognitive overhead of translating between programming syntax and mathematical notation while reasoning about mathematical code.

## Concept

The core principle of this plugin is:

> **The source code remains ordinary, valid, executable code. The plugin creates a separate visual mathematical notation layer on top of it.**

For example, when writing Python:

```python
A = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
]
```

MathViz visually renders it as a matrix:

```text
A = ⎡ 1  2  3 ⎤
    ⎢ 4  5  6 ⎥
    ⎣ 7  8  9 ⎦
```

while the actual buffer remains valid, ordinary Python source.

## Features

- **Matrix Visualization**: Turns nested lists and arrays into visually aligned mathematical matrices.
- **Math Mode & Symbol Prettification**: Renders `alpha` as `α`, `!=` as `≠`, `<= ` as `≤`, and more.
- **Cursor-Aware Reveal**: The mathematical overlay automatically disappears when your cursor enters the transformed region, allowing you to edit the original source naturally.
- **Multi-Language Support**: Works out of the box with Python, C, C++, Rust, Go, JavaScript, TypeScript, Lua, and Julia (via Treesitter).
- **Source Preservation**: Your files on disk are never altered.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "username/mathviz.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("mathviz").setup({
            enabled = true,
            -- Your configuration here
        })
    end
}
```

## Configuration

MathViz is highly configurable. You can toggle specific features and language support.

```lua
require("mathviz").setup({
    enabled = true,
    math_mode = {
        enabled_by_default = true,
    },
    features = {
        matrices = true,
        vectors = true,
        symbols = true,
    },
    languages = {
        python = { enabled = true },
        c = { enabled = true },
        -- ...
    },
    cursor = {
        reveal_on_hover = true,
    },
})
```

## Commands

- `:MathVizEnable` - Enable MathViz in the current session
- `:MathVizDisable` - Disable MathViz and clear all overlays
- `:MathVizToggle` - Toggle MathViz state

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to add support for new languages or extend the Treesitter queries.

## License

MIT License. See [LICENSE](LICENSE) for more details.
