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
