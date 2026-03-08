return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "LinArcX/telescope-command-palette.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              width = 0.9,
            },
          },
          mappings = {
            i = {
              ["<F3>"] = "select_horizontal",
              ["<F4>"] = "select_vertical",
            },
          },
        },
        extensions = {
          command_palette = {
            {
              "AI",
              { "Chat", ":CodeCompanionChat" },
              { "Suggestions - Codeium", ":lua select_ai_suggestions_backend('codeium')" },
              { "Suggestions - Copilot", ":lua select_ai_suggestions_backend('copilot')" },
              { "Suggestions - Disabled", ":lua select_ai_suggestions_backend('')" },
            },
            {
              "Man pages",
              { "Search", ":lua require('telescope.builtin').man_pages()" },
            },
            {
              "Notes",
              { "Open", ":VimwikiIndex" },
            },
            {
              "Rust",
              { "Actions", ":lua rust_hover_actions()" },
              { "Run", ":lua rust_runnables()" },
            },
          },
        },
      })

      require("telescope").load_extension("command_palette")
    end,
  },
}
