local M = {}

M.settings = {
    files = {},
    width = 80,
    side = 'right',
    current_file = 1,
    win = nil,
    buf = nil,
    tabpages = {},
    winopts = {
        relativenumber = false,
        number = false,
        list = false,
        winfixwidth = true,
        winfixheight = true,
        foldenable = false,
        spell = false,
        signcolumn = 'no',
        foldmethod = 'manual',
        foldcolumn = '0',
        cursorcolumn = false,
        colorcolumn = '0',
        wrap = false,
        winhl = table.concat({'Normal:LvimHelperNormal'}, ',')
    },
    bufopts = {
        swapfile = false,
        buftype = 'nofile',
        modifiable = false,
        filetype = 'LvimHelper',
        bufhidden = 'hide'
    }
}

return M
