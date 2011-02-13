" This configuration is based on the example vimrc included with Arch Linux,
" the Vim Tips Wiki, and the vimrc file Ben Breedlove sent me to look at.
" (Thanks, Ben!)

" Enable Vim improvements at the expense of losing full vi compatibility.
set nocompatible

" Set display options.
set showcmd
set laststatus=2
set ruler
set number
set numberwidth=5
set colorcolumn=+2
set linebreak

" Give us a big command history.
set history=999

" Make backspace act normally.
set backspace=indent,eol,start

" Make indentation and wrapping behave in a civilized manner.
set autoindent
set expandtab
set smarttab

set tabstop=2
set shiftwidth=2

set textwidth=78

" Make indentation smarter.
if has("smartindent")
  set smartindent
endif

" Load plugins 'n' stuff with Pathogen.
if !has("python")
  let g:pathogen_disabled=["blogit"]
end

set runtimepath+=~/.vim/bundle/pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Enable settings specific to various file formats.
filetype on
filetype plugin on
filetype indent on

let g:tex_flavor="latex"

" Configure the LaTeX Box plugin.
let g:LatexBox_latexmk_options="-pvc"

" Tweak the indentation and wrapping settings a bit for certain file formats.
if has("autocmd")
  autocmd FileType css        setlocal tabstop=4 shiftwidth=4 textwidth=100
  autocmd FileType haskell    setlocal tabstop=4 shiftwidth=4
  autocmd FileType html       setlocal tabstop=4 shiftwidth=4 textwidth=0
  autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 textwidth=100
  autocmd FileType markdown   setlocal tabstop=4 shiftwidth=4 textwidth=0
  autocmd FileType php        setlocal tabstop=4 shiftwidth=4 textwidth=100
  autocmd FileType python     setlocal tabstop=4 shiftwidth=4
  autocmd FileType sql        setlocal tabstop=4 shiftwidth=4 textwidth=100
  autocmd FileType tex        setlocal                        textwidth=0
endif

" Enable fancy search settings.
if has("extra_search")
  set incsearch
  set hlsearch
endif

" Enable mouse support.
if has("mouse")
  set mouse=a
endif

" All the xterm-like terminals I use support 256 colors, so let's make Vim
" aware of that.
if &term == "xterm"
  set t_Co=256
endif

" Enable syntax highlighting.
if has("syntax") && (&t_Co > 2 || has("gui_running"))
  syntax on
endif

" Set a custom dictionary for spell checking, but don't enable bad word
" highlighting by default. (It's just too ugly in a terminal.)
if has("spell")
  set spellfile=~/.vim/spellfile.add
endif

if has("gui_running")
  " Make the default gVim Window larger.
  set lines=50
  set columns=132

  " Kill off the gVim toolbar and scrollbar, and fix the tear-off menus.
  " See also: <http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text>
  set guioptions-=t
  set guioptions-=T
  set guioptions-=r

  " Set a pretty font. :) To make things a bit more cross-platform, we
  " actually specific several fonts: a primary and a few fallbacks.
  " See also: <http://vim.wikia.com/wiki/Setting_the_font_in_the_GUI>.
  if has("gui_gtk2")
    set guifont=Envy\ Code\ R\ 10
    set guifont+=Consolas\ 10
    set guifont+=DejaVu\ Sans\ Mono\ 10
    set guifont+=Courier\ New\ 10
  else
    set guifont=Envy_Code_R:h10:cDEFAULT
    set guifont+=Consolas:h10:cDEFAULT
    set guifont+=DejaVu_Sans_Mono:h10:cDEFAULT
    set guifont+=Courier_New:h10:cDEFAULT
  endif

  " Enable highlighting of misspelled words in gVim only.
  if has("spell")
    set spell
  endif

  " Set a nice color scheme.
  colorscheme desert
elseif &t_Co == 88 || &t_Co == 256
  " Set a nice color scheme.
  colorscheme desert256-transparent
endif

" Highlight trailing whitespace.
" See also: <http://vim.wikia.com/wiki/Highlight_unwanted_spaces>.
if has("autocmd") && has("syntax") && (&t_Co > 2 || has("gui_running"))
  highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
endif
