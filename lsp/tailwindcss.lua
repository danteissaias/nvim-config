-- From https://github.com/neovim/nvim-lspconfig/blob/master/lsp/tailwindcss.lua

local util = require "util"

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = util.find_bin("tailwindcss-language-server", (config or {}).root_dir)
    return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
  end,
  -- filetypes copied and adjusted from tailwindcss-intellisense
  filetypes = {
    -- html
    "aspnetcorerazor",
    "astro",
    "astro-markdown",
    "blade",
    "clojure",
    "django-html",
    "htmldjango",
    "edge",
    "eelixir", -- vim ft
    "elixir",
    "ejs",
    "erb",
    "eruby", -- vim ft
    "gohtml",
    "gohtmltmpl",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "htmlangular",
    "html-eex",
    "heex",
    "jade",
    "leaf",
    "liquid",
    "markdown",
    "mdx",
    "mustache",
    "njk",
    "nunjucks",
    "php",
    "razor",
    "slim",
    "twig",
    -- css
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    "sugarss",
    -- js
    "javascript",
    "javascriptreact",
    "reason",
    "rescript",
    "typescript",
    "typescriptreact",
    -- mixed
    "vue",
    "svelte",
    "templ",
  },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidScreen = "error",
        invalidVariant = "error",
        invalidConfigPath = "error",
        invalidTailwindDirective = "error",
        recommendedVariantOrder = "warning",
      },
      classAttributes = {
        "class",
        "className",
        "class:list",
        "classList",
        "ngClass",
      },
      includeLanguages = {
        htmlangular = "html",
        templ = "html",
      },
    },
  },
  before_init = function(_, config)
    config.settings = vim.tbl_deep_extend("keep", config.settings or {}, {
      editor = { tabSize = vim.lsp.util.get_effective_tabstop() },
    })
  end,
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local root_files = {
      ".git",
    }
    local fname = vim.api.nvim_buf_get_name(bufnr)
    root_files = util.insert_package_json(root_files, "tailwindcss", fname)
    local root_file = vim.fs.find(root_files, { path = fname, upward = true })[1]
    if root_file then
      on_dir(vim.fs.dirname(root_file))
    end
  end,
}
