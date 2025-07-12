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

vim.keymap.set({ "n", "x" }, "<leader>fl", function()
  local text = ""
  local insert_line = vim.api.nvim_win_get_cursor(0)[1] -- default: current line

  -- Normal mode: get word under cursor
  local cursor = vim.api.nvim_win_get_cursor(0)
  insert_line = cursor[1] -- insert below this line
  text = vim.fn.expand("<cword>")

  -- Escape quotes
  text = text:gsub('"', '\\"')

  local log = text ~= "" and ("console.log(" .. text .. ");") or "console.log();"

  -- Insert the log line one below the target
  vim.api.nvim_buf_set_lines(0, insert_line, insert_line, false, { log })

  if text == "" then
    -- Move cursor inside ()
    vim.api.nvim_win_set_cursor(0, { insert_line + 1, string.find(log, "%(") or 0 })
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true), "n", true)
  end
end, { desc = "Smart console.log()", silent = true })
