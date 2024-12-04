return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      typescript = { "biome-check", "prettierd", stop_after_first = true },
      typescriptreact = { "biome-check", "prettierd", stop_after_first = true },
      javascript = { "biome-check", "prettierd", stop_after_first = true },
      javascriptreact = { "biome-check", "prettierd", stop_after_first = true },
      json = { "biome-check", "prettierd", stop_after_first = true },
      jsonc = { "biome-check", "prettierd", stop_after_first = true },
      css = { "biome-check", "prettierd", stop_after_first = true },
      yaml = { "prettierd" },
      html = { "prettierd" },
      lua = { "stylua" },
    },
    formatters = {
      prettierd = { require_cwd = true },
      ["biome-check"] = { require_cwd = true },
    },
    format_on_save = function()
      if vim.g.autoformat then
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end
    end,
  },
  init = function()
    vim.g.autoformat = true
  end,
}
