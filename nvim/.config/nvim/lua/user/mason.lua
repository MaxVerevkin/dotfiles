local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then
  return
end

local lsp_config_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_config_ok then
  return
end

mason.setup {
  ui = {
    border = "rounded",
  },
}

mason_lsp.setup {
  ensure_installed = { "sumneko_lua", "rust_analyzer", "taplo", "bashls" },
}

local lsp_opts = { capabilities = require("user.lsp.handlers").capabilities }

local function make_setup_fn(server)
  return function()
    lspconfig[server].setup(vim.tbl_deep_extend("force", require("user.lsp.settings." .. server), lsp_opts))
  end
end

mason_lsp.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup(lsp_opts)
  end,
  ["rust_analyzer"] = make_setup_fn "rust_analyzer",
  ["sumneko_lua"] = make_setup_fn "sumneko_lua",
  ["arduino_language_server"] = make_setup_fn "arduino_language_server",
}

-- These are installed localy
make_setup_fn "openscad_ls"()
make_setup_fn "clangd"()
