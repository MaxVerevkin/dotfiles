if not vim.fn.has "nvim-0.8" then
  return
end

local ft_exclude = {
  "",
  "alpha",
  "help",
  "packer",
  "NvimTree",
  "TelescopePrompt",
  "toggleterm",
  "DressingInput",
  "JABSwindow",
}

local function isempty(s)
  return s == nil or s == ""
end

local get_filename = function()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"

  if not isempty(filename) then
    local file_icon, file_icon_color =
      require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

    local hl_group = "FileIconColor" .. extension

    if isempty(file_icon) then
      file_icon = ""
      file_icon_color = ""
    end
    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    -- vim.api.nvim_set_hl(0, "Winbar", { fg = "#6b737f" })

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
  end
end

local get_gps = function()
  local status_gps_ok, gps = pcall(require, "nvim-gps")
  if not status_gps_ok or not gps.is_available() then
    return ""
  end

  local gps_location = gps.get_location()

  if not isempty(gps_location) then
    return require("user.icons").ui.ChevronRight .. " " .. gps_location
  else
    return ""
  end
end

local get_winbar = function()
  local value = get_filename()

  if not isempty(value) then
    value = value .. " " .. get_gps()
  end

  return value
end

vim.api.nvim_create_autocmd(
  { "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "Colorscheme" },
  {
    group = vim.api.nvim_create_augroup("winbar_init", {}),
    callback = function()
      vim.schedule(function()
        if vim.tbl_contains(ft_exclude, vim.bo.filetype) then
          vim.opt_local.winbar = nil
        else
          -- vim.opt_local.winbar = "hello"
          vim.opt_local.winbar = get_winbar()
          -- local _, _ = pcall(vim.api.nvim_set_option_value, "winbar", get_winbar(), { scope = "local" })
        end
      end)
    end,
  }
)
