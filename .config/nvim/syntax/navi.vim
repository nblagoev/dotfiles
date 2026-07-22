" Vim syntax file
" Language: Navi cheatsheets

if exists('b:current_syntax')
    finish
endif

" https://github.com/denisidoro/navi/blob/master/docs/widgets/howto/VIM.md
syntax match Comment '\v^;.*$'
syntax match Statement '\v^\%.*$'
syntax match Operator '\v^\#.*$'
syntax match String '\v\<.{-}\>'
syntax match String '\v^\$.*$'

let b:current_syntax = 'navi'
