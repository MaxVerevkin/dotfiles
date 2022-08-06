local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- local nvim_tree_config = require "nvim-tree.config"
-- local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  disable_netrw = true,
  open_on_setup = true,
  sync_root_with_cwd = true,
  filters = {
    custom = { "^\\.git" },
    exclude = { ".gitignore", ".github" },
  },
  renderer = {
    group_empty = true,
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        git = {
          unstaged = "",
          staged = "S",
          untracked = "U",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    icons = { hint = "" },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  view = {
    mappings = {
      custom_only = true,
      list = {
        -- TODO clear this up
        { key = { "<CR>", "l" }, action = "edit" },
        { key = "c", action = "cd" },
        { key = "s", "split" },
        { key = "v", "vsplit" },
        { key = "h", action = "close_node" },
        { key = "p", action = "preview" },
        { key = "I", action = "toggle_git_ignored" },
        { key = "H", action = "toggle_dotfiles" },
        { key = "U", action = "toggle_custom" },
        { key = "R", action = "refresh" },
        { key = "a", action = "create" },
        { key = "d", action = "remove" },
        { key = "D", action = "trash" },
        { key = "r", action = "rename" },
        { key = "<C-r>", action = "full_rename" },
        { key = "x", action = "cut" },
        { key = "y", action = "copy_name" },
        { key = "Y", action = "copy_path" },
        { key = "gy", action = "copy_absolute_path" },
        { key = "[e", action = "prev_diag_item" },
        { key = "[c", action = "prev_git_item" },
        { key = "]e", action = "next_diag_item" },
        { key = "]c", action = "next_git_item" },
        { key = "-", action = "dir_up" },
        { key = "f", action = "live_filter" },
        { key = "F", action = "clear_live_filter" },
        { key = "q", action = "close" },
        { key = "W", action = "collapse_all" },
        { key = "E", action = "expand_all" },
        { key = "S", action = "search_node" },
        { key = ".", action = "run_file_command" },
        { key = "<C-k>", action = "toggle_file_info" },
        { key = "g?", action = "toggle_help" },
      },
    },
  },
}
