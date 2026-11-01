local parsers = {
  "bash",
  "c",
  "cpp",
  "dotprompt",
  "fish",
  "gitcommit",
  "go",
  "graphql",
  "html",
  "hyprlang",
  "java",
  "javascript",
  "json",
  "json5",
  "lua",
  "markdown",
  "markdown_inline",
  "nix",
  "python",
  "query",
  "rasi",
  "regex",
  "rust",
  "scss",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

vim.filetype.add { extension = { prompt = "dotprompt" } }

-- Not in nvim-treesitter. Google's grammar lives in a monorepo subdirectory.
local function register_dotprompt()
  require("nvim-treesitter.parsers").dotprompt = {
    install_info = {
      url = "https://github.com/google/dotprompt",
      revision = "856196bb7e7c705e41983d02e84d21c31844e36f",
      location = "packages/treesitter",
      queries = "packages/treesitter/queries",
    },
  }
end

local function install_list()
  local parser_set = {}
  for _, parser in ipairs(parsers) do
    parser_set[parser] = true
  end

  -- nvim-treesitter queries must match their parser revisions. Install
  -- replacements for parsers bundled with Neovim to prevent version drift.
  local site = vim.fn.stdpath "data"
  for _, path in ipairs(vim.api.nvim_get_runtime_file("parser/*", true)) do
    if not vim.startswith(path, site) then
      parser_set[vim.fn.fnamemodify(path, ":t:r")] = true
    end
  end

  return vim.tbl_keys(parser_set)
end

local function prepend_query_runtime()
  local init = vim.api.nvim_get_runtime_file("lua/nvim-treesitter/init.lua", false)[1]
  if not init then
    return
  end

  local runtime = vim.fs.joinpath(vim.fn.fnamemodify(init, ":h:h:h"), "runtime")
  if not vim.tbl_contains(vim.api.nvim_list_runtime_paths(), runtime) then
    vim.opt.runtimepath:prepend(runtime)
  end
end

return {
  src = "nvim-treesitter/nvim-treesitter",
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      group = vim.api.nvim_create_augroup("DotpromptParser", { clear = true }),
      callback = register_dotprompt,
    })
    register_dotprompt()
    prepend_query_runtime()
    require("nvim-treesitter").install(install_list()):wait(300000)

    vim.api.nvim_create_autocmd("PackChanged", {
      group = vim.api.nvim_create_augroup("NvimTreesitterUpdate", { clear = true }),
      callback = function(args)
        if
          args.data.spec.name == "nvim-treesitter"
          and (args.data.kind == "install" or args.data.kind == "update")
        then
          vim.schedule(function()
            prepend_query_runtime()
            local treesitter = require "nvim-treesitter"
            treesitter.install(install_list()):wait(300000)
            treesitter.update():wait(300000)
          end)
        end
      end,
    })
  end,
}
