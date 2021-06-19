local va = vim.api
local settings = require 'lvim-helper.settings'
local utils = require 'lvim-helper.utils'
local actions = require 'lvim-helper.actions'
local win = require 'lvim-helper.win'
local buf = require 'lvim-helper.buf'

local M = {}

function M.setup(_settings)
    settings.settings = utils.merge(settings.settings, _settings)
end

function M.toggle()
    if win.is_win_open() then
        actions.close()
    else
        actions.open()
    end
end

return M
