return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "go", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Toggle" },
      { "<leader>jc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Toggle" },
      { "<leader>jl", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "CodeCompanion Inline Assistant" },
      { "<leader>jA", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
      { "<leader>js", "<cmd>CodeCompanionChat Add<cr>", mode = { "v" }, desc = "CodeCompanion Add Selection" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      display = {
        chat = {
          window = {
            layout = "buffer",
            width = 0.4,
            position = "left",
          },
        },
      },
      strategies = {
        chat = {
          -- adapter = "anthropic",
          -- adapter = "openai",
          adapter = "copilot",
          keymaps = {
            change_adapter = {
              modes = { n = "gA" },
            },
          },
        },
        inline = { adapter = "copilot" },
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = { model = { default = "claude-sonnet-4" } },
          })
        end,
      },
    },
  },

  {
    "Aaronik/GPTModels.nvim",
    enabled = false,
    cmd = { "GPTModelsCode" },
    keys = {
      { "<leader>jg", ":GPTModelsCode<cr>", mode = { "n", "v" }, desc = "GPTModelsCode" },
      { "<leader>jG", ":GPTModelsChat<cr>", mode = { "n", "v" }, desc = "GPTModelsChat" },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    dependencies = {
      "AndreM222/copilot-lualine",
    },
    keys = {
      {
        "<leader>tP",
        function()
          vim.cmd("Copilot toggle")
        end,
        desc = "Copilot",
      },
    },
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-c>",
          accept_word = false,
          accept_line = false,
          next = "<C-n>",
          prev = "<C-p>",
          dismiss = "<C-]>",
        },
      },
    },
  },

  {
    "Exafunction/codeium.vim",
    -- enabled = false,
    cmd = { "CodeiumEnable", "CodeiumDisable" },
    -- stylua: ignore
    keys = {
      {
        "<leader>tC",
        function()
          if vim.g.codeium_enabled then
            vim.cmd("CodeiumDisable")
          else
            vim.cmd("CodeiumEnable")
          end
          vim.cmd("redrawstatus!")
        end,
        silent = true,
        desc = "Codeium Toggle",
      },
      { "<C-c>", function() return vim.fn["codeium#Accept"]() end, mode = "i", expr = true, silent = true, desc = "Codeium Accept" },
      { "<C-n>", function() return vim.fn["codeium#CycleCompletions"](1) end, mode = "i", expr = true, silent = true, desc = "Codeium Next" },
      { "<C-p>", function() return vim.fn["codeium#CycleCompletions"](-1) end, mode = "i", expr = true, silent = true, desc = "Codeium Prev" },
      { "<C-]>", function() return vim.fn["codeium#Clear"]() end, mode = "i", expr = true, silent = true, desc = "Codeium Clear" },
      { "<M-\\>", function() return vim.fn["codeium#Complete"]() end, mode = "i", expr = true, silent = true, desc = "Codeium Complete" },
    },
    init = function()
      vim.g.codeium_disable_bindings = 1
      -- vim.g.codeium_manual = true
    end,
  }
}
