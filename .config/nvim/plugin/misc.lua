local add = require('vim-pack').add
local add_on_event = require('vim-pack').add_on_event

add {
  {
    src = 'notjedi/nvim-rooter.lua',
    module_name = 'nvim-rooter'
  },
}

add_on_event('BufReadPre', {
  {
    src = "LunarVim/bigfile.nvim",
    opts = {
      features = { -- features to disable
        -- "filetype",
        "illuminate",
        "indent_blankline",
        "lsp",
        "matchparen",
        "syntax",
        "treesitter",
        -- "vimopts",
      },
    },
  },
})

add_on_event('BufReadPost', {
  {
    src = "lukas-reineke/virt-column.nvim",
    opts = {
      char = { "│" },
      virtcolumn = "120",
      exclude = { filetypes = { "markdown", "oil" } },
    },
  },
})

add_on_event({ "BufReadPre", "BufNewFile" }, {
  {
    src = "RRethy/vim-illuminate",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    setup = false,
    on_setup = function(opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
  }
})
