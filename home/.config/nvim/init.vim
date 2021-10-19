"""""""""""""""
"" defaults

set nocompatible
set encoding=UTF-8
set shell=fish
set mouse=a
set ttyfast
set termguicolors

set hlsearch
set incsearch
set showmatch 
set ignorecase 

set cursorline
set number
set showcmd
set nowrap 

set expandtab
set smarttab 
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2

set wildmenu
set wildmode=longest:list,full

syntax on
filetype plugin indent on

let mapleader=" "
let maplocalleader=","

nmap <Leader>q :nohlsearch<CR> " 검색 하이라이팅 키고 끄기
nmap <Leader>o :set paste!<CR> " 코드블럭 붙여넣기 모드를 키고 끄기

"" provider
let g:loaded_python_provider = 0
" let g:python_host_prog = '~/.asdf/shims/python2'
let g:python3_host_prog = '~/.asdf/shims/python'
" let g:ruby_host_prog = '~/.asdf/shims/ruby'
let g:loaded_perl_provider = 0


"""""""""""""""
"" plug 

call plug#begin('~/.local/share/nvim/plugged')

"" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'folke/lsp-colors.nvim'

"" completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

"" syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'blackcauldron7/surround.nvim'

"" snippet
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

"" fuzzy find
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

"" color 
Plug 'norcalli/nvim-colorizer.lua'

"" colorscheme
Plug 'navarasu/onedark.nvim'

"" icon
Plug 'kyazdani42/nvim-web-devicons'

"" neovim lua dev 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

"" tabbar
Plug 'romgrk/barbar.nvim'

"" statusline
Plug 'hoob3rt/lualine.nvim'

"" coursorline
Plug 'yamatsum/nvim-cursorline'

"" editing support 
Plug 'p00f/nvim-ts-rainbow'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

"" formatting 
Plug 'mhartington/formatter.nvim'

"" ident
Plug 'lukas-reineke/indent-blankline.nvim'

"" file explorer
Plug 'kyazdani42/nvim-tree.lua'

"" git
Plug 'lewis6991/gitsigns.nvim'
Plug 'TimUntersberger/neogit'

"" language support
Plug 'akinsho/flutter-tools.nvim'
Plug 'gennaro-tedesco/nvim-jqx'

"" comment
Plug 'numToStr/Comment.nvim'

"" formatting
Plug 'mhartington/formatter.nvim'

"" keybinding
Plug 'folke/which-key.nvim'

call plug#end()


"""""""""""""
"" lua config

lua << EOF
  -- lsp
  local lspconfig = require'lspconfig'
  lspconfig.tsserver.setup{
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
  lspconfig.dartls.setup{
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }

  local saga = require'lspsaga'
  saga.init_lsp_saga()

  -- completion
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
    }
  })
  
  -- syntax
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    --ignore_install = { "javascript" }, -- List of parsers to ignore installing
    highlight = {
      enable = true,              -- false will disable the whole extension
      -- disable = { "c", "rust" },  -- list of language that will be disabled
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
      },
      context_commentstring = {
        enable = true
      }
    }
  require"surround".setup {mappings_style = "sandwich"}
  
  -- snippet

  -- fuzzy finder

  -- color 
  require'colorizer'.setup()

  -- colorscheme
	require('onedark').setup()

  -- utility

  -- lua development

  -- tabline

  -- statusline
  require('lualine').setup{ options = { theme = 'onedark' } }

  -- cursorline

  -- indent

  -- file explorer
  require'nvim-tree'.setup{}

  -- git
  require('gitsigns').setup()
  
  local neogit = require('neogit')
  neogit.setup {}

  -- language support 
  require("flutter-tools").setup{}

  -- comment 
  require('Comment').setup()

  -- editing support 

  -- formatting  

  -- keybinding  
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }

EOF


"""""""""""""
"" vim config

"" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"" nvim-tree
nnoremap <Leader>e :NvimTreeToggle<CR>

"" formatter.nvim  
nnoremap <silent> <leader>f :Format<CR>
