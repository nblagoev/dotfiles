-- Install with: uv tool install ty@latest

---@type vim.lsp.Config
return {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_markers = { 'ty.toml', 'pyproject.toml' }
}
