local M = {}

M.settings = {
    width = 80,
    side = 'right',
    files = {},
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
        signcolumn = 'yes',
        foldmethod = 'manual',
        foldcolumn = '0',
        cursorcolumn = false,
        colorcolumn = '0'
    },
    bufopts = {
        swapfile = false,
        buftype = '',
        modifiable = false,
        filetype = 'LvimHelper',
        bufhidden = 'hide'
    }
}

return M
