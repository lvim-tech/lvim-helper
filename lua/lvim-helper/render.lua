local api = vim.api
local utils = require 'lvim-helper.utils'
local settings = require 'lvim-helper.settings'

local M = {}

function M.render(file, num, all)
    local lines = utils.readlines(file)
    for k, v in pairs(lines) do
        lines[k] = '  ' .. lines[k] --
    end
    vim.api.nvim_buf_set_option(settings.settings.buf, 'modifiable', true)
    api.nvim_buf_set_lines(buf, 0, -1, false, {
        '  ***** Helper ' .. num .. ' / ' .. all .. ' *****  '
    })
    api.nvim_buf_set_lines(buf, 1, -1, false, {' '})
    api.nvim_buf_set_lines(settings.settings.buf, 2, -1, false, lines)
    vim.api.nvim_buf_set_option(settings.settings.buf, 'modifiable', false)
end

return M
