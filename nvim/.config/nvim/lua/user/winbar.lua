-- local function gps_location()
--   local gps_ok, gps = pcall(require, "nvim-gps")
--   if not gps_ok then
--     return ""
--   end
--
--   if not gps.is_available() then
--     return ""
--   end
--
--   local location = gps.get_location()
--   if #location == 0 then
--     return ""
--   end
--
--   return "> " .. location .. " "
-- end

vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("winbar_update", {}),
  callback = function()
    local ft_exclude = {
      "",
      "alpha",
      "help",
      "packer",
      "NvimTree",
      "TelescopePrompt",
      "toggleterm",
      "DressingInput",
    }
    if vim.tbl_contains(ft_exclude, vim.bo.filetype) then
      vim.opt_local.winbar = nil
      return
    end

    local function set()
      vim.opt_local.winbar = "%=%m %t " .. require("user.nvim-navic").get()
    end

    pcall(set, {})
  end,
})
