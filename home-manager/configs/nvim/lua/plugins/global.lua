return {
  -- Tree parser
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    lazy = false,
    branch = "master",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      -- External parsers
      require("nvim-treesitter.parsers").get_parser_configs().mustache = {
        install_info = {
          url = "https://github.com/TheLeoP/tree-sitter-mustache",
          branch = "main",
          files = { "src/parser.c", "src/scanner.c" },
        },
        filetype = "mustache",
      }

      -- Select languages
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "cpp",
          "css",
          "csv",
          "dockerfile",
          "doxygen",
          "fish",
          "git_config",
          "gitignore",
          "go",
          "helm",
          "html",
          "hurl",
          "javascript",
          "json",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "mustache",
          "nix",
          "proto",
          "python",
          "regex",
          "rust",
          "scss",
          "sql",
          "ssh_config",
          "svelte",
          "terraform",
          "toml",
          "typescript",
          "typst",
          "vim",
          "vimdoc",
          "vue",
          "xml",
          "yaml",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- External tool installer
  {
    "williamboman/mason.nvim",
    enabled = true,
    lazy = false,
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- Base
      require("mason").setup()

      -- Tools
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Formaters
          "beautysh",
          "black",
          "isort",
          "nixfmt",
          "stylua",
          -- Debugger
          "codelldb",
        },
      })
    end,
  },
}
