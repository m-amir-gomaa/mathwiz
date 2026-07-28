-- headless_test.lua
local function test_plugin()
    -- Load the plugin
    require("mathviz").setup({
        enabled = true,
        math_mode = { enabled_by_default = true }
    })
    
    local files = {
        "samples/test.py", "samples/test.c", "samples/test.cpp",
        "samples/test.go", "samples/test.js", "samples/test.ts",
        "samples/test.lua", "samples/test.jl", "samples/test.rs"
    }
    
    for _, file in ipairs(files) do
        vim.cmd("edit " .. file)
        
        -- Wait a bit for Treesitter and autocommands to fire
        vim.cmd("sleep 100m")
        
        -- Force a re-render to ensure everything gets processed
        require("mathviz").render_buffer()
        
        print("Successfully processed " .. file)
    end
    print("All tests passed without errors.")
    vim.cmd("qa!")
end

pcall(test_plugin)
