-- if true then
--   return {}
-- end
--
return {
  {
    "folke/edgy.nvim",
    optional = true,
    keys = {
      {
        "<leader>uo",
        "<cmd>Outline<cr>",
        desc = "Toggle Outline",
      },
    },
    opts = function(_, opts)
      opts.animate = { enabled = false }
      -- opts.right = {
      --   {
      --     title = function()
      --       local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
      --       return vim.fn.fnamemodify(buf_name, ":t")
      --     end,
      --     ft = "Outline",
      --     pinned = false,
      --     open = "Outline",
      --   },
      -- }

      -- table.insert(opts.right, {
      --   ft = "copilot-chat",
      --   title = "Copilot Chat",
      --   size = { width = 50 },
      -- })

      opts.left = {
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          size = { height = 0.7 },
          pinned = true,
        },
        "neo-tree", -- any other neo-tree windows
      }

      opts.bottom = opts.bottom
        or {
          {
            ft = "toggleterm",
            title = "Terminal",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "noice",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "lazyterm",
            title = "LazyTerm",
            size = { height = 0.4 },
            filter = function(buf)
              return not vim.b[buf].lazyterm_cmd
            end,
          },
          "Trouble",
          { ft = "qf", title = "QuickFix" },
          {
            ft = "help",
            size = { height = 20 },
            filter = function(buf)
              return vim.bo[buf].buftype == "help"
            end,
          },
          { ft = "spectre_panel", size = { height = 0.4 } },
        }
    end,
    -- opts2 = {
    --   animate = {
    --     enabled = false,
    --   },
    --   right = {
    --
    --     {
    --       title = function()
    --         local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
    --         return vim.fn.fnamemodify(buf_name, ":t")
    --       end,
    --       ft = "Outline",
    --       pinned = false,
    --       open = "Outline",
    --     },
    --   },
    --   left = {
    --     -- Neo-tree filesystem always takes half the screen height
    --     {
    --       title = "Neo-Tree",
    --       ft = "neo-tree",
    --       filter = function(buf)
    --         return vim.b[buf].neo_tree_source == "filesystem"
    --       end,
    --       size = { height = 0.7 },
    --       pinned = true,
    --     },
    --
    --     -- {
    --     --   title = function()
    --     --     local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
    --     --     return vim.fn.fnamemodify(buf_name, ":t")
    --     --   end,
    --     --   ft = "Outline",
    --     --   pinned = false,
    --     --   open = "OutlineOpen",
    --     -- },
    --
    --     -- any other neo-tree windows
    --     "neo-tree",
    --   },
    --   bottom = {
    --     -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
    --     {
    --       ft = "toggleterm",
    --       title = "Terminal",
    --       size = { height = 0.4 },
    --       -- exclude floating windows
    --       filter = function(buf, win)
    --         return vim.api.nvim_win_get_config(win).relative == ""
    --       end,
    --     },
    --     {
    --       ft = "noice",
    --       size = { height = 0.4 },
    --       filter = function(buf, win)
    --         return vim.api.nvim_win_get_config(win).relative == ""
    --       end,
    --     },
    --     {
    --       ft = "lazyterm",
    --       title = "LazyTerm",
    --       size = { height = 0.4 },
    --       filter = function(buf)
    --         return not vim.b[buf].lazyterm_cmd
    --       end,
    --     },
    --     "Trouble",
    --     { ft = "qf", title = "QuickFix" },
    --     {
    --       ft = "help",
    --       size = { height = 20 },
    --       -- only show help buffers
    --       filter = function(buf)
    --         return vim.bo[buf].buftype == "help"
    --       end,
    --     },
    --     { ft = "spectre_panel", size = { height = 0.4 } },
    --   },
    -- },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      defaults = {
        get_selection_window = function()
          require("edgy").goto_main()
          return 0
        end,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = function(_, opts)
      opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
        or { "terminal", "Trouble", "qf", "Outline", "trouble" }
      table.insert(opts.open_files_do_not_replace_types, "edgy")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function()
      local Offset = require("bufferline.offset")
      if not Offset.edgy then
        local get = Offset.get
        Offset.get = function()
          if package.loaded.edgy then
            local old_offset = get()
            local layout = require("edgy.config").layout
            local ret = { left = "", left_size = 0, right = "", right_size = 0 }
            for _, pos in ipairs({ "left", "right" }) do
              local sb = layout[pos]
              local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
              if sb and #sb.wins > 0 then
                ret[pos] = old_offset[pos .. "_size"] > 0 and old_offset[pos]
                  or pos == "left" and ("%#Bold#" .. title .. "%*" .. "%#BufferLineOffsetSeparator#│%*")
                  or pos == "right" and ("%#BufferLineOffsetSeparator#│%*" .. "%#Bold#" .. title .. "%*")
                ret[pos .. "_size"] = old_offset[pos .. "_size"] > 0 and old_offset[pos .. "_size"] or sb.bounds.width
              end
            end
            ret.total_size = ret.left_size + ret.right_size
            if ret.total_size > 0 then
              return ret
            end
          end
          return get()
        end
        Offset.edgy = true
      end
    end,
  },
}
