local M = {}

function M.lvim_helper_callback(callback_name)
    return string.format(":lua require'lvim-helper.actions'.on_keypress('%s')<CR>", callback_name)
end

M.bindings = {
    ["]"] = M.lvim_helper_callback("next"),
    ["["] = M.lvim_helper_callback("prev"),
    ["q"] = M.lvim_helper_callback("close")
}

return M
