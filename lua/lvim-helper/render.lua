local api = vim.api
local utils = require("lvim-helper.utils")
local config = require("lvim-helper.config")

local M = {}

local namespace_id = api.nvim_create_namespace("LvimHelperHighlights")

function M.render(file, num, all)
    local lines = utils.readlines(file)
    for k, _ in pairs(lines) do
        lines[k] = "  " .. lines[k] --
    end
    vim.api.nvim_buf_set_option(config.buf, "modifiable", true)

    api.nvim_buf_set_lines(
        config.buf,
        0,
        -1,
        true,
        {
            "  ----- Helper " .. num .. " / " .. all .. " -----  "
        }
    )
    api.nvim_buf_set_lines(config.buf, 1, -1, false, {" "})
    api.nvim_buf_set_lines(config.buf, 2, -1, false, lines)

    api.nvim_buf_add_highlight(config.buf, namespace_id, "LvimHelperTitle", 0, 0, -1)

    vim.api.nvim_buf_set_option(config.buf, "modifiable", false)
end

return M
