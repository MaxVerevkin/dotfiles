local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup()

vim.keymap.set("n", "gw", "<cmd>HopWord<cr>")
vim.keymap.set("n", "gt", "<cmd>HopLine<cr>")

vim.keymap.set("", "f", function()
  require("hop").hint_char1 {
    direction = require("hop.hint").HintDirection.AFTER_CURSOR,
    current_line_only = true,
    hint_offset = 0,
  }
end)

vim.keymap.set("", "F", function()
  require("hop").hint_char1 {
    direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
    current_line_only = true,
    hint_offset = 0,
  }
end)
vim.keymap.set("", "t", function()
  require("hop").hint_char1 {
    direction = require("hop.hint").HintDirection.AFTER_CURSOR,
    current_line_only = true,
    hint_offset = -1,
  }
end)

vim.keymap.set("", "T", function()
  require("hop").hint_char1 {
    direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
    current_line_only = true,
    hint_offset = 1,
  }
end)
