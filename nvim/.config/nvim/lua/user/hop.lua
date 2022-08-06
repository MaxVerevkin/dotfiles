local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup()

vim.keymap.set("n", "s", require("hop").hint_words)
vim.keymap.set("n", "gt", require("hop").hint_lines)

vim.keymap.set({ "n", "o" }, "f", function()
  hop.hint_char1 {
    direction = require("hop.hint").HintDirection.AFTER_CURSOR,
    current_line_only = true,
    hint_offset = 0,
  }
end)

vim.keymap.set({ "n", "o" }, "F", function()
  hop.hint_char1 {
    direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
    current_line_only = true,
    hint_offset = 0,
  }
end)
vim.keymap.set({ "n", "o" }, "t", function()
  hop.hint_char1 {
    direction = require("hop.hint").HintDirection.AFTER_CURSOR,
    current_line_only = true,
    hint_offset = -1,
  }
end)

vim.keymap.set({ "n", "o" }, "T", function()
  hop.hint_char1 {
    direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
    current_line_only = true,
    hint_offset = 1,
  }
end)
