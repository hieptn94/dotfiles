local lsp_util = require("lspconfig.util")

local function root_has_file(patterns)
  local root = lsp_util.find_git_ancestor(vim.fn.getcwd()) or lsp_util.path.dirname(vim.fn.expand("%:p"))
  for _, pattern in ipairs(patterns) do
    if lsp_util.path.exists(lsp_util.path.join(root, pattern)) then
      return true
    end
  end
  return false
end

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "conditional_prettier", "conditional_biome" },
      javascriptreact = { "conditional_prettier", "conditional_biome" },
      typescript = { "conditional_prettier", "conditional_biome" },
      typescriptreact = { "conditional_prettier", "conditional_biome" },
      json = { "conditional_prettier", "conditional_biome" },
      html = { "conditional_prettier", "conditional_biome" },
      css = { "conditional_prettier", "conditional_biome" },
    },
    formatters = {
      -- Prettier Formatter
      conditional_prettier = {
        command = "prettier",
        args = { "--stdin-filepath", "$FILENAME" },
        condition = function()
          -- Check for Prettier configuration files using root patterns
          return root_has_file({
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.js",
            ".prettierrc.yaml",
            ".prettierrc.yml",
            "prettier.config.js",
            "prettier.config.cjs",
          })
        end,
      },
      -- Biome Formatter
      conditional_biome = {
        command = "biome",
        args = { "format", "--stdin-file-path", "$FILENAME" },
        condition = function()
          -- Check for Biome configuration files using root patterns
          return root_has_file({
            "biome.json",
            "biome.config.json",
          })
        end,
      },
    },
    -- format_on_save = {
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },
  },
}
