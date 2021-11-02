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
local use = packer.use

packer.startup(function()
  use 'wbthomason/packer.nvim'

-- etc
  use 'lewis6991/impatient.nvim'

-- LSP
  use { 'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer' }
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'glepnir/lspsaga.nvim'
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use{ "jose-elias-alvarez/null-ls.nvim",
    config = function()
        require("null-ls").config{
          sources = {
            require("null-ls").builtins.formatting.fish_indent,
            require("null-ls").builtins.formatting.dart_format,
            require("null-ls").builtins.formatting.lua_format
          }
        }
        require("lspconfig")["null-ls"].setup{}
    end,
    requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  }
  use 'folke/lsp-colors.nvim'

  -- completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'

  -- syntax
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'blackcauldron7/surround.nvim'

  -- terminal
  use {"akinsho/toggleterm.nvim"}

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
  local lsp_installer = require("nvim-lsp-installer")

  lsp_installer.on_server_ready(function(server)
      local opts = {}
      opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- (optional) Customize the options passed to the server
      -- if server.name == "tsserver" then
      --     opts.root_dir = function() ... end
      -- end

      -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
      server:setup(opts)
      vim.cmd [[ do User LspAttachBuffers ]]
  end)

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

  -- terminal
  require("toggleterm").setup{}

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

    ["<leader>w"] = { name = "+Workspace"},
    ["<localleader>wa"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Format" },
    ["<localleader>wr"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Format" },
    ["<localleader>wl"] = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "Format" },
    
    ["<leader>x"] = { name = "+Language"},
    ["<localleader>x"] = { name = "+Language"},
    ["<leader>X"] = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Problems" },
    ["<leader>xx"] = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Problems" },
    ["<localleader>X"] = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Problems" },
    ["<localleader>xx"] = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Problems" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
    ["<leader>xt"] = { "<cmd>TroubleToggle<cr>", "Trouble" },
    ["<localleader>xf"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
    ["<localleader>xF"] = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Range Format" },

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
    ["<localleader>s"] = { name = "+Search"},
    ["<leader>S"] = { "<cmd>Telescope live_grep<cr>", "Grep" },
    ["<leader>ss"] = { "<cmd>Telescope live_grep<cr>", "Grep" },
    ["<localleader>S"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Grep" },
    ["<localleader>ss"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Grep" },
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

