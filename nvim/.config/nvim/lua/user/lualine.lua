local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  update_in_insert = true,
}

local function gen_colorscheme()
  local normal = vim.api.nvim_get_hl_by_name("Normal", {})
  local function get_hl(name)
    local hl = vim.api.nvim_get_hl_by_name(name, {})
    local bg = string.format("#%06x", hl.background or normal.background)
    local fg = string.format("#%06x", hl.foreground or normal.foreground)
    if not hl.reverse then
      return { fg = fg, bg = bg }
    else
      return { fg = bg, bg = fg }
    end
  end

  local statusline_nc = get_hl "StatusLineNC"
  local status_line = get_hl "StatusLine"
  local insert = get_hl "PmenuSel"
  local visual = get_hl "healthSuccess"

  statusline_nc.gui = "bold"
  insert.gui = "bold"
  visual.gui = "bold"

  local M = {
    normal = {
      a = statusline_nc,
      b = status_line,
      c = { bg = nil, fg = nil },
    },
    insert = {
      a = insert,
      b = status_line,
      c = { bg = nil, fg = nil },
    },
    visual = {
      a = visual,
      b = status_line,
      c = { bg = nil, fg = nil },
    },
  }

  M.inactive = M.normal
  M.command = M.insert
  M.replace = M.insert
  M.terminal = M.insert

  return M
end

local function setup()
  lualine.setup {
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = gen_colorscheme(),
      disabled_filetypes = {
        statusline = { "alpha", "dashboard" },
        -- winbar = {
        --   "",
        --   "alpha",
        --   "help",
        --   "packer",
        --   "NvimTree",
        --   "TelescopePrompt",
        --   "toggleterm",
        --   "DressingInput",
        --   "JABSwindow",
        -- },
      },
      always_divide_middle = true,
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { { "mode", separator = { right = "" } } },
      lualine_b = { { "branch", icon = "" }, "diff" },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { diagnostics, "filetype", "progress" },
      lualine_z = { { "location", separator = { left = "" }, padding = 0 } },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    -- winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = { "filename" },
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {},
    -- },
    -- inactive_winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = { "filename" },
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {},
    -- },
    tabline = {},
    extensions = {},
  }
end

vim.schedule(function()
  setup()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("setup_lualine", {}),
    callback = function()
      setup()
    end,
  })
end)
