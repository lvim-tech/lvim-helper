local config = require("lvim-helper.config")
local utils = require("lvim-helper.utils")
local actions = require("lvim-helper.actions")
local win = require("lvim-helper.win")

local M = {}

function M.setup(user_config)
    utils.merge(config, user_config)
end

function M.toggle()
    if win.is_win_open() then
        actions.close()
    else
        actions.open()
    end
end

return M
