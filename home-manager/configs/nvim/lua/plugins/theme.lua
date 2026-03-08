return {
  -- Colorshemes
  {
    "sainnhe/sonokai",
    enabled = true,
    lazy = false,
    init = function()
      vim.g.sonokai_style = "default"
      vim.g.sonokai_disable_italic_comment = 1
      vim.cmd.colorscheme("sonokai")
    end,
  },

  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    init = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
