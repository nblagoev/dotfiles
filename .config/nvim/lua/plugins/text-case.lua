return {
  "johmsalas/text-case.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("textcase").setup({
      prefix = "gi",
    })
  end,
  keys = {
    "gi", -- Default invocation prefix
    {
      "git",
      function()
        require("textcase").operator("to_title_case")
      end,
      mode = { "n", "x" },
      desc = "Convert to Title Case",
    },
  },
  cmd = {
    -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
    "Subs",
    "TextCaseOpenTelescope",
    "TextCaseOpenTelescopeQuickChange",
    "TextCaseOpenTelescopeLSPChange",
    "TextCaseStartReplacingCommand",
  },
}
