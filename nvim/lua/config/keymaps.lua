-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)

function insertFullPath()
  local filepath = vim.fn.expand("%")
  vim.fn.setreg("*", filepath) -- write to clippoard
  vim.notify("Copied '" .. filepath .. "'", "info")
end

vim.keymap.set(
  "n",
  "<leader>pc",
  insertFullPath,
  { noremap = true, silent = true, desc = "Copy path of current buffer" }
)

-- Switch around bindings for find file in telescope
vim.keymap.set(
  "n",
  "<leader><space>",
  require("telescope.builtin").find_files,
  { desc = "Find Files (cwd but actually root)" }
)

vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "Grep (cwd but actually root)" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+', { desc = "Choose system register" })

-- Oil bindings
vim.keymap.set("n", "<BS>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>o", function()
  require("oil").open_float(".")
end, { desc = "Open Oil floating window" })
