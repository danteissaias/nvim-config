return {
  src = "stevearc/conform.nvim",
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixfmt" },
        go = { "gofmt" },
      },
      format_on_save = function()
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
    }

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    vim.g.autoformat = true
  end,
}
