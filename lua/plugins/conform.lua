return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      nix = { "nixfmt" },
      go = { "gofmt" },
    },
    format_on_save = function()
      -- Stop if we disabled auto-formatting.
      if not vim.g.autoformat then
        return nil
      end

      return {
        timeout_ms = 500,
        lsp_format = "prefer",
        filter = function(client)
          return client.name == "oxfmt"
        end,
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
