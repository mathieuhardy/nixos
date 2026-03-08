if vim.fn.has("autocmd") then
  local GeneralGroup = vim.api.nvim_create_augroup("General settings", { clear = true })

  -- Strip white spaces
  vim.api.nvim_create_autocmd({ "BufWrite" }, {
    pattern = global_opts.strip_whitespaces,
    callback = function()
      vim.cmd("StripWhitespace")
    end,
  })

  -- Set executable
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*" },
    callback = function()
      if starts_with(vim.fn.getline(1), "#!") then
        vim.cmd("silent !chmod a+x <afile>")
      end
    end,
  })

  -- Tab sizes according to filetypes
  for filetype, size in pairs(global_opts.tab_sizes) do
    autocmd_add_tab_size(GeneralGroup, filetype, size)
  end

  -- Autoformat
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = global_opts.auto_format,
    callback = function(args)
      require("conform").format({ bufnr = args.buf })
    end,
  })

  -- Templates
  local base_path = vim.fn.stdpath("config") .. "/templates"
  local paths = vim.fn.split(vim.fn.globpath(base_path, "skeleton.*"))

  for _, path in ipairs(paths) do
    local extension = path:gsub(base_path .. "/skeleton.", "")

    vim.api.nvim_create_autocmd({ "BufNewFile" }, {
      pattern = "*." .. extension,
      callback = function()
        load_template(extension)
      end,
    })
  end

  -- Disable conceallevel for json
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc" },
    callback = function()
      vim.opt_local.conceallevel = 0
    end,
  })
end
