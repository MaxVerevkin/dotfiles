local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = { active = signs },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document()
  vim.api.nvim_exec(
    [[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
  ]],
    false
  )
end

local function lsp_keymaps(client, bufnr)
  local keymap = function(mode, key, cmd)
    vim.keymap.set(mode, key, cmd, { buffer = bufnr, silent = true })
  end
  keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
  keymap("n", "gr", "<cmd>Telescope lsp_references<cr>")
  keymap("n", "gi", "<cmd>Telescope lsp_implementations<cr>")
  keymap("n", "K", vim.lsp.buf.hover)
  keymap("n", "<A-{>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  keymap("n", "<A-}>", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  if client.name == "rust_analyzer" then
    keymap("v", "K", require("rust-tools.hover_range").hover_range)
  end
  keymap("n", "gl", function()
    vim.diagnostic.open_float(0, { border = "rounded" })
  end)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(client, bufnr)
  require("user.autoformat").on_attach(client, bufnr)
  -- FIXME: use `pcall`
  require("lsp_signature").on_attach()

  if client.server_capabilities.documentHighlightProvider then
    lsp_highlight_document()
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
end

return M
