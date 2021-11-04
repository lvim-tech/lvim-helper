local api = vim.api
local config = require "lvim-helper.config"
local bindings = require "lvim-helper.bindings"

local M = {}

function M.init()
    config.buf = api.nvim_create_buf(false, false)
    if not pcall(api.nvim_buf_set_name, config.buf, "LvimHelper") then
        api.nvim_buf_set_name(config.buf, "LvimHelper")
    end
    for k, v in pairs(config.bufopts) do
        vim.bo[config.buf][k] = v
    end
    for key, cb in pairs(bindings.bindings) do
        api.nvim_buf_set_keymap(config.buf, "n", key, cb, {noremap = true, silent = true, nowait = true})
    end
end

return M
