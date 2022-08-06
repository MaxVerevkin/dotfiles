local ok, inlay_hints = pcall(require, "lsp-inlayhints")
if not ok then
  return
end

inlay_hints.setup()

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("InitInlayHints", {}),
  callback = function(args)
    inlay_hints.on_attach(args.buf, vim.lsp.get_client_by_id(args.data.client_id))
  end,
})
