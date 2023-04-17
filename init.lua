return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "rose-pine-main",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Command to hot disable cmp.
    vim.api.nvim_create_user_command("CmpOff", "lua require('cmp').setup.buffer {enabled = false}", {})
    vim.api.nvim_create_user_command("CmpOn", "lua require('cmp').setup.buffer {enabled = true}", {})
    vim.cmd "set pumheight=10"
    vim.cmd "set cmdheight=1"
    -- Telescope plugins

    require("telescope").load_extension "luasnip"
    -- require("telescope").load_extension "command_center"

    local lspkind = require "lspkind"

    local source_mapping = {
      buffer = "[Buffer]",
      nvim_lsp = "[LSP]",
      nvim_lua = "[Lua]",
      cmp_tabnine = "[TN]",
      async_path = "[Path]",
      luasnip = "[LuaS]",
      ultisnip = "[UltiS]",
    }

    require("cmp").setup {
      -- sources = {
      --   { name = "cmp_tabnine" },
      -- },
      formatting = {
        format = function(entry, vim_item)
          -- if you have lspkind installed, you can use it like
          -- in the following line:
          vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
          vim_item.menu = source_mapping[entry.source.name]
          if entry.source.name == "cmp_tabnine" then
            local detail = (entry.completion_item.labelDetails or {}).detail
            vim_item.kind = ""
            if detail and detail:find ".*%%.*" then vim_item.kind = vim_item.kind .. " " .. detail end

            if (entry.completion_item.data or {}).multiline then vim_item.kind = vim_item.kind .. " " .. "[ML]" end
          end
          local maxwidth = 80
          vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
          return vim_item
        end,
      },
    }

    local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })

    vim.api.nvim_create_autocmd("BufRead", {
      group = prefetch,
      pattern = "*",
      callback = function() require("cmp_tabnine"):prefetch(vim.fn.expand "%:p") end,
    })

    -- local compare = require "cmp.config.compare"
    -- require("cmp").setup {
    --   sorting = {
    --     priority_weight = 2,
    --     comparators = {
    --       require "cmp_tabnine.compare",
    --       compare.offset,
    --       compare.exact,
    --       compare.score,
    --       compare.recently_used,
    --       compare.kind,
    --       compare.sort_text,
    --       compare.length,
    --       compare.order,
    --     },
    --   },
    -- }

    -- Configure airline
    vim.cmd "let g:airline_theme='minimalist'"
    -- vim.cmd [[let g:airline_mode_map = {
    --   \ '__'     : '-',
    --   \ 'c'      : 'COMMAND',
    --   \ 'i'      : 'INSERT',
    --   \ 'ic'     : 'INSERT',
    --   \ 'ix'     : 'I',
    --   \ 'n'      : 'NORMAL',
    --   \ 'multi'  : 'M',
    --   \ 'ni'     : 'N',
    --   \ 'no'     : 'N',
    --   \ 'R'      : 'R',
    --   \ 'Rv'     : 'R',
    --   \ 's'      : 'SELECT',
    --   \ 'S'      : 'S',
    --   \ ''     : 'S',
    --   \ 't'      : 'TERM',
    --   \ 'v'      : 'V',
    --   \ 'V'      : 'VISUAL',
    --   \ ''     : 'V',
    --   \ }]]
    vim.cmd [[let g:airline_left_sep = '»']]
    vim.cmd [[let g:airline_left_sep = '▶']]
    vim.cmd [[let g:airline_right_sep = '«']]
    vim.cmd [[let g:airline_right_sep = '◀']]
    vim.cmd [[let g:airline_symbols.crypt = '🔒']]
    vim.cmd [[let g:airline_symbols.linenr = '☰']]
    vim.cmd [[let g:airline_symbols.linenr = '␊']]
    vim.cmd [[let g:airline_symbols.linenr = '␤']]
    vim.cmd [[let g:airline_symbols.linenr = '¶']]
    vim.cmd [[let g:airline_symbols.maxlinenr = '']]
    vim.cmd [[let g:airline_symbols.maxlinenr = '㏑']]
    vim.cmd [[let g:airline_symbols.branch = '⎇']]
    vim.cmd [[let g:airline_symbols.paste = 'ρ']]
    vim.cmd [[let g:airline_symbols.paste = 'Þ']]
    vim.cmd [[let g:airline_symbols.paste = '∥']]
    vim.cmd [[let g:airline_symbols.spell = 'Ꞩ']]
    vim.cmd [[let g:airline_symbols.notexists = 'Ɇ']]
    vim.cmd [[let g:airline_symbols.whitespace = 'Ξ']]
    vim.cmd [[let g:airline_left_sep = '']]
    vim.cmd [[let g:airline_left_alt_sep = '']]
    vim.cmd [[let g:airline_right_sep = '']]
    vim.cmd [[let g:airline_right_alt_sep = '']]
    vim.cmd [[let g:airline_symbols.branch = '']]
    vim.cmd [[let g:airline_symbols.readonly = '']]
    vim.cmd [[let g:airline_symbols.linenr = '☰']]
    vim.cmd [[let g:airline_symbols.maxlinenr = '']]
    vim.cmd "AirlineRefresh"
    -- Fix a small bug in the clangd-format formatter

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.offsetEncoding = { "utf-16" }
    require("lspconfig").clangd.setup { capabilities = capabilities }
  end,
}
