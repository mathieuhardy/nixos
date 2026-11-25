vim.o.compatible = false -- no vi-compatible mode
vim.o.updatetime = 500
vim.o.exrc = false -- don't use local version of .(g)vimrc, .exrc

if vim.fn.has("cmdline_hist") then
  vim.o.history = global_opts.history -- keep 1000 lines of command line
end
