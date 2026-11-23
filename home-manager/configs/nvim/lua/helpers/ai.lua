function get_current_suggestions_backend()
  if global_opts.ai.suggestions_backend ~= nil and global_opts.ai.suggestions_backend ~= "" then
    return global_opts.ai.suggestions_backend
  else
    return "-"
  end
end

function toggle_ai_suggestions_backend()
  if global_opts.ai.suggestions_backend == nil or global_opts.ai.suggestions_backend == "" then
    select_ai_suggestions_backend("minuet")
  else
    select_ai_suggestions_backend("")
  end
end

function select_ai_suggestions_backend(backend)
  global_opts.ai.suggestions_backend = backend
  set_minuet_status(backend == "minuet")
end

function set_minuet_status(enabled)
  local action = require("minuet.virtualtext").action
  if enabled then
    action.enable_auto_trigger()
  else
    action.disable_auto_trigger()
  end

  local cmp = require("cmp")
  local sources = vim.tbl_filter(function(s) return s.name ~= "minuet" end, cmp.get_config().sources)
  if enabled then
    table.insert(sources, { name = "minuet" })
  end
  cmp.setup({ sources = cmp.config.sources(sources) })
end
