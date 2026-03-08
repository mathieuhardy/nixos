return {
  -- Commenter
  {
    "numToStr/Comment.nvim",
    enabled = true,
    lazy = false,
    config = function()
      require("Comment").setup()

      require("Comment.ft").set("sql", "--%s")
    end,
  },

  -- Autopair
  {
    "windwp/nvim-autopairs",
    enabled = true,
    lazy = false,
    event = "InsertEnter",
    config = true,
  },

  -- Open file at position
  {
    "mathieuhardy/file-line",
    enabled = true,
    lazy = false,
  },

  -- Increment/decrement
  {
    "qwertologe/nextval.vim",
    enabled = true,
    lazy = false,
  },

  -- Remove trailing whitespaces
  {
    "ntpeters/vim-better-whitespace",
    enabled = true,
    lazy = false,
  },
}
