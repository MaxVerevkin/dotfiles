return {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
      diagnostics = {
        disabled = {
          "inactive-code",
        },
      },
    },
  },
}
