return {
  "neovim/nvim-lspconfig",
  opts = {
    ---@type table<string, vim.lsp.Config>
    servers = {
      oxfmt = {},
      oxlint = {},
      tailwindcss = {
        settings = {
          tailwindCSS = {
            classFunctions = { "tv", "cn", "clsx", "cva" },
            classRegex = {
              "tv\\(([^)]*)\\)",
              "[\"'`]([^\"'`]*).*?[\"'`]",
            },
          },
        },
      },
    },
  },
}
