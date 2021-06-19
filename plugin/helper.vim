if !has('nvim-0.5') || exists('g:loaded_helper') | finish | endif

command! LvimHelper lua require'lvim-helper'.toggle()
