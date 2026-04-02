local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    htmlangular = { "prettier" },
    graphql = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    python = { "isort", "black" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    dart = { "dart_format" },
    sh = { "shfmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
