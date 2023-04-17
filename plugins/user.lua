return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    dependencies = {
      "FelipeLema/cmp-async-path",
      "quangnguyen30192/cmp-nvim-ultisnips",
    },
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require "cmp"
      -- modify the sources part of the options table
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp",    priority = 1000 },
        { name = "luasnip",     priority = 750 },
        { name = "ultisnips",   priority = 750 },
        { name = "cmp_tabnine", priority = 600, max_item_count = 7 },
        -- { name = "latex_symbols", priority = 550 },
        { name = "buffer",      priority = 500 },
        { name = "async_path",  priority = 250 },
      }

      -- return the new table to be used
      return opts
    end,
  },
  {
    "vim-airline/vim-airline",
    lazy = false,
    dependencies = "vim-airline/vim-airline-themes",
  },
  {
    "rebelot/heirline",
    enabled = false,
  },
  {
    "tzachar/cmp-tabnine",
    dependencies = "hrsh7th/nvim-cmp",
    build = "./install.sh",
    lazy = false,
  },
  {
    "alaviss/nim.nvim",
  },
  {
    "zah/nim.vim",
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "benfowler/telescope-luasnip.nvim",
  },
  {
    "nvim-telescope/telescope-symbols.nvim",
    lazy = false,
  },
  {
    "hrsh7th/cmp-path",
    enabled = false,
  },
  {
    "honza/vim-snippets",
  },
  {
    "alvan/vim-closetag",
  },
}
