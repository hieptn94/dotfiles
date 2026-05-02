return {
  "neovim/nvim-lspconfig",
  opts = {
    ---@type table<string, vim.lsp.Config>
    servers = {
      oxfmt = {},
      oxlint = {},
      fsautocomplete = {
        on_attach = function(client)
          -- This is the magic line to stop the freeze
          client.server_capabilities.semanticTokensProvider = nil
        end,
        settings = {
          FSharp = {
            -- Also disable these to prevent the background 'test detection' spam seen in your logs
            enableTestCodeLens = false,
            lucidAnalysis = false,
          },
        },
      },
    },
  },
}
