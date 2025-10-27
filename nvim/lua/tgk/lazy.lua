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
            --all plugs are here (except for the butt one :( --
require("lazy").setup({
'nvim-lua/plenary.nvim',
	--telescope--
 {'nvim-telescope/telescope.nvim', tag = '0.1.5'},
 --tokyonight--
 {

  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd.colorscheme("tokyonight")
    end,
},

	{
		--tree sitter--

  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "vim", "vimdoc", "query",
        "javascript", "typescript", "tsx",
        "html", "css", "json","c","cpp","python","rust"},
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,


 },

	-- autotag -- 
	{'windwp/nvim-ts-autotag',
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = true -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  per_filetype = {
    ["html"] = {
      enable_close = false
    }
  }
})
		end},
--discord--

	{
  'vyfor/cord.nvim',
  build = ':Cord update',
  -- opts = {}
},

	--auto_pair--
	{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
	},
	--harpoon--
{
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
},
	--undotree--	
'mbbill/undotree',

         {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},


	 -- LSP Support
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = true,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
    }
  },
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  -- Autocompletion
{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",          -- snippet engine
    "saadparwaiz1/cmp_luasnip",  -- bridge between cmp and luasnip
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
      }),
    })
  end,
},

	--codeuim for auto completion--
	{
		'Exafunction/codeium.vim',
      		event = 'BufEnter',
		config = function ()
    vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
end


	},
	  {'prettier/vim-prettier',
    run = 'pnpm install --frozen-lockfile --production',
    ft = {'javascript', 'typescript', 'css', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'}},
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
},
--formater 
{"stevearc/conform.nvim"},

-- trouble --
{
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
},

}, {})

