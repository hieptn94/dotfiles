return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim" },
  },
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {},
  },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "eslint", "ts_ls", "jsonls", "lua_ls", "prismals", "tailwindcss", "biome" },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    lspconfig.ts_ls.setup({
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      cmd_env = {
        NODE_OPTIONS = "--max-old-space-size=8192",
      },
    })

    lspconfig.eslint.setup({
      root_dir = function(fname)
        local root = util.root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js")(fname)
        if root then
          return root
        else
          return nil
        end
      end,
      cmd_env = { NODE_OPTIONS = "--max-old-space-size=8192" },
    })

    lspconfig.biome.setup({
      root_dir = util.root_pattern("biome.json", "biome.config.json"),
    })

    lspconfig.jsonls.setup({
      filetypes = { "json" },
    })

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            local opts = { noremap = true, silent = true, buffer = bufnr }

            -- Map code actions with descriptions
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
              desc = "LSP: Show Code Actions",
              noremap = true,
              silent = true,
              buffer = bufnr,
            })

            -- Additional community-recommended LSP key mappings
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to Definition", unpack(opts) })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Go to Declaration", unpack(opts) })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP: Find References", unpack(opts) })
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP: Go to Implementation", unpack(opts) })
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename Symbol", unpack(opts) })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Show Hover", unpack(opts) })
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Help", unpack(opts) })

            -- Diagnostics
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Previous Diagnostic", unpack(opts) })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Next Diagnostic", unpack(opts) })
          end,
        })
      end,
    })
    return true
  end,
}
