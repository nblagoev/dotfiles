THEME.git = THEME.git or {}

THEME.git.added_sign = "A"
THEME.git.deleted_sign = "D"
THEME.git.modified_sign = "M"
THEME.git.ignored_sign = "I"
THEME.git.untracked_sign = "?"
THEME.git.updated_sign = "U"

THEME.git.added = ui.Style():fg("green"):bold()
THEME.git.deleted = ui.Style():fg("red"):bold()
THEME.git.modified = ui.Style():fg("yellow"):bold()
THEME.git.ignored = ui.Style():fg("white")
THEME.git.untracked = ui.Style():fg("gray")
THEME.git.updated = ui.Style():fg("magenta"):bold()

require("folder-rules"):setup()
require("git"):setup()
require("githead"):setup({
  show_branch = true,
  branch_prefix = "on",
  branch_color = "blue",
  branch_symbol = "",
  branch_borders = "()",

  commit_color = "bright magenta",
  commit_symbol = "@",

  show_behind_ahead = false,
  show_stashes = false,
  show_state = false,
  show_staged = false,
  show_unstaged = false,
  show_untracked = false,
})

