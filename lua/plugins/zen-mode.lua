return {
  {
    "folke/zen-mode.nvim",
    keys = {
      {
        "<leader>uz",
        "<cmd>ZenMode<cr>",
        desc = "Toggle zen mode",
      },
    },
    opts = {
      window = {
        width = 120,
      },
      plugins = {
        alacritty = {
          enabled = true,
          font = "30",
        },
        options = {
          laststatus = 0,
        },
        twilight = {
          enabled = false,
        },
      },
      -- on_open = function()
      --   require("package-info").hide()
      -- end,
    },
  },
}
