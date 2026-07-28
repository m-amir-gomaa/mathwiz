# Contributing to MathViz.nvim

Contributions are highly welcome!

## Adding Language Support

To add support for a new language:

1. Create a new file `lua/mathviz/languages/<lang>.lua`
2. Implement `get_matrices(bufnr, root)` and/or `get_symbols(bufnr, root)` using Neovim Treesitter queries.
3. Look at `lua/mathviz/languages/python.lua` or `c.lua` for examples.
4. Add the language to the default configuration in `lua/mathviz/config.lua`.

## Adding Features

To add a new structural renderer (like fractions or piecewise functions):

1. Add the parser logic to identify the structures in the respective language files.
2. Create a renderer in `lua/mathviz/renderer/<feature>.lua` that applies the extmarks.
3. Update `update_buffer` in `lua/mathviz/init.lua` to call your renderer.
