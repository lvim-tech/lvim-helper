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
    vim.cmd "au! BufWinEnter * lua require'lvim-helper.buf'._prevent_buffer_override()"
end

local goto_tbl = {right = 'h', left = 'l'}

function M._prevent_buffer_override()
    vim.schedule(function()
        local curwin = api.nvim_get_current_win()
        local curbuf = api.nvim_win_get_buf(curwin)
        if curwin ~= M.get_winnr() or curbuf == settings.settings.buf then
            return
        end
        vim.cmd("buffer " .. settings.settings.buf)
        vim.cmd("vsplit")
        if #vim.api.nvim_list_wins() < 2 then
        else
            vim.cmd("wincmd " .. goto_tbl[settings.settings.side])
        end
        vim.cmd("buffer " .. curbuf)
    end)
end

function M.get_winnr()
    return settings.settings.tabpages[api.nvim_get_current_tabpage()]
end

return M
