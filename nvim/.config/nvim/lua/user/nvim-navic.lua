local status_ok, navic = pcall(require, "nvim-navic")
local setup = false

local M = {}

function M.setup()
  if setup then
    return
  end

  navic.setup {}

  setup = true
end

function M.on_attach(client, bufnr)
  if not status_ok then
    return
  end

  M.setup()
  navic.attach(client, bufnr)
end

function M.get()
  if not status_ok then
    return ""
  end
  if not navic.is_available() then
    return ""
  end
  local location = navic.get_location {}
  if #location == 0 then
    return ""
  end
  return "> " .. location .. " "
end

return M
