local choose_formatter = function()
  local cwd = vim.fn.getcwd()
  local has_biome = vim.fn.filereadable(cwd .. "/biome.json")
  return has_biome == 1 and { "biome-check" } or { "prettierd" }
end

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = choose_formatter,
      javascriptreact = choose_formatter,
      typescript = choose_formatter,
      typescriptreact = choose_formatter,
      vue = choose_formatter,
      css = choose_formatter,
      scss = choose_formatter,
      less = choose_formatter,
      html = choose_formatter,
      json = choose_formatter,
      jsonc = choose_formatter,
      yaml = choose_formatter,
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
