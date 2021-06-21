local api = vim.api
local utils = require 'lvim-helper.utils'
local settings = require 'lvim-helper.settings'

local M = {}

local namespace_id = api.nvim_create_namespace('LvimHelperHighlights')

function M.render(file, num, all)
    local lines = utils.readlines(file)
    for k, _ in pairs(lines) do
        lines[k] = '  ' .. lines[k] --
    end
    vim.api.nvim_buf_set_option(settings.settings.buf, 'modifiable', true)

    api.nvim_buf_set_lines(settings.settings.buf, 0, -1, true, {
        '  ----- Helper ' .. num .. ' / ' .. all .. ' -----  '
    })
    api.nvim_buf_set_lines(settings.settings.buf, 1, -1, false, {' '})
    api.nvim_buf_set_lines(settings.settings.buf, 2, -1, false, lines)

    api.nvim_buf_add_highlight(settings.settings.buf, namespace_id,
                               'LvimHelperTitle', 0, 0, -1)

    vim.api.nvim_buf_set_option(settings.settings.buf, 'modifiable', false)
end

return M
