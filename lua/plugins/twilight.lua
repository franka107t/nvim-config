return {
  "folke/twilight.nvim",
  keys = {
    {
      "<leader>ut",
      "<cmd>Twilight<cr>",
      desc = "Toggle twilight",
    },
  },
  opts = {
    context = 0,
    expand = {
      "function",
      "method",
      "table",
      "if_statement",
      "function_declaration",
      "method_declaration",
      "pair",
    },
  },
}
