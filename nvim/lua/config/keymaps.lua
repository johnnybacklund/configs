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

-- Console.log binding
vim.keymap.set({ "n", "v" }, "<leader>dl", function()
  local mode = vim.fn.mode()

  local selection

  if mode == "v" then
    -- Yank the text into the z buffer then get it from there
    vim.cmd.normal({ '"zy', bang = true })
    selection = vim.fn.getreg("z")

    print(selection)
  end

  vim.api.nvim_put({ "console.log();" }, "l", true, true)

  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_get_current_line()
  local start_col = line:find("%(")

  if start_col then
    -- TODO troubleshoot visual mode thing
    vim.api.nvim_win_set_cursor(0, { row, start_col }) -- 0-based col

    if mode == "v" and selection then
      vim.cmd.normal("<Left>")
      vim.cmd.normal({ '"zp', bang = true })
    end

    vim.api.nvim_input("i") -- enter insert mode inside ()
  end
end, { desc = "Insert console.log()" })
