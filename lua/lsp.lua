local M = {}

function M.capabilities()
  return vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("blink.cmp").get_lsp_capabilities(),
    {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    }
  )
end

local function on_attach(_, bufnr)
  local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
  end

  map("n", "gd", vim.lsp.buf.definition)

  -- Default in neovim 0.11
  map("n", "grr", vim.lsp.buf.references)
  map("n", "grn", vim.lsp.buf.rename)
  map("n", "gra", vim.lsp.buf.code_action)
  map("i", "<c-s>", vim.lsp.buf.signature_help)
end

vim.diagnostic.config {
  signs = true,
  float = { source = true },
}

local register_capability = vim.lsp.handlers["client/registerCapability"]
vim.lsp.handlers["client/registerCapability"] = function(err, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then
    return
  end

  on_attach(client, vim.api.nvim_get_current_buf())

  return register_capability(err, result, ctx)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    on_attach(client, event.buf)
  end,
})

return M
