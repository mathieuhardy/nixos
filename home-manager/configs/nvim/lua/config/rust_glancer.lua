vim.lsp.config('rust_glancer', {
  cmd = { vim.fn.exepath('rust-glancer'), 'lsp' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'Cargo.lock' },
  init_options = {
    diagnostics = {
      onStartup = true,
      onSave = true,
    },
  },
})
vim.lsp.enable('rust_glancer')
