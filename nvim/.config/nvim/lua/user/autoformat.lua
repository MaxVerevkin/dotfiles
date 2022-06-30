local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local _enabled = {}
local _ignored = { "tsserver", "sumneko_lua", "openscad_ls" }

local function is_enabled(bufnr)
  return vim.tbl_contains(_enabled, bufnr)
end

local function is_not_ignored(server)
  return not vim.tbl_contains(_ignored, server.name)
end

local function enable(bufnr)
  table.insert(_enabled, bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format {
        bufnr = bufnr,
        filter = is_not_ignored,
      }
    end,
  })
end

local function disable(bufnr)
  _enabled = vim.tbl_filter(function(b)
    return b ~= bufnr
  end, _enabled)
  vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
end

local M = {}

function M.on_attach(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    if not is_enabled(bufnr) and is_not_ignored(client) then
      enable(bufnr)
    end
  end
end

function M.toggle()
  local bufnr = vim.api.nvim_win_get_buf(0)
  if is_enabled(bufnr) then
    disable(bufnr)
    vim.notify "Autoformat disabled"
  else
    enable(bufnr)
    vim.notify "Autoformat enabled"
  end
end

return M
