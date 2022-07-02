local lsp_config_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_config_ok then
  return
end

local installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not installer_ok then
  return
end

lsp_installer.setup {}

local function init_server(server)
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "sumneko_lua" then
    opts = vim.tbl_deep_extend("force", require "user.lsp.settings.sumneko_lua", opts)
  end

  if server == "openscad_ls" then
    opts = vim.tbl_deep_extend("force", require "user.lsp.settings.openscad", opts)
  end

  if server == "rust_analyzer" then
    opts = vim.tbl_deep_extend("force", require "user.lsp.settings.rust", opts)
    local rust_status_ok, rust_tools = pcall(require, "rust-tools")
    if rust_status_ok then
      rust_tools.setup {
        server = opts,
        tools = {
          autoSetHints = true,
          hover_with_actions = false,
        },
      }
      return
    end
  end

  lspconfig[server].setup(opts)
end

for _, server in ipairs(lsp_installer.get_installed_servers()) do
  init_server(server.name)
end

init_server "openscad_ls"

-- require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
