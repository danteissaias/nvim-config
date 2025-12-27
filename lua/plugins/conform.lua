local get_js_formatter = function()
  local cwd = vim.fn.getcwd()
  local has_oxfmt = vim.fn.filereadable(cwd .. "/.oxfmtrc.json") == 1
  local has_biome = vim.fn.filereadable(cwd .. "/biome.json") == 1

  if has_oxfmt then
    return { "oxfmt" }
  elseif has_biome then
    return { "biome-check" }
  else
    return { "prettierd" }
  end
end

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      javascript = get_js_formatter,
      javascriptreact = get_js_formatter,
      json = get_js_formatter,
      jsonc = get_js_formatter,
      lua = { "stylua" },
      nix = { "nixfmt" },
      typescript = get_js_formatter,
      typescriptreact = get_js_formatter,
      yaml = get_js_formatter,
      go = { "gofmt" },
    },
    format_on_save = function()
      -- Stop if we disabled auto-formatting.
      if not vim.g.autoformat then
        return nil
      end

      return {
        timeout_ms = 500,
        lsp_format = "fallback",
      }
    end,
  },
  init = function()
    -- Use conform for gq.
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    -- Start auto-formatting by default (and disable with ToggleFormat command).
    vim.g.autoformat = true
  end,
}
