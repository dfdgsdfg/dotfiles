local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local opt, wo = vim.opt, vim.wo
local fmt = string.format 

---- defaults ----
opt.shell='fish'
opt.mouse = 'a'
opt.termguicolors = true

-- ui 
opt.cursorline = true
opt.number = true 
opt.wrap = false 

-- tab, indent 
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true 
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

-- leader 
api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
g.mapleader = ' '
g.maplocalleader =  ','

-- provider 
g.loaded_python_provider = 0
g.python3_host_prog = '~/.asdf/shims/python'
g.loaded_perl_provider = 0


---- packer ----

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

---- plugins ----

local packer = require'packer'
packer.startup(function()
  use 'wbthomason/packer.nvim'

-- etc
  use 'lewis6991/impatient.nvim'

-- LSP
  use 'neovim/nvim-lspconfig' 
  use 'nvim-lua/lsp-status.nvim' 
  use 'nvim-lua/lsp_extensions.nvim' 
  use 'glepnir/lspsaga.nvim' 
  use 'folke/lsp-colors.nvim' 

  -- completion
  use 'hrsh7th/cmp-nvim-lsp' 
  use 'hrsh7th/cmp-buffer' 
  use 'hrsh7th/nvim-cmp' 

  -- syntax
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects' 
  use 'blackcauldron7/surround.nvim' 

  -- snippet
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- fuzzy find
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  } 
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } 

  -- color 
  use 'norcalli/nvim-colorizer.lua' 

  -- colorscheme
  use 'navarasu/onedark.nvim' 

  -- icon

  -- neovim lua dev 

  -- tabbar
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

  -- statusline
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- coursorline
  use 'yamatsum/nvim-cursorline' 

  -- editing support 
  use 'p00f/nvim-ts-rainbow' 
  use 'JoosepAlviste/nvim-ts-context-commentstring' 

  -- formatting 
  use 'mhartington/formatter.nvim' 

  -- ident
  use 'lukas-reineke/indent-blankline.nvim' 

  -- file explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- git
  use {
    'lewis6991/gitsigns.nvim', 
    requires = { 'nvim-lua/plenary.nvim' }, 
  }
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  -- language support
  use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
  use 'gennaro-tedesco/nvim-jqx' 

  -- comment
  use 'numToStr/Comment.nvim' 

  -- keybinding
  use 'folke/which-key.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)


---- plugin configs ----

--etc 
require('impatient')

--lsp
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
        require('luasnip').lsp_expand(args.body)
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
      { name = 'luasnip' },
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
      },
      rainbow = {
        enable = true,
        extended_mode = true,
      }
    }
  require"surround".setup {mappings_style = "sandwich"}
  
  -- snippet

  -- fuzzy finder
  require("telescope").load_extension("flutter")

  -- color 
  require'colorizer'.setup{}

  -- colorscheme
  require('onedark').setup{}

  -- icon 

  -- utility

  -- lua development

  -- tabline
  require('bufferline').setup{
    options = {
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left"
        }
      }
    }
  }

  -- statusline
  require('lualine').setup{ 
    options = { theme = 'onedark' },
    extensions = {'nvim-tree'}
  }

  -- cursorline

  -- indent

  -- file explorer
  require'nvim-tree'.setup{}

  -- git
  require('gitsigns').setup{}
  
  local neogit = require('neogit')
  neogit.setup{}

  -- language support 
  require("flutter-tools").setup{}

  -- comment 
  require('Comment').setup{}

  -- editing support 

  -- formatting 
  require('formatter').setup{}

  -- keybinding 
  local wk = require("which-key")
  wk.setup{}
  wk.register({
    -- ["<leader>c"] = { name = "+Color" },

    ["<leader>c"] = { name = "+Command"},
    ["<leader>C"] = { "<cmd>Telescope commands<cr>", "Commands" },
    ["<leader>cc"] = { "<cmd>Telescope commands<cr>", "Commands" },
    ["<leader>ct"] = { "<cmd>Telescope command_history<cr>", "Command History"},
    ["<leader>ck"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    ["<leader>ch"] = { "<cmd>Telescope man_pages<cr>", "Help"},

    ["<leader>v"] = { name = "+Edit"},
    ["<leader>vf"] = { "<cmd>Format<cr>", "Format" },

    ["<leader>b"] = { name = "+Buffer"},
    ["<leader>B"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
    ["<leader>bb"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
    
    ["<leader>r"] = { name = "+Register"},
    ["<leader>R"] = { "<cmd>Telescope registers<cr>", "Registers" },
    ["<leader>rr"] = { "<cmd>Telescope registers<cr>", "Registers" },
    
    ["<leader>e"] = { name = "+Explorer"},
    ["<leader>E"] = { "<cmd>NvimTreeToggle<cr>", "Explorer"},
    ["<leader>ee"] = { "<cmd>NvimTreeToggle<cr>", "Explorer"},
    ["<leader>eE"] = { "<cmd>Telescope file_browser<cr>", "Explorer(search)" },
    ["<leader>ef"] = { "<cmd>FlutterOutlineToggle<cr>", "Flutter"},

    ["<leader>s"] = { name = "+Search"},
    ["<leader>S"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Grep current buffer" },
    ["<leader>ss"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Grep current buffer" },
    ["<leader>sg"] = { "<cmd>Telescope live_grep<cr>", "Grep" },
    ["<leader>sn"] = { "<cmd>Telescope help_tags<cr>", "Tags" },
    ["<leader>sh"] = { "<cmd>Telescope search_history<cr>", "Search History"},
    ["<leader>st"] = { "<cmd>Telescope<cr>", "Telescope"},
    
    ["<leader>f"] = { name = "+File" },
    ["<leader>F"] = { "<cmd>Telescope find_files<cr>", "Find File" },
    ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
    ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
    
    ["<leader>g"] = { name = "+Git" },
    ["<leader>G"] = { "<cmd>Neogit<cr>", "Status" },
    ["<leader>gg"] = { "<cmd>Neogit<cr>", "Status" },
    ["<leader>gc"] = { "<cmd>Neogit commit<cr>", "Commit" },
  })

