return {
  -- Rust
  {
    "mrcjkb/rustaceanvim",
    enabled = true,
    lazy = false,
    ft = { rust },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              cachePriming = {
                enable = false,
              },
              files = {
                watcherExclude = {
                  "**/target/**",
                  "**/.git/**",
                },
              },
            },
          },
        },
      }
    end,
  },
}
