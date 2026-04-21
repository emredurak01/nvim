require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "eslint",
  "clangd",
  "gopls",
  "pyright",
  "ruff",
  "rust_analyzer",
  "bashls",
  "yamlls",
  "jsonls",
  "taplo",
  "marksman",
  "graphql",
  "dartls",
}

vim.lsp.enable(servers)

vim.lsp.config("pyright", {
  settings = {
    pyright = { disableOrganizeImports = true },
    python = {
      analysis = { ignore = { "*" } },
    },
  },
})

vim.lsp.config("eslint", {
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})
