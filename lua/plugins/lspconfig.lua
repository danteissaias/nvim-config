return {
  "neovim/nvim-lspconfig",
  dependencies = { "b0o/SchemaStore.nvim", "Saghen/blink.cmp" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    servers = {
      lua_ls = {},
      tailwindcss = {},
      yamlls = {},
      biome = {},
      nil_ls = {},
      -- eslint = {
      --   -- flags = {
      --   --   -- allow_incremental_sync = false,
      --   --   -- debounce_text_changes = 1000,
      --   -- },
      --   cmd = { "vscode-eslint-language-server", "--stdio", "--max-old-space-size=8192" },
      --   root_dir = function(filename)
      --     if string.find(filename, "node_modules/") then
      --       return nil
      --     end
      --
      --     return require("lspconfig.configs.eslint").default_config.root_dir(filename)
      --   end,
      -- },
      jsonls = function()
        return {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        }
      end,
    },
  },
  config = function(_, opts)
    for server, config in pairs(opts.servers) do
      config = type(config) == "function" and config() or config
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end,
}
