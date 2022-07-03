local status_ok, jabs = pcall(require, "jabs")
if not status_ok then
  return
end

jabs.setup {
  position = "center",
  border = "none",
  highlight = {
    current = "StatusLine",
    hidden = "ModeMsg",
    split = "StatusLine",
    alternate = "ModeMsg",
  },
  keymap = {
    close = "<c-d>",
  },
}
