function get_current_suggestions_backend()
  if global_opts.ai.suggestions_backend ~= nil and global_opts.ai.suggestions_backend ~= "" then
    return global_opts.ai.suggestions_backend
  else
    return "-"
  end
end

function toggle_ai_suggestions_backend()
  if global_opts.ai.suggestions_backend == nil or global_opts.ai.suggestions_backend == "" then
    select_ai_suggestions_backend("codeium")
  elseif global_opts.ai.suggestions_backend == "codeium" then
    select_ai_suggestions_backend("copilot")
  else
    select_ai_suggestions_backend("")
  end
end

function select_ai_suggestions_backend(backend)
  global_opts.ai.suggestions_backend = backend

  set_codeium_status(backend == "codeium")
  set_copilot_status(backend == "copilot")

  if backend == "codeium" then
    set_codeium_keymap()
  elseif backend == "copilot" then
    set_copilot_keymap()
  end
end

function set_codeium_status(enabled)
  if enabled then
    require("codeium").enable()
  else
    require("codeium").disable()
  end
end

function set_codeium_keymap()
  remap("i", "<S-Tab>", function()
    return require("codeium.virtual_text").accept()
  end, "Accept AI suggestion", { expr = true })
end

function set_copilot_status(enabled)
  if enabled then
    vim.cmd("Copilot enable")
  else
    vim.cmd("Copilot disable")
  end
end

function set_copilot_keymap()
  remap("i", "<S-Tab>", function()
    return require("copilot.suggestion").accept()
  end, "Accept AI suggestion", { expr = true })
end
