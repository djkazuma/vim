set list
set listchars=tab:>>,trail:.,extends:>,precedes:<,nbsp:%
set nu
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set swapfile
set directory=/home/kazuma/tmp/
set splitright
set exrc
set secure
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,cp932

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype php,ctp setlocal ts=2 sts=2 sw=2
autocmd BufNewFile,BufRead *.mobile.erb set filetype=html

function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
  augroup ZenkakuSpace autocmd!  
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
  
"Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-rails'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'cohama/vim-smartinput-endwise'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'hail2u/vim-css3-syntax'
"NeoBundle 'taichouchou2/html5.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'basyura/unite-rails'
NeoBundle 'szw/vim-tags'
NeoBundle 'yuratomo/w3m.vim'
NeoBundle 'dhruvasagar/vim-table-mode'
"NeoBundle 'ngmy/vim-rubocop'
NeoBundle 'w0rp/ale'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

call smartinput_endwise#define_default_rules()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
" let g:nerdtree_tabs_open_on_console_startup=1
let g:vim_tags_auto_generate = 0

syntax enable
set synmaxcol=300

set clipboard=unnamedplus,autoselect
set shiftwidth=2

filetype on

filetype indent on

filetype plugin on


compiler ruby

let ruby_space_errors=1

inoremap <silent> jj <ESC>
nnoremap <C-i><C-i> :W3mTab google2 
nnoremap <C-i><C-h> :W3mHistory<CR>
nnoremap <C-i>p :call w3m#Back()<CR>
nnoremap <C-i>n :call w3m#Forward()<CR>
nnoremap <C-i>r :call w3m#Reload()<CR>
nnoremap <C-i>u :call w3m#CheckUnderCursor()<CR>
nnoremap <C-w>, <C-w><
nnoremap <C-w>. <C-w>>
nnoremap <C-w>; <C-w>+

map <C-n> :NERDTreeToggle<CR>

" ファイルを開く時、ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

" ファイルを開く時、ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

function! UniteRailsSetting()
  nnoremap <buffer><C-H><C-V>       :<C-U>Unite rails/view<CR>
  nnoremap <buffer><C-H><C-M>       :<C-U>Unite rails/model<CR>
  nnoremap <buffer><C-H><C-H>      :<C-U>Unite rails/controller<CR>
 
  "nnoremap <buffer><C-H>c           :<C-U>Unite rails/config<CR>
  "nnoremap <buffer><C-H>s           :<C-U>Unite rails/spec<CR>
  "nnoremap <buffer><C-H>m           :<C-U>Unite rails/db -input=migrate<CR>
  "nnoremap <buffer><C-H>l           :<C-U>Unite rails/lib<CR>
  "nnoremap <buffer><expr><C-H>g     ':e '.b:rails_root.'/Gemfile<CR>'
  "nnoremap <buffer><expr><C-H>r     ':e '.b:rails_root.'/config/routes.rb<CR>'
  "nnoremap <buffer><expr><C-H>se    ':e '.b:rails_root.'/db/seeds.rb<CR>'
  "nnoremap <buffer><C-H>ra          :<C-U>Unite rails/rake<CR>
  "nnoremap <buffer><C-H>h           :<C-U>Unite rails/heroku<CR>
endfunction
aug MyAutoCmd
  au User Rails call UniteRailsSetting()
aug END

let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_set_quickfix = 1
let g:ale_set_highlights = 0
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}
nmap <C-u><C-u> <Plug>(ale_fix)
