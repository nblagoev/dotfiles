return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      pre_hook = function()
        return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
      end,
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  {
    "windwp/nvim-autopairs",
    -- enabled = false,
    -- event = "VeryLazy",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      disable_filetype = { "TelescopePrompt", "snacks_picker_input" },
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      npairs.setup(opts)

      local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
      npairs.add_rules({
        -- Rule for a pair with left-side ' ' and right side ' '
        Rule(" ", " ")
          -- Pair will only occur if the conditional function returns true
          :with_pair(function(opts)
            -- We are checking if we are inserting a space in (), [], or {}
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
              brackets[1][1] .. brackets[1][2],
              brackets[2][1] .. brackets[2][2],
              brackets[3][1] .. brackets[3][2],
            }, pair)
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          -- We only want to delete the pair of spaces when the cursor is as such: ( | )
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({
              brackets[1][1] .. "  " .. brackets[1][2],
              brackets[2][1] .. "  " .. brackets[2][2],
              brackets[3][1] .. "  " .. brackets[3][2],
            }, context)
          end),
      })
      -- For each pair of brackets we will add another rule
      for _, bracket in pairs(brackets) do
        npairs.add_rules({
          -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
          Rule(bracket[1] .. " ", " " .. bracket[2])
            :with_pair(cond.none())
            :with_move(function(opts)
              return opts.char == bracket[2]
            end)
            :with_del(cond.none())
            :use_key(bracket[2])
            -- Removes the trailing whitespace that can occur without this
            :replace_map_cr(function(_)
              return "<C-c>2xi<CR><C-c>O"
            end),
        })
      end
    end,
  },

  {
    "abecodes/tabout.nvim",
    -- enabled = false, -- not needed if using ultimate-autopair
    event = "InsertEnter",
    dependencies = { "nvim-treesitter" },
    opts = {
      tabkey = [[<C-T>]], -- key to trigger tabout, set to an empty string to disable
      backwards_tabkey = [[<C-S-T>]], -- key to trigger backwards tabout, set to an empty string to disable
      act_as_tab = false, -- shift content if tab out is not possible
      act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
      enable_backwards = true, -- well ...
      completion = true, -- if the tabkey is used in a completion pum
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
      },
      ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
      exclude = {}, -- tabout will ignore these filetypes
    },
    -- config = function(_, opts)
    --  require("tabout").setup(opts)
    -- end,
  },

  {
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
  },

  {
    {
      "Wansmer/treesj",
      dependencies = "nvim-treesitter",
      keys = {
        { "<leader>cj", "<cmd>TSJToggle<cr>", desc = "Join/split code block" },
      },
      opts = {
        use_default_keymaps = false,
        max_join_length = 999,
      },
    },
  },

  {
    "mcauley-penney/visual-whitespace.nvim",
    event = "ModeChanged *:[vV\22]",
    opts = {
      fileformat_chars = {
        unix = "¬",
      },
    },
  }
}
