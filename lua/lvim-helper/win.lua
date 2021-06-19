local api = vim.api
local buf = require 'lvim-helper.buf'
local settings = require 'lvim-helper.settings'
local render = require 'lvim-helper.render'
local utils = require 'lvim-helper.utils'

local M = {}

local move_tbl = {left = 'H', right = 'L'}

function M.win_open()
    if settings.settings.buf == nil then
        buf.init() --
    end
    api.nvim_command("vsp")
    local move_to = move_tbl[settings.settings.side]
    api.nvim_command("wincmd " .. move_to)
    api.nvim_command("vertical resize " .. settings.settings.width)
    local winnr = api.nvim_get_current_win()
    settings.settings.tabpages[api.nvim_get_current_tabpage()] = winnr
    for k, v in pairs(settings.settings.winopts) do vim.wo[winnr][k] = v end
    vim.cmd("buffer " .. settings.settings.buf)
    local number_of_files = utils.size_of_table_files()
    render.render(settings.settings.files[settings.settings.current_file],
                  settings.settings.current_file, number_of_files)
end

function M.win_close()
    if not M.is_win_open() then return end
    api.nvim_win_hide(buf.get_winnr())
end

function M.is_win_open()
    return buf.get_winnr() ~= nil and api.nvim_win_is_valid(buf.get_winnr())
end

return M
