# LVIM HELPER - Neovim pluginq written in Lua. Show your custom help files.

![lvim-logo](https://user-images.githubusercontent.com/82431193/115121988-3bc06800-9fbe-11eb-8dab-19f624aa7b93.png)

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://github.com/lvim-tech/lvim-colorscheme/blob/main/LICENSE)

## Neovim configuration - [LVIM](https://github.com/lvim-tech/lvim)

## Neovim colorscheme - [LVIM COLORSCHEME](https://github.com/lvim-tech/lvim-colorscheme) (with support `LvimHelper`)

## Screenshot

![LvimHelper.png](https://github.com/lvim-tech/lvim-helper/blob/main/media/LvimHelper.png)

## Requirements

- [neovim nightly(>=0.5.0)](https://github.com/neovim/neovim/wiki/Installing-Neovim)

## Install

```lua
use {'lvim-tech/lvim-helper'}
```

## Usage

```lua
local home = os.getenv('HOME')
require('lvim-helper').setup({
    files = {
        home .. '/path/to/your/file1.md',
        home .. '/path/to/your/file2.md',
        home .. '/path/to/your/file3.md',
    }
})
```

> You can add an unlimited number of files

## Command

```
:LvimHelper
```

## Keymaps

| Key | Description   |
| --- | ------------- |
| `]` | Next file     |
| `[` | Previous file |
| `q` | Quit          |

> If you want custom keysmaps:

```lua
local lvim_helper_bindings = require('lvim-helper.bindings');
lvim_helper_bindings.bindings = {
    ["n"] = lvim_helper_bindings.lvim_helper_callback("next"),
    ["p"] = lvim_helper_bindings.lvim_helper_callback("prev"),
    ["q"] = lvim_helper_bindings.lvim_helper_callback("close")
}
```

> IMPORTANT: Define before `require('lvim-helper').setup({...})`

## All settings

```lua
local home = os.getenv('HOME')
require('lvim-helper').setup({
    files = {
        home .. '/path/to/your/file1.md',
        home .. '/path/to/your/file2.md',
        home .. '/path/to/your/file3.md',
    },
    width = 80,
    side = 'right',
    current_file = 1,
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
})
```
