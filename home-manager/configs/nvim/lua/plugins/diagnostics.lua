return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    enabled = true,
    lazy = false,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic",
        options = {
          add_messages = {
            display_count = true,
          },
          multilines = {
            enabled = true,
          },
          show_source = {
            enabled = true,
            if_many = true,
          },
        },
      })
    end,
  },
}
