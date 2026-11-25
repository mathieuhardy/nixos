function remap(mode, lhs, rhs, desc, opts)
  local options = {
    noremap = true,
    silent = true,
    desc = desc,
  }

  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  if type(rhs) == "function" then
    vim.keymap.set(mode, lhs, rhs, options)
  else
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end
end

function rmmap(mode, lhs)
  vim.api.nvim_del_keymap(mode, lhs)
end

function toggle_keymaps()
  if vim.g.keymap_popup_id and vim.api.nvim_win_is_valid(vim.g.keymap_popup_id) then
    vim.api.nvim_win_close(vim.g.keymap_popup_id, true)
    vim.g.keymap_popup_id = nil
  else
    local path = vim.fn.stdpath("config") .. "/data/keymaps.txt"
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.readfile(path))
    vim.bo[buf].modifiable = false

    local ui = vim.api.nvim_list_uis()[1]
    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = 80,
      height = 51,
      row = math.floor((ui.height - 51) / 2),
      col = math.floor((ui.width - 80) / 2),
      style = "minimal",
      border = "rounded",
      title = " Keymaps ",
      title_pos = "center",
    })

    vim.keymap.set("n", "q", function()
      vim.api.nvim_win_close(win, true)
      vim.g.keymap_popup_id = nil
    end, { buffer = buf, nowait = true })

    vim.g.keymap_popup_id = win
  end
end
