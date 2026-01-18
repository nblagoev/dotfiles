-- https://www.nerdfonts.com/cheat-sheet

  --   פּ ﯟ   蘒練   some other good icons
local M = {
  kind = {
    Class = '',
    Color = '', -- 󰏘
    Constant = '󰏿', -- 
    Constructor = '', -- 
    Enum = '', -- 
    EnumMember = '', -- 
    Event = '', -- 
    Field = '', -- 
    File = '', -- 󰈙
    Folder = '', --  󰉋
    Function = '󰊕', -- 󰆧
    Interface = '', -- 
    Keyword = '󰌋', -- 
    Method = '󰊕', -- 󰆧
    Module = '󰆧', --  
    Namespace = '󰦮', -- 󰌗
    Operator = '󰆕', -- 
    Package = '',
    Property = '', -- 
    Reference = '󰈇', --   
    Snippet = '', -- 
    Struct = '', -- 󰙅 󰆼 
    Text = '󰉿',
    TypeParameter = '',
    Unit = '',
    Value = '', -- 󰎠
    Variable = '󰀫', -- 
    Misc = '',
  },
  type = {
    Array = '󰅪', -- 
    Boolean = " ", --   󰨙
    Number = " ", -- 󰎠 
    String = " ", --  󰉿
    Object = " ",
    Null = "", -- 󰟢
  },
  documents = {
    File = " ", -- 
    Files = " ", -- 
    Folder = " ", -- 
    OpenFolder = " ", -- 
  },
  git = {
    Add = " ",
    Mod = " ",
    Remove = " ",
    Ignore = " ",
    Rename = " ",
    Diff = " ",
    Repo = " ",
    Octoface = " ",
    Branch = " " -- 
  },
  ui = {
    ArrowClosed = "",
    ArrowOpen = "",
    Lock = " ",
    Circle = " ",
    BigCircle = " ",
    BigUnfilledCircle = " ",
    Close = " ",
    NewFile = " ",
    Search = " ", -- 
    Lightbulb = " ",
    Project = " ",
    Dashboard = " ",
    History = " ",
    Comment = " ",
    Bug = " ", -- 
    Code = " ",
    Telescope = " ",
    Gear = " ",
    Package = " ",
    List = " ",
    SignIn = " ",
    SignOut = " ",
    NoteBook = " ",
    Check = " ",
    Fire = " ",
    Note = " ",
    BookMark = " ",
    Pencil = " ",
    ChevronRight = "",
    Table = " ",
    Calendar = " ",
    CloudDownload = " ",
  },
  diagnostics = {
    Error = " ",
    Warning = " ",
    Information = " ",
    Question = " ",
    Hint = " ",
  },
  misc = {
    Palette = '󰏘',
    Robot = " ", -- 󰚩
    Squirrel = " ",
    Tag = " ",
    Watch = " ",
    Smiley = " ",
    Package = " ",
    CircuitBoard = " ",
    Terminal = '',
  },
  dap = {
  	Breakpoint = "",
  	BreakpointDisabled = "",
  	BreakpointConditional = "",
  	BreakpointLog = "",
  	BreakpointRejected = "",
  	Stopped = "",
  	Disconnect = "",
  	Pause = "",
  	Play = "",
  	Run_last = "",
  	Step_back = "",
  	Step_into = "",
  	Step_out = "",
  	Step_over = "",
  	Terminate = "",
  }
}

M.lazyvim_icons = {
  Codeium = "󰘦",
  Copilot = "",
}

M.devicons_override = {
  default_icon = {
    icon = "󰈚",
    name = "Default",
    color = "#E06C75",
  },
  toml = {
    icon = "",
    name = "toml",
    color = "#61AFEF",
  },
  tsx = {
    icon = "",
    name = "Tsx",
    color = "#20c2e3",
  },
  gleam = {
    icon = "",
    name = "Gleam",
    color = "#FFAFF3",
  },
  py = {
    icon = "",
    color = "#519ABA",
    cterm_color = "214",
    name = "Py",
  },
}

return M
