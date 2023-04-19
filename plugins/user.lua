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

  -- CMP and auto completion plugins
  {
    -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    dependencies = {
      "FelipeLema/cmp-async-path",
      -- "quangnguyen30192/cmp-nvim-ultisnips",
    },
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require "cmp"
      -- modify the sources part of the options table
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp",   priority = 1000, max_item_count = 3 },
        { name = "luasnip",    priority = 750,  max_item_count = 2 },
        --{ name = "ultisnips",   priority = 750 },
        -- { name = "cmp_tabnine", priority = 600,  max_item_count = 3 },
        -- { name = "latex_symbols", priority = 550 },
        { name = "buffer",     priority = 500,  max_item_count = 3 },
        { name = "async_path", priority = 250,  max_item_count = 3 },
      }

      -- return the new table to be used
      return opts
    end,
    enabled = true,
    lazy = true,
  },
  {
    "ms-jpq/coq_nvim",
    config = function()
      vim.g.coq_settings = {
        clients = {
          tabnine = {
            enabled = true,
          },
          tmux = {
            enabled = false,
          },
        },
      }
      vim.g.coq_settings.clients.tmux.enabled = false
    end,
    dependencies = {
      "ms-jpq/coq.artifacts",
      "ms-jpq/coq.thirdparty",
    },
    lazy = false,
  },
  {
    "tzachar/cmp-tabnine",
    dependencies = "hrsh7th/nvim-cmp",
    build = "./install.sh",
    lazy = false,
    enabled = false,
  },

  -- UI plugins
  {
    "vim-airline/vim-airline",
    lazy = false,
    dependencies = "vim-airline/vim-airline-themes",
  },
  {
    -- Markdown preview in term
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    ft = {
      "markdown",
      "telekasten",
      "html",
    },
    config = function()
      vim.api.nvim_create_user_command("Peek", function()
        local peek = require "peek"
        if peek.is_open() then
          peek.close()
        else
          peek.open()
        end
      end, {})
      require("peek").setup {
        theme = "light",
        filetype = { "markdown", "telekasten", "html" },
        -- app = "opera",
      }
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    -- LaTEX equation.
    "jbyuki/nabla.nvim",
  },

  -- Language specific plugins
  {
    "alaviss/nim.nvim",
    ft = { "nim", "nims" },
  },
  -- {
  --   "zah/nim.vim",
  --   ft = { "nim", "nims" },
  -- },

  -- QOL plugins
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
    "jubnzv/mdeval.nvim",
    ft = { "markdown", "telekasten" },
    config = function()
      require("mdeval").setup {
        eval_options = {
          nim = {
            command = { "nim", "c", "-r" },
            language_code = "nim",
            exec_type = "interpreted",
            extention = "nim",
          },
        },
      }
    end,
  },
  {
    "honza/vim-snippets",
  },
  {
    "alvan/vim-closetag",
  },
  {
    "michaelb/sniprun",
    build = "./install.sh",
  },

  -- Telescope addons
  {
    "benfowler/telescope-luasnip.nvim",
  },
  {
    "nvim-telescope/telescope-symbols.nvim",
    event = "BufEnter",
  },
  {
    "renerocksai/telekasten.nvim",
    dependencies = {
      "nvim-telescope/telescope-media-files.nvim",
    },
    cmd = "Telekasten",
  },

  -- Disabled plugins
  {
    "rebelot/heirline",
    enabled = false,
  },
  {
    "hrsh7th/cmp-path",
    enabled = false,
  },
}
