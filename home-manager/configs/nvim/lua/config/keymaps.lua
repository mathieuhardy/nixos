-- Open keymaps popup
remap("n", "?", "<CMD>lua toggle_keymaps()<CR>")
remap("v", "?", "<CMD>lua toggle_keymaps()<CR>")

--------------------------------------------------------------------------------
-- Navigation/resizing
--------------------------------------------------------------------------------

-- ctrl-<PageUp/PageDown>: Previous/Next tab
remap("n", "<C-PageUp>", "gT", "Previous tab")
remap("i", "<C-PageUp>", "<ESC>gT", "Previous tab")
remap("v", "<C-PageUp>", "<ESC>gT", "Previous tab")

remap("n", "<C-PageDown>", "gt", "Next tab")
remap("i", "<C-PageDown>", "<ESC>gt", "Next tab")
remap("v", "<C-PageDown>", "<ESC>gt", "Next tab")

-- Resize buffers
remap("", "<C-S-Left>", "<CMD>lua require('smart-splits').resize_left(1)<CR>", "Resize left")
remap("", "<C-S-Right>", "<CMD>lua require('smart-splits').resize_right(1)<CR>", "Resize right")
remap("", "<C-S-Up>", "<CMD>lua require('smart-splits').resize_up(1)<CR>", "Resize up")
remap("", "<C-S-Down>", "<CMD>lua require('smart-splits').resize_down(1)<CR>", "Resize down")

remap("", "<C-S-Left>", "<ESC><CMD>lua require('smart-splits').resize_left(1)<CR>", "Resize left")
remap("", "<C-S-Right>", "<ESC><CMD>lua require('smart-splits').resize_right(1)<CR>", "Resize right")
remap("", "<C-S-Up>", "<ESC><CMD>lua require('smart-splits').resize_up(1)<CR>", "Resize up")
remap("", "<C-S-Down>", "<ESC><CMD>lua require('smart-splits').resize_down(1)<CR>", "Resize down")

remap("v", "<C-S-Left>", "<ESC><CMD>lua require('smart-splits').resize_left(1)<CR>", "Resize left")
remap("v", "<C-S-Right>", "<ESC><CMD>lua require('smart-splits').resize_right(1)<CR>", "Resize right")
remap("v", "<C-S-Up>", "<ESC><CMD>lua require('smart-splits').resize_up(1)<CR>", "Resize up")
remap("v", "<C-S-Down>", "<ESC><CMD>lua require('smart-splits').resize_down(1)<CR>", "Resize down")

-- Navigate through buffers
remap("n", "<C-Up>", "<CMD>lua require('smart-splits').move_cursor_up({at_edge = 'stop'})<CR>", "Go up")
remap("n", "<C-Down>", "<CMD>lua require('smart-splits').move_cursor_down({at_edge = 'stop'})<CR>", "Go down")
remap("n", "<C-Left>", "<CMD>lua require('smart-splits').move_cursor_left({at_edge = 'stop'})<CR>", "Go left")
remap("n", "<C-Right>", "<CMD>lua require('smart-splits').move_cursor_right({at_edge = 'stop'})<CR>", "Go right")

-- ,,: open previous file
remap("n", "<Leader><Leader>", ":e#<CR>", "Previous file")
remap("i", "<Leader><Leader>", "<ESC>:e#<CR>", "Previous file")
remap("v", "<Leader><Leader>", "<ESC>:e#<CR>", "Previous file")

--------------------------------------------------------------------------------
-- Text control
--------------------------------------------------------------------------------

-- shift-v: visual block mode
remap("", "<S-v>", "<C-v>", "Visual block mode")

-- ctrl-a: select all
remap("n", "<C-a>", "gg^^vG$$", "Select all")
remap("i", "<C-a>", "<ESC>gg^^vG$$", "Select all")
remap("v", "<C-f>", "<ESC>gg^^vG$$", "Select all")

-- ctrl-x: cut
remap("v", "<C-x>", '"+x', "Cut")

-- ctrl-c: copy
remap("", "<C-c>", '"+y', "Copy")

-- ctrl-v: paste
remap("n", "<C-v>", '"+gp', "Paste")
remap("i", "<C-v>", '<ESC>"+gpa', "Paste")
remap("v", "<C-v>", '"+gp', "Paste")

-- ctrl-k: comment/uncomment
remap("n", "<C-k>", "gcc", "Comment/uncomment", { noremap = false })
remap("i", "<C-k>", "<ESC>gcc", "Comment/uncomment", { noremap = false })
remap("v", "<C-k>", "gc", "Comment/uncomment", { noremap = false })

-- ctrl-l: Translate
remap("n", "<C-l>", "<CMD>Pantran<CR>", "Translation")
remap("i", "<C-l>", "<ESC><CMD>Pantran<CR>", "Translation")
remap("v", "<C-l>", "<CMD>Pantran<CR>", "Translation")

-- ctrl-w: wrapping
remap("n", "<C-w>", "<CMD>set wrap!<CR>", "Toggle wrapping")
remap("i", "<C-w>", "<ESC><CMD>set wrap!<CR>a", "Toggle wrapping")
remap("v", "<C-w>", "<CMD>set wrap!<CR>", "Toggle wrapping")

-- +/-: increment/decrement value under cursor
remap("n", "<kMinus>", "<Plug>nextvalDec", "Increment/descrement")
remap("n", "<kPlus>", "<Plug>nextvalInc", "Increment/descrement")

remap("n", "-", "<Plug>nextvalDec", "Increment/descrement")
remap("n", "+", "<Plug>nextvalInc", "Increment/descrement")

--------------------------------------------------------------------------------
-- Search
--------------------------------------------------------------------------------

-- ctrl-f: find files
remap("n", "<C-f>", "<CMD>lua require('telescope.builtin').find_files()<CR>", "Find files")
remap("i", "<C-f>", "<ESC><CMD>lua require('telescope.builtin').find_files()<CR>", "Find files")
remap("v", "<C-f>", "<ESC><CMD>lua require('telescope.builtin').find_files()<CR>", "Find files")

-- ctrl-g: grep pattern
remap("n", "<C-g>", "<CMD>lua require('telescope.builtin').live_grep()<CR>", "Grep pattern")
remap("i", "<C-g>", "<ESC><CMD>lua require('telescope.builtin').live_grep()<CR>", "Grep pattern")
remap("v", "<C-g>", "<ESC><CMD>lua require('telescope.builtin').live_grep()<CR>", "Grep pattern")

-- ctrl-j: jump to documentation
remap("n", "<C-j>", "<CMD>RustLsp openDocs<CR>", "Open Rust documentation")
remap("i", "<C-j>", "<ESC><CMD>RustLsp openDocs)<CR>", "Open Rust documentation")
remap("v", "<C-j>", "<ESC><CMD>RustLsp openDocs<CR>", "Open Rust documentation")

-- ctrl-s: search symbol under cursor
remap("n", "<C-s>", "<CMD>AnyJump<CR>", "Jump to definition")
remap("i", "<C-s>", "<ESC><CMD>AnyJump<CR>", "Jump to definition")
remap("v", "<C-s>", "<ESC><CMD>AnyJumpVisual<CR>", "Jump to definition")

--------------------------------------------------------------------------------
-- Advanced
--------------------------------------------------------------------------------

-- ctrl-b: git blame
remap("", "<C-b>", "<CMD>lua toggle_git_blame()<CR>", "Git blame")

-- ctrl-d: delete buffers
remap("", "<C-d>", "<CMD>lua require('close_buffers').delete({type = 'hidden'})<CR>", "Delete closed buffers")

-- ctrl-o: Sort
remap("v", "<C-o>", ":'<,'> sort<CR>", "Sort")

-- ctrl-t: terminal
remap("n", "<C-t>", '<CMD>lua require("FTerm").toggle()<CR>', "Open terminal")
remap("t", "<C-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', "Open terminal")
remap("t", "<ESC>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', "Open terminal")

-- ctrl-p: Show custom commands
remap("n", "<C-p>", ":Telescope command_palette<CR>", "Custom commands")
remap("i", "<C-p>", "<ESC>:Telescope command_palette<CR>a", "Custom commands")
remap("v", "<C-p>", "<ESC>:Telescope command_palette<CR>", "Custom commands")

--------------------------------------------------------------------------------
-- F-keys
--------------------------------------------------------------------------------

-- F1: save
remap("n", "<F1>", ":w<CR>", "Save")
remap("i", "<F1>", "<ESC>:w<CR>a", "Save")
remap("v", "<F1>", "<ESC>:w<CR>", "Save")

-- F2: close
remap("n", "<F2>", ":q<CR>", "Close")
remap("i", "<F2>", "<ESC>:q<CR>", "Close")
remap("v", "<F2>", "<ESC>:q<CR>", "Close")

-- F3: horizontal split
remap("n", "<F3>", ":split<CR>", "Horizontal split")
remap("i", "<F3>", "<ESC>:split<CR>a", "Horizontal split")
remap("v", "<F3>", "<ESC>:split<CR>", "Horizontal split")

-- F4: vertical split
remap("n", "<F4>", ":vsplit<CR>", "Vertical split")
remap("i", "<F4>", "<ESC>:vsplit<CR>a", "Vertical split")
remap("v", "<F4>", "<ESC>:vsplit<CR>", "Vertical split")

-- F5: toggle inlay hints
remap("n", "<F5>", "<CMD>lua toggle_inlay_hints()<CR>", "Toggle inlay hints")
remap("i", "<F5>", "<ESC><CMD>lua toggle_inlay_hints()<CR>a", "Toggle inlay hints")
remap("v", "<F5>", "<CMD>lua toggle_inlay_hints()<CR>", "Toggle inlay hints")

-- F6: color picker
remap("n", "<F6>", "<CMD>Huefy<CR>", "Open color picker")
remap("i", "<F6>", "<ESC><CMD>Huefy<CR>a", "Open color picker")
remap("v", "<F6>", "<CMD>Huefy<CR>", "Open color picker")

-- F7: no highlight
remap("n", "<F7>", ":nohlsearch<CR>", "No highlight")
remap("i", "<F7>", "<ESC>:nohlsearch<CR>a", "No highlight")
remap("v", "<F7>", "<ESC>:nohlsearch<CR>", "No highlight")

-- F9: toggle invisible chars
remap("n", "<F9>", "<CMD>lua toggle_invisible_chars()<CR>", "Show invisible characters")
remap("i", "<F9>", "<ESC><CMD>lua toggle_invisible_chars()<CR>a", "Show invisible characters")
remap("v", "<F9>", "<ESC><CMD>lua toggle_invisible_chars()<CR>", "Show invisible characters")

-- F10: filesystem explorer
remap("n", "<F10>", ":Neotree toggle filesystem<CR>", "Filesystem explorer")
remap("i", "<F10>", "<ESC>:Neotree toggle filesystem<CR>a", "Filesystem explorer")
remap("v", "<F10>", "<ESC>:Neotree toggle filesystem<CR>", "Filesystem explorer")

-- F11: limited view mode
remap("n", "<F11>", ":Limelight!!<CR>", "Limited view mode")
remap("i", "<F11>", "<ESC>:Limelight!!<CR>a", "Limited view mode")
remap("v", "<F11>", "<ESC>:Limelight!!<CR>", "Limited view mode")

-- F12: distraction free mode
remap("n", "<F12>", ":ZenMode<CR>", "Distraction free mode")
remap("i", "<F12>", "<ESC>:ZenMode<CR>a", "Distraction free mode")
remap("v", "<F12>", "<ESC>:ZenMode<CR>", "Distraction free mode")

--------------------------------------------------------------------------------
-- Mouse
--------------------------------------------------------------------------------

remap("n", "<C-LeftMouse>", ":Telescope lsp_definitions<CR>", "Jump to declaration")
remap("i", "<C-LeftMouse>", "<ESC>:Telescope lsp_definitions<CR>a", "Jump to declaration")
remap("v", "<C-LeftMouse>", "<ESC>:Telescope lsp_definitions<CR>", "Jump to declaration")

remap("n", "<C-RightMouse>", ":Telescope lsp_references<CR>", "References")
remap("i", "<C-RightMouse>", "<ESC>:Telescope lsp_references<CR>a", "References")
remap("v", "<C-RightMouse>", "<ESC>:Telescope lsp_references<CR>", "References")
