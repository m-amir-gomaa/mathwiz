vim.opt.rtp:append(".")

local parser = require("mathviz.parser")
local config = require("mathviz.config")

config.setup()

local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
    "A = [",
    "    [1, 2],",
    "    [3, 4],",
    "]"
})
vim.api.nvim_set_option_value("filetype", "python", { buf = bufnr })

-- Trigger treesitter parsing
local ok, ts_parser = pcall(vim.treesitter.get_parser, bufnr, "python")
if not ok or not ts_parser then
    print("Could not load python parser")
    os.exit(1)
end

local results = parser.parse_buffer(bufnr)
print("Matrices detected: " .. tostring(#results.matrices))
if #results.matrices > 0 then
    local mat = results.matrices[1]
    print("Matrix from row " .. mat.start_row .. " to " .. mat.end_row)
    print("Rows inside matrix: " .. tostring(#mat.rows))
end
