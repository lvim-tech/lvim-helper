if !has('nvim-0.5') || exists('g:loaded_lvimhelper') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

command! LvimHelper lua require'lvim-helper'.toggle()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_lvimhelper = 1