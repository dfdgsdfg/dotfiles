local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local opt, wo = vim.opt, vim.wo
local fmt = string.format

---- defaults ----
opt.shell ='fish'
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

---- lazy ----
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
-- etc
  { 
    'echasnovski/mini.nvim', 
    config = function()
      require('mini.surround').setup()
    end,
  },
  { 
    'lewis6991/impatient.nvim',
    config = function()
      require('impatient')
    end,
  },

-- LSP
  'neovim/nvim-lspconfig',
  {
    'williamboman/nvim-lsp-installer',
    config = function()
      local lsp_installer = require("nvim-lsp-installer")

      lsp_installer.on_server_ready(function(server)
          local opts = {}
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          opts.capabilities = capabilities 

          -- (optional) customize the options passed to the server
          -- if server.name == "tsserver" then
          --     opts.root_dir = function() ... end
          -- end

          -- this setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
          server:setup(opts)
          vim.cmd [[ do user lspAttachBuffers ]]
      end)
    end,
  },
  'nvim-lua/lsp-status.nvim',
  'nvim-lua/lsp_extensions.nvim',
  {
    'glepnir/lspsaga.nvim',
    event = 'bufread',
    config = function()
        require('lspsaga').setup({})
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  { "jose-elias-alvarez/null-ls.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"},
    config = function()
        require("null-ls").setup({
          sources = {
            -- require("null-ls").builtins.formatting.fish_indent,
            require("null-ls").builtins.formatting.dart_format,
            -- require("null-ls").builtins.formatting.lua_format
          }
        })
    end,
  },
  'folke/lsp-colors.nvim',

  -- completion
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'l3mon4d3/luasnip' },
    config = function()
      require'cmp'.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
        }
      })
    end,
  },

  -- syntax
  { 
    'nvim-treesitter/nvim-treesitter',
    build = ':tsupdate'
  },
  'nvim-treesitter/nvim-treesitter-textobjects',

  -- terminal
  { 
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup{}
    end,
  },

  -- snippet
  'l3mon4d3/luasnip',
  'saadparwaiz1/cmp_luasnip',

  -- fuzzy find
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require("telescope").load_extension("flutter")
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },

  -- color
  { 
    'norcalli/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup{}
    end,
  },

  -- colorscheme
  { 
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').load()
    end,
  },

  -- icon

  -- neovim lua dev

  -- tabbar
  {
    'akinsho/bufferline.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('bufferline').setup{
        options = {
          offsets = {
            {
              filetype = "nvimtree",
              text = "file explorer",
              highlight = "directory",
              text_align = "left"
            }
          }
        }
      }
    end,
  },

  -- statusline
  {
    'hoob3rt/lualine.nvim',
    dependencies = {'kyazdani42/nvim-web-devicons', lazy = true},
    config = function()
      require('lualine').setup{
        options = { theme = 'onedark' },
        extensions = {'nvim-tree'}
      }
    end,
  },

  -- coursorline
  'yamatsum/nvim-cursorline',

  -- editing support
  'p00f/nvim-ts-rainbow',
  'joosepalviste/nvim-ts-context-commentstring',

  -- formatting

  -- ident
  'lukas-reineke/indent-blankline.nvim',

  -- file explorer
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function()
      require'nvim-tree'.setup{}
    end,
  },

  -- git
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup{}
    end,
  },
  { 
    'timuntersberger/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup{}
    end,
  },

  -- language support
  { 
    'akinsho/flutter-tools.nvim',
    config = function()
      require("flutter-tools").setup{}
    end,
    dependencies = 'nvim-lua/plenary.nvim'
  },
  'gennaro-tedesco/nvim-jqx',

  -- comment
  { 
    'numtostr/comment.nvim',
    config = function()
      require('comment').setup{}
    end,
  },

  -- keybinding
  { 
    'folke/which-key.nvim',
    config = function()
      local wk = require("which-key")
      wk.setup{}
      wk.register({
        -- ["<leader>c"] = { name = "+Color" },

        ["<leader>c"] = { name = "+Command"},
        ["<leader>c"] = { "<cmd>Telescope commands<cr>", "Commands" },
        ["<leader>cc"] = { "<cmd>Telescope commands<cr>", "Commands" },
        ["<leader>ct"] = { "<cmd>Telescope command_history<cr>", "Command History"},
        ["<leader>ck"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        ["<leader>ch"] = { "<cmd>Telescope man_pages<cr>", "Help"},

        ["<localleader>w"] = { name = "+Workspace"},
        ["<localleader>wa"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Format" },
        ["<localleader>wr"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Format" },
        ["<localleader>wl"] = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "Format" },

        ["<leader>x"] = { name = "+Language"},
        ["<localleader>x"] = { name = "+Language"},
        ["<leader>x"] = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Problems" },
        ["<leader>xx"] = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Problems" },
        ["<localleader>x"] = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Problems" },
        ["<localleader>xx"] = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Problems" },
        ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
        ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
        ["<leader>xt"] = { "<cmd>TroubleToggle<cr>", "Trouble" },
        ["<localleader>xf"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
        ["<localleader>xf"] = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Range Format" },

        ["<leader>b"] = { name = "+Buffer"},
        ["<leader>b"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
        ["<leader>bb"] = { "<cmd>Telescope buffers<cr>", "Buffers" },

        ["<leader>r"] = { name = "+Register"},
        ["<leader>r"] = { "<cmd>Telescope registers<cr>", "Registers" },
        ["<leader>rr"] = { "<cmd>Telescope registers<cr>", "Registers" },

        ["<leader>e"] = { name = "+Explorer"},
        ["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer"},
        ["<leader>ee"] = { "<cmd>NvimTreeToggle<cr>", "Explorer"},
        ["<leader>ee"] = { "<cmd>Telescope file_browser<cr>", "Explorer(search)" },
        ["<leader>ef"] = { "<cmd>FlutterOutlineToggle<cr>", "Flutter"},

        ["<leader>s"] = { name = "+Search"},
        ["<localleader>s"] = { name = "+Search"},
        ["<leader>s"] = { "<cmd>Telescope live_grep<cr>", "Grep" },
        ["<leader>ss"] = { "<cmd>Telescope live_grep<cr>", "Grep" },
        ["<localleader>s"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Grep" },
        ["<localleader>ss"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Grep" },
        ["<leader>sn"] = { "<cmd>Telescope help_tags<cr>", "Tags" },
        ["<leader>sh"] = { "<cmd>Telescope search_history<cr>", "Search History"},
        ["<leader>st"] = { "<cmd>Telescope<cr>", "Telescope"},

        ["<leader>f"] = { name = "+File" },
        ["<leader>f"] = { "<cmd>Telescope find_files<cr>", "Find File" },
        ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
        ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },

        ["<leader>g"] = { name = "+Git" },
        ["<leader>g"] = { "<cmd>Neogit<cr>", "Status" },
        ["<leader>gg"] = { "<cmd>Neogit<cr>", "Status" },
        ["<leader>gc"] = { "<cmd>Neogit commit<cr>", "Commit" },

        ["<leader>t"] = { name = "+Terminal" },
        ["<leader>t"] = { "<cmd>ToggleTerm<cr>", "Terminal" },
        ["<leader>tt"] = { "<cmd>ToggleTerm<cr>", "Terminal" },
        ["<leader>tb"] = { "<cmd>terminal<cr>", "Terminal Buffer" },
      })
    end,
  },
}, opts)

