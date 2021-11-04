local api = vim.api
local buf = require("lvim-helper.buf")
local config = require("lvim-helper.config")
local render = require("lvim-helper.render")
local utils = require("lvim-helper.utils")

local M = {}

local move_tbl = {left = "H", right = "L"}

function M.win_open()
    if config.buf == nil then
        buf.init() --
    end
    api.nvim_command("vsp")
    local move_to = move_tbl[config.side]
    api.nvim_command("wincmd " .. move_to)
    api.nvim_command("vertical resize " .. config.width)
    local winnr = api.nvim_get_current_win()
    config.tabpages[api.nvim_get_current_tabpage()] = winnr
    for k, v in pairs(config.winopts) do
        vim.wo[winnr][k] = v
    end
    vim.cmd("buffer " .. config.buf)
    local number_of_files = utils.size_of_table_files()
    render.render(config.files[config.current_file], config.current_file, number_of_files)
end

function M.win_close()
    if not M.is_win_open() then
        return
    end
    api.nvim_win_hide(M.get_winnr())
end

function M.is_win_open()
    return M.get_winnr() ~= nil and api.nvim_win_is_valid(M.get_winnr())
end

function M.get_winnr()
    return config.tabpages[api.nvim_get_current_tabpage()]
end

return M
