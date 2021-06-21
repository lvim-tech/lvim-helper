local api = vim.api
local settings = require 'lvim-helper.settings'
local bindings = require 'lvim-helper.bindings'

local M = {}

function M.init()
    settings.settings.buf = api.nvim_create_buf(false, false)
    if not pcall(api.nvim_buf_set_name, settings.settings.buf, 'LvimHelper') then
        api.nvim_buf_set_name(settings.settings.buf, 'LvimHelper')
    end
    for k, v in pairs(settings.settings.bufopts) do
        vim.bo[settings.settings.buf][k] = v
    end
    for key, cb in pairs(bindings.bindings) do
        api.nvim_buf_set_keymap(settings.settings.buf, 'n', key, cb,
                                {noremap = true, silent = true, nowait = true})
    end
end

return M
