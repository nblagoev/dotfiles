th.git = th.git or {}

th.git.added_sign = "A"
th.git.deleted_sign = "D"
th.git.modified_sign = "M"
th.git.ignored_sign = "I"
th.git.untracked_sign = "?"
th.git.updated_sign = "U"

th.git.added = ui.Style():fg("green"):bold()
th.git.deleted = ui.Style():fg("red"):bold()
th.git.modified = ui.Style():fg("yellow"):bold()
th.git.ignored = ui.Style():fg("white")
th.git.untracked = ui.Style():fg("gray")
th.git.updated = ui.Style():fg("magenta"):bold()

require("folder-rules"):setup()
require("git"):setup()
