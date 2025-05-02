local biome_or_prettier = function()
  local cwd = vim.fn.getcwd()
  local has_biome = vim.fn.filereadable(cwd .. "/biome.json")
  return has_biome == 1 and { "biome-check" } or { "prettierd" }
end

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      javascript = biome_or_prettier,
      javascriptreact = biome_or_prettier,
      json = biome_or_prettier,
      jsonc = biome_or_prettier,
      lua = { "stylua" },
      nix = { "nixfmt" },
      typescript = biome_or_prettier,
      typescriptreact = biome_or_prettier,
      yaml = biome_or_prettier,
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
