-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    -- ["<leader>fs"] = { "<cmd>Telescope luasnip<cr>", desc = "Insert a snippet" },
    ["<leader>fS"] = { "<cmd>Telescope symbols<cr>", desc = "Insert a symbol" },
    ["<leader>fn"] = { "<cmd>Telekasten find_notes<cr>", desc = "Find Notes" },
    ["<leader>fN"] = { "<cmd>Telescope notify<cr>", desc = "Find notification" },
    ["<C-l>"] = {
      function()
        if vim.g.term_is_open then
        else
          vim.cmd "Telescope symbols"
        end
      end,
      desc = "Insert a symbol",
    },

    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<leader>pe"] = { '<cmd>lua require("nabla").toggle_virt()<cr>', desc = "Show équations as ASCI diagrams" },
    -- Mappings for Telekasten
    ["<leader>z"] = { name = "Telekasten" },
    ["<leader>zf"] = { "<cmd>Telekasten find_notes<CR>", desc = "find_notes" },
    ["<leader>zg"] = { "<cmd>Telekasten search_notes<CR>", desc = "search_notes" },
    ["<leader>zd"] = { "<cmd>Telekasten goto_today<CR>", desc = "goto_today" },
    ["<leader>zz"] = { "<cmd>Telekasten follow_link<CR>", desc = "follow_link" },
    ["<leader>zn"] = { "<cmd>Telekasten new_note<CR>", desc = "new_note" },
    ["<leader>zc"] = { "<cmd>Telekasten show_calendar<CR>", desc = "show_calendar" },
    ["<leader>zb"] = { "<cmd>Telekasten show_backlinks<CR>", desc = "show_backlinks" },
    ["<leader>zI"] = { "<cmd>Telekasten insert_img_link<CR>", desc = "insert_img_link" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  i = {
    ["<C-l>"] = {
      function()
        if vim.g.term_is_open then
        else
          vim.cmd "Telescope symbols"
        end
      end,
      desc = "Insert a symbol",
    },
  },
}
