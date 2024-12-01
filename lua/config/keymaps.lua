-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
--
-- Tmux
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
vim.keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
vim.keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true })

--  ToggleTerm
-- TODO: Move toggleterm keymaps to plugin file
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

vim.keymap.set(
  "n",
  "<leader>ft",
  "<cmd>:ToggleTerm direction=float<CR>",
  { noremap = true, silent = true, desc = "Open toggle terminal" }
)

-- Borderless lazygit
local Util = require("lazyvim.util")
vim.keymap.set("n", "<leader>gg", function()
  Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false, border = "none" })
end, { desc = "Lazygit (root dir)" })

vim.keymap.del({ "n", "i", "v" }, "<A-j>")
vim.keymap.del({ "n", "i", "v" }, "<A-k>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Right>")
vim.keymap.set("n", "<M-h>", '<Cmd>lua require("tmux").resize_left()<CR>', { silent = true })
vim.keymap.set("n", "<M-j>", '<Cmd>lua require("tmux").resize_bottom()<CR>', { silent = true })
vim.keymap.set("n", "<M-k>", '<Cmd>lua require("tmux").resize_top()<CR>', { silent = true })
vim.keymap.set("n", "<M-l>", '<Cmd>lua require("tmux").resize_right()<CR>', { silent = true })

-- package-info keymaps
local set_keymap = vim.api.nvim_set_keymap
set_keymap(
  "n",
  "<leader>cpt",
  "<cmd>lua require('package-info').toggle()<cr>",
  { silent = true, noremap = true, desc = "Toggle" }
)
set_keymap(
  "n",
  "<leader>cpd",
  "<cmd>lua require('package-info').delete()<cr>",
  { silent = true, noremap = true, desc = "Delete package" }
)
set_keymap(
  "n",
  "<leader>cpu",
  "<cmd>lua require('package-info').update()<cr>",
  { silent = true, noremap = true, desc = "Update package" }
)
set_keymap(
  "n",
  "<leader>cpi",
  "<cmd>lua require('package-info').install()<cr>",
  { silent = true, noremap = true, desc = "Install package" }
)
set_keymap(
  "n",
  "<leader>cpc",
  "<cmd>lua require('package-info').change_version()<cr>",
  { silent = true, noremap = true, desc = "Change package version" }
)

-- Gitsigns
-- local gs = require("gitsigns")
--
-- vim.keymap.set("n", "]H", function()
--   gs.nav_hunk("last")
-- end, { desc = "Last Hunk" })
--
-- vim.keymap.set("n", "[H", function()
--   gs.nav_hunk("first")
-- end, { desc = "First Hunk" })
--
-- vim.keymap.set({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
--
-- vim.keymap.set({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
--
-- vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
--
-- vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
--
-- vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
--
-- vim.keymap.set("n", "<leader>ghp", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })
--
-- vim.keymap.set("n", "<leader>ghb", function()
--   gs.blame_line({ full = true })
-- end, { desc = "Blame Line" })
--
-- vim.keymap.set("n", "<leader>ghB", function()
--   gs.blame()
-- end, { desc = "Blame Buffer" })
--
-- vim.keymap.set("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
--
-- vim.keymap.set("n", "<leader>ghD", function()
--   gs.diffthis("~")
-- end, { desc = "Diff This ~" })
--
-- vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk" })
