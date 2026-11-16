return {
  -- Minuet (AI autocompletion via Mistral)
  {
    "milanglacier/minuet-ai.nvim",
    enabled = true,
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("minuet").setup({
        provider = "codestral",
        provider_options = {
          codestral = {
            model = "codestral-latest",
            api_key = "MISTRAL_API_KEY",
          },
        },
        virtualtext = {
          auto_trigger_ft = {},
          keymap = {
            accept = "<S-Tab>",
            accept_line = false,
            prev = false,
            next = false,
            dismiss = false,
          },
        },
      })
    end,
  },

}
