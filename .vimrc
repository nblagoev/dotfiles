let mapleader = ","

" pathogen as a bundle
runtime bundle/vim-pathogen/autoload/pathogen.vim

set nocompatible
call pathogen#infect()

set rtp+=/opt/homebrew/opt/fzf

syntax on
filetype plugin indent on

set backspace=indent,eol,start
" make arrow keys wrap lines and whitespace properly
set whichwrap=b,s,<,>,[,]
set number
set ic
set smartcase
set autoindent
set incsearch

" no wrapping by default. Use `:set wrap` to re-enable
set nowrap

set hlsearch
" Clear search highlight by hitting enter
nnoremap <silent> <CR> :noh<CR>

" Spell checking. Does not offer suggestions, which makes you learn.
set spell

set cursorline
set cursorcolumn
" Stop the pause that you no longer notice exiting insert mode
set ttimeoutlen=50

" Filetype mappings
au BufNewFile,BufRead *.conf.j2            set filetype=dosini
au BufNewFile,BufRead *.conf               set filetype=dosini
au BufNewFile,BufRead *.md                 set filetype=markdown
au BufNewFile,BufRead *.spec               set filetype=python
au BufNewFile,BufRead .aliases             set filetype=sh
au BufNewFile,BufRead /etc/nginx/sites-*/* set filetype=nginx
au BufNewFile,BufRead /etc/nginx/conf.d/*  set filetype=nginx
au BufNewFile,BufRead *nginx*.conf         set filetype=nginx
au BufNewFile,BufRead .envrc               set filetype=sh

autocmd BufReadPost,BufWrite * :FixWhitespace

" It's not the 70's anymore. Use git or something.
set noswapfile
set nobackup

" get rid of the engulfing behavior of highlighting matching brackets
" when inside parenthesis. It makes the cursor hard to distinguish.
set noshowmatch

" NoMatchParen " this works as a command but not a setting
" this does work, fooling the matching system into
let loaded_matchparen = 1

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" no point in pressing/releasing the shift key -- slightly faster
nnoremap ; :

" Stops regression to arrow keys, encourages learning of advanced motion keys
" nnoremap <Left> :echo "Use [h] for left"<CR>
" nnoremap <Right> :echo "Use [l] for right"<CR>
" nnoremap <Up> :echo "Use [k] for up"<CR>
" nnoremap <Down> :echo "Use [j] for down"<CR>

" inoremap <Left> <C-o>:echo "Use [h] for left in NORMAL mode"<CR>
" inoremap <Right> <C-o>:echo "Use [l] for right in NORMAL mode"<CR>
" inoremap <Up> <C-o>:echo "Use [k] for up in NORMAL mode"<CR>
" inoremap <Down> <C-o>:echo "Use [j] for down in NORMAL mode"<CR>

" vnoremap <Left> <Esc>:echo "Use [h] for left"<CR>
" vnoremap <Right> <Esc>:echo "Use [l] for right"<CR>
" vnoremap <Up> <Esc>:echo "Use [k] for up"<CR>
" vnoremap <Down> <Esc>:echo "Use [j] for down"<CR>

let g:SuperTabNoCompleteAfter = ['^', '\s', '//', '#']

set background=dark
let g:gruvbox_invert_tabline = 1
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
" TODO fix this with terminfo databases
" let g:gruvbox_italic = 1

" TODO add test for truecolour capability
if (has("termguicolors"))
    " TODO set conditionally when Tc support is done
    "set termguicolors
endif

colorscheme gruvbox

" remove grey background colour (better contrast) (black or NONE)
"highlight Normal ctermbg=black guibg=black
"highlight NonText ctermbg=black guibg=black

" make line number distinct from text
highlight LineNr ctermbg=235 guibg=#262626

" anti typo (command aliases)
" source: .viminfo
ca WQ wq
ca Wq wq
ca wQ wq
ca qw wq
ca q1 q!
ca 'q q
ca q; q
ca qq q
ca W  w
ca Q  q
ca Wqaz wqa
ca Wqqa wqa
ca Wqa  wqa
ca WQa  wqa
ca WQA  wqa

" gf opens the file under cursor, which is great for navigating a hierarchy of files.
" Change gF to open file under cursor in new tab, not new pane, like CTRL+W gF
nnoremap gF <C-w>gf

" Ex mode? WTF VIM?
map Q <Nop>

" re-flow entire paragraph
nmap Q gqap

" Enable mouse mode. Use xterm >= 277 for mouse mode for large terms.
set mouse=a

" legacy vim-only stuff
if !has('nvim')
    set ttymouse=xterm2
    " disable connecting to X11 for the sake of clipboard support
    " https://stackoverflow.com/questions/10718573/vim-x-flag-as-vimrc-entry
    " allternative to -X (which is a pain with aliases/git)
    set clipboard=exclude:.*
endif

" abbreviations
ab teh the
ab THe The
ab eb be

" max. number of tabs open at once.
set tabpagemax=25

" open help in new tab
cabbrev help tab help

" 'message for reading a file overwrites any previous message'
set shortmess=O

" keep window split size equal on resize
" http://stackoverflow.com/questions/14649698/how-to-resize-split-windows-in-vim-proportionally
autocmd VimResized * :wincmd =

" Enable extended regular expressions by default on search. Also makes it
" consistent with :%s//g commands.
" This stops having to escape all regex metachars
set magic
" This is too annoying, as it's triggered wherever you have /. Remember to do \v manually instead.
" No better solution online atm.
"nnoremap / /\v
"cnoremap s/ s/\v

" some plugins/commands/aliases assume bash and break when using fish.
set shell=bash

" some emacs/readline style normal mode nav that is hardcoded to my brain
map <C-a> <Home>
map <C-e> <End>
noremap! <C-a> <Home>
noremap! <C-e> <End>

" Source vimrc with <Leader>vc
nnoremap <Leader>vc :source ~/.vimrc<CR>:echo "Reloaded .vimrc"<CR>

" Clear trailing whitespace with <Leader>cw
nnoremap <Leader>cw :%s/\s\+$//g<CR>:nohlsearch<CR>

" http://usevim.com/2012/08/03/vim101-indentation/
" 4 spaces for tabs, inserted automatically.
" Tabs work fine in an ideal world. Sadly, spaces are always more consistent.
" To refactor code: find ./ -type f -exec sed -i 's/\t/    /g' {} \;
" Tip: use = in visual-line mode to re-indent

" Pressing tab means spaces instead
set expandtab

" how many spaces when expanding a tab
set softtabstop=4

" autoindent/shift >> << width
set shiftwidth=4

" Tabs (actual tabs) to be 4-wide. Sorry, Linus.
set tabstop=4

" YAML should have a 2-space indent, as dictionary fields have to line up
" after a list delimitation.
autocmd FileType yaml setlocal softtabstop=2 shiftwidth=2 tabstop=2

" {{{ go

" go fmt uses tabs
autocmd FileType go setlocal noexpandtab

let g:go_auto_sameids = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_fmt_experimental = 1
let g:go_metalinter_autosave=1
let g:go_metalinter_autosave_enabled=['golint', 'govet']

" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "goimports"

" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0

let g:go_addtags_transform = "snakecase"
let g:go_snippet_engine = "neosnippet"
let g:go_echo_go_info = 0
let g:go_doc_keywordprg_enabled = 0

augroup filetype_go
  au FileType go nmap <Leader>gb <Plug>(go-build)
  au FileType go nmap <Leader>gt <Plug>(go-test)
  au FileType go nmap <Leader>ga <Plug>(go-alternate-vertical)
  au FileType go nmap <Leader>gat :GoAddTags<CR>
  au FileType go nmap <Leader>gcov <Plug>(go-coverage-toggle)
  au FileType go nmap R <Plug>(go-rename)
  au FileType go nmap <F12> :GoDecls<CR>
augroup end

" }}}

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-go', 'coc-prettier']

command Retab normal! gg=G

" magically fold everything
map <F2> :set foldmethod=indent<CR><CR>

" airline is lighter than powerline. Lightline is lighter than airline (100ms
" from 200ms measured with (n)vim --startuptime)
" IMO powerline colours go well with any other colorscheme
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'component': {
      \   'lineinfo': ' %3l:%-2v',
      \ },
      \ 'component_function': {
      \   'filename': 'GetFilepath',
      \   'readonly': 'LightlineReadonly'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
\ }

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! GetFilepath()
    return substitute(expand('%:p'), '^'.expand('~'), '~', '')
endfunction

" ... but not binary files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.bin,*.png,*.jpg

" to bottom if log
au BufNewFile,BufRead *.log normal G

" abort a merge commit
ca fail cq

" stop accidentally saving ';' or ':' files due to typo
" http://stackoverflow.com/questions/6210946/prevent-saving-files-with-certain-names-in-vim
autocmd BufWritePre [:;]* throw 'Forbidden file name: ' . expand('<afile>')

" http://blog.sanctum.geek.nz/vim-annoyances/
" v-block mode: allow capturing blank space
set virtualedit=block

" vsplit/split: swap order so the text does not move
set splitbelow
set splitright

" give the terminal many characters-per-second it it can cope
set ttyfast
" only draw on user input
set lazyredraw

" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
" keep at least 5 lines above/below
set scrolloff=5
" keep at least 5 lines left/right
set sidescrolloff=5

" line marker
set colorcolumn=100

highlight ColorColumn ctermbg=black guibg=black

" stop asterisk-initiated search from annoyingly jumping to next match -- this
" is useful in combination with hlsearch
nnoremap * *``

" I always missed the warnings and ended up editing files for which I had no
" write permission, resulting in much frustration. A better solution is to
" disallow editing to force me to exit early without modifying and the use
" sudo without forgetting...
autocmd BufRead * let &l:modifiable = !&readonly

" swap ctrl+t and return, a better default IMO. Also map similar to CtrlP
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-t': 'edit',
      \ 'enter': 'tabedit',
      \ }

nnoremap <c-p> :FZF<cr>

" disable background color erase (problem with kitty + vim)
" In theory this is fixed with the correct terminfo files but in practice it
" keeps causing lots of missing background color
set t_ut=

" disable annoying markdown list behaviour
let g:vim_markdown_new_list_item_indent = 0

" workaround for neovim <Paste> bug
" https://github.com/neovim/neovim/issues/7994#issuecomment-388296360
au InsertLeave * set nopaste

" vim-rooter is used to change directory to the project root for every file,
" if opened in a project; this makes fzf based searching much more useful.
" However, there are many false positives now with the default
" project-root-finding behaviour. Revert to just looking for the git root, if
" any.
let g:rooter_patterns = ['.git']

" enable typescript inside svelte files
let g:vim_svelte_plugin_load_full_syntax = 1
let g:vim_svelte_plugin_use_typescript = 1

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*svelte'

autocmd FileType json syntax match Comment +\/\/.\+$+

command! -nargs=0 Prettier :CocCommand prettier.formatFile

autocmd BufReadPost,BufWrite *.js :Prettier
autocmd BufReadPost,BufWrite *.ts :Prettier

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:

inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gv  :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
