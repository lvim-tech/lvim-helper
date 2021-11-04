local config = require("lvim-helper.config")
local win = require("lvim-helper.win")
local render = require("lvim-helper.render")
local utils = require("lvim-helper.utils")

local M = {}

function M.next()
    local number_of_files = utils.size_of_table_files()
    config.current_file = config.current_file + 1
    if config.current_file > number_of_files then
        config.current_file = 1
    end
    render.render(config.files[config.current_file], config.current_file, number_of_files)
end

function M.prev()
    local number_of_files = utils.size_of_table_files()
    config.current_file = config.current_file - 1
    if config.current_file < 1 then
        config.current_file = number_of_files
    end
    render.render(config.files[config.current_file], config.current_file, number_of_files)
end

local keypress_funcs = {
    next = function()
        M.next()
    end,
    prev = function()
        M.prev()
    end,
    close = function()
        M.close()
    end
}

function M.on_keypress(mode)
    if keypress_funcs[mode] then
        return keypress_funcs[mode]()
    end
end

function M.open()
    win.win_open()
end

function M.close()
    win.win_close()
end

return M
