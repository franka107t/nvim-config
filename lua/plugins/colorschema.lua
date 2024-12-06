return {
  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = function(_, opts)
  --     opts.transparent = true
  --     opts.italic_comments = true
  --     opts.borderless_telescope = false
  --   end,
  -- },
  {
    "uloco/bluloco.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      require("bluloco").setup({
        style = "dark", -- "auto" | "dark" | "light"
        transparent = false,
        italics = true,
        -- terminal = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
        -- guicursor = true,
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "cyberdream",
      colorscheme = "bluloco",
    },
  },

  -- modicator (auto color line number based on vim mode)
  -- {
  --   "mawkler/modicator.nvim",
  --   -- dependencies = "scottmckendry/cyberdream.nvim",
  --   dependencies = "nyoom-engineering/oxocarbon.nvim",
  --   init = function()
  --     -- These are required for Modicator to work
  --     vim.o.cursorline = false
  --     vim.o.number = true
  --     vim.o.termguicolors = true
  --   end,
  --   opts = {},
  -- },
}
