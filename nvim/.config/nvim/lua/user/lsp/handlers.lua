local M = {}

M.setup = function()
  local function sign(name, text)
    vim.fn.sign_define(name, { texthl = name, text = text, numhl = "" })
  end

  sign("DiagnosticSignError", "")
  sign("DiagnosticSignWarn", "")
  sign("DiagnosticSignHint", "")
  sign("DiagnosticSignInfo", "")

  vim.diagnostic.config {
    virtual_text = false,
    virtual_lines = false,
    update_in_insert = true,
    severity_sort = true,
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("CustomLspOnAttach", {}),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup("LspDocHighlight" .. args.buf, {})
        vim.api.nvim_create_autocmd("CursorHold", {
          group = group,
          buffer = args.buf,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
          group = group,
          buffer = args.buf,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end,
  })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
end

return M
