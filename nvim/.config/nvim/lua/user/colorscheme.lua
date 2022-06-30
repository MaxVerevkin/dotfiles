vim.o.termguicolors = true
vim.g.gruvbox_sign_column = "bg0"

-- local status_ok_1, gruvbox = pcall(require, "gruvbox")
-- if status_ok_1 then
--   local colors = require "gruvbox.palette"
--   gruvbox.setup {
--     overrides = {
--       SignColumn = { bg = colors.dark0 }, -- depending on your background and contrast this can vary.
--     },
--   }
-- end

local default_theme = "darkplus"
-- local default_theme = "gruvbox"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. default_theme)
if not status_ok then
  vim.notify("colorscheme '" .. default_theme .. "' not found!")
end

-- require("timer").add(function()
--   local daynight = io.popen "day-night --lat 34 --lon 33 --interval 0"
--   local state = daynight:read()
--   daynight:close()
--   if state == "day" then
--     if vim.o.background ~= "light" then
--       vim.o.background = "light"
--     end
--   else
--     if vim.o.background ~= "dark" then
--       vim.o.background = "dark"
--     end
--   end
--   return 5000
-- end)
