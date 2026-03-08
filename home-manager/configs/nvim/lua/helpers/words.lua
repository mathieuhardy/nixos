function get_words()
  if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "" then
    return vim.fn.wordcount().visual_words .. " words"
  else
    return vim.fn.wordcount().words .. " words"
  end
end
