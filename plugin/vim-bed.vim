" Auto reload vimrc. This is a good idea. Nothing bad will come from this.
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" The 90s was the best decade so I'm moving this editor to the 90s
set t_Co=256

set number  " What's a text editor without line numbers?
set tw=79   " width of document (used by gd)

set nowrap  " I don't want to wrap text
set fo-=t   " Especially when typing

" Tab is 4 spaces by default. Spaces are better than tabs.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

" Buffers are good and everyone should use them more
set hidden

" I suppose this is a sensible level of undos?
set undolevels=700

" I like having the line where the cursor is highlighted.
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Uh ohs here come the autocommands
" With thanks to @garybernhardt for which I unashamedly stole this off his
" vimrc
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  " Jump to last cursor position unless it's invalid or in an event handler
  " This is literally the only way to do this in vim. It even says so in the
  " help (seriously search part of this code and see for yourself!)
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

  " These languages and markups use 2 spaces
  autocmd FileType ruby,haml,eruby,yaml,sass,cucumber,vim,lua set ai sw=2 sts=2 et
  " but these ones use 4 (yes javascript is 4 spaces. I will not accept 2)
  autocmd FileType python,javascript,html set sw=4 sts=4 et

  " I don't think I've ever used .sass but there you go it's in here
  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  " Indent p tags
  autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " indent slim two spaces, not four
  autocmd! FileType *.slim set sw=2 sts=2 et
augroup END
