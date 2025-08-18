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

-- vim.keymap.set("n", "<leader>ff", function()
--   require("snacks").pick("files", { root = false })
-- end)

vim.keymap.set(
  "n",
  "<leader><space>",
  require("telescope.builtin").find_files,
  { desc = "Find Files (cwd but actually root)" }
)

vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "Grep (cwd but actually root)" })

-- "<leader>fF"
--
vim.keymap.set(
  "n",
  "<leader>pc",
  insertFullPath,
  { noremap = true, silent = true, desc = "Copy path of current buffer" }
)

vim.keymap.set({ "n", "v" }, "<leader>y", '"+', { desc = "Choose system register" })
