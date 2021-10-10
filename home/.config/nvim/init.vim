

if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

"" appearance
Plug 'rakr/vim-one'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/vim-emoji'

"" git
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'

"" editing
Plug 'liuchengxu/vim-better-default'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'
Plug 'luochen1990/rainbow'
Plug 'metakirby5/codi.vim'
" Plug 'sbdchd/neoformat'

"" vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

"" syntax lsc
Plug 'sheerun/vim-polyglot'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" complete, snippet
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()


"""""""""
"" Config


"""""""""
"" editor
let mapleader=" "
let maplocalleader=","
set mouse=a

nmap <Leader>q :nohlsearch<CR> " 검색 하이라이팅 키고 끄기
nmap <Leader>o :set paste!<CR> " 코드블럭 붙여넣기 모드를 키고 끄기
" nmap <C-n> :bnext<CR> " 다음 순서 버퍼 이동
" nmap <C-p> :bprev<CR> " 이전 순서 버퍼 이동
" nmap <C-e> :e#<CR> " 방금전 버퍼로 이동


"""""""""""""
"" appearance
" set t_Co=256 " http:://unix.stackexchange.com/questions/154012/terminal-colors-for-vim-airline-and-tmux-tmuxline 터미널 컬러 설정
set termguicolors " nvim ture color 지원
colorscheme one

" one theme
set background=dark


""""""""""""""""""""
"" vim-better-default
let g:vim_better_default_persistent_undo = 1
runtime! plugin/default.vim
set shiftwidth=2
set tabstop=2
set softtabstop=2
set wildmode=full


""""""""""""""""""""
"" vim-vue
let g:vue_disable_pre_processors=1
autocmd FileType vue syntax sync fromstart


""""""""""
"" python
let g:python_host_prog = '/Users/dididi/.asdf/shims/python2'
let g:python3_host_prog = '/Users/dididi/.asdf/shims/python'

"""""""""""""""
"" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1


""""""""""""""""
"" vim-gitgutter
" https://github.com/airblade/vim-gitgutter/issues/164
" highlight clear SignColumn
" highlight GitGutterAdd ctermfg=green guifg=darkgreen
" highlight GitGutterChange ctermfg=yellow guifg=darkyellow
" highlight GitGutterDelete ctermfg=red guifg=darkred
" highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow


""""""""""""
"" NERDTree
" map <C-n> :NERDTreeToggle<CR>
map <Leader>e :NERDTreeToggle<CR>
" map <C-w><C-e> :NERDTreeToggle<CR>
" Auto start NERD tree when opening a directory
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Auto start NERD tree if no files are specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"""""""""""""""""""
"" EditorConfig-vim
let g:EditorConfig_core_mode = 'external_command'


"""""""""""""""
"" fugitive.vim
autocmd QuickFixCmdPost *grep* cwindow


"""""""""
"" tagbar
nmap <F8> :TagbarToggle<CR>


"""""""""""""
"" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)<Paste>


"""""""""'
"" rainbow
let g:rainbow_active = 1



"""""""""""
"" coc


""""""
"" fzf
nnoremap <silent> <Leader>t :Tags<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>w :Windows<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>. :AgIn<space>
nnoremap <silent> <leader>g :Rg<space>


"""""""""
"" vim-emoji
set completefunc=emoji#complete


"""""""""
"" ultisnips

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


"""""""""
"" LanguageClient-neovim

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>


""""""""""'
"" ale

" Enable completion where available.
let g:ale_completion_enabled = 1
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

"""""""""""""
"" vim-polyglot
