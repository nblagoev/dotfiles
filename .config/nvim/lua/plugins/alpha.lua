return {
  "goolord/alpha-nvim",
  -- enabled = false,
  event = "VimEnter",
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    math.randomseed(os.time())

    local function pick_color()
      local colors = { "String", "Identifier", "Keyword", "Number" }
      return colors[math.random(#colors)]
    end

    local function generate_bonsai()
      local handle = io.popen("cbonsai -p")
      if not handle then
        return {
            "        .          .        ",
            "      ';;,.        ::'      ",
            "    ,:::;,,        :ccc,    ",
            "   ,::c::,,,,.     :cccc,   ",
            "   ,cccc:;;;;;.    cllll,   ",
            "   ,cccc;.;;;;;,   cllll;   ",
            "   :cccc; .;;;;;;. coooo;   ",
            "   ;llll;   ,:::::'loooo;   ",
            "   ;llll:    ':::::loooo:   ",
            "   :oooo:     .::::llodd:   ",
            "   .;ooo:       ;cclooo:.   ",
            "     .;oc        'coo;.     ",
            "       .'         .,.       ",
        }
      end

      local result = handle:read("*a")
      handle:close()

      -- Split into raw lines (keep all escape codes for now)
      local raw_lines = {}
      for line in (result .. "\n"):gmatch("(.-)\n") do
        table.insert(raw_lines, line)
      end

      -- Extract the last block of lines containing visible characters
      local last_frame_lines = {}
      local i = #raw_lines
      while i > 0 do
        local line = raw_lines[i]
        -- strip ANSI codes
        line = line
          :gsub("\27%].-\7", "")
          :gsub("\27%[[0-9;?%-]*[ -/]*[@-~]", "")
          :gsub("\27%([A-Za-z0-9]", "")
          :gsub("\27.", "")
        if line:find("%S") then
          table.insert(last_frame_lines, 1, line)
        elseif #last_frame_lines > 0 then
          -- stop once we have captured the whole last frame
          break
        end
        i = i - 1
      end

      return last_frame_lines
    end

    dashboard.section.header.val = generate_bonsai()

    dashboard.section.buttons.val = {
      dashboard.button("n", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰱼  Find file", function()
        require("snacks").picker.files({
          layout = { preset = "select", layout = { width = 0.6, min_width = 100, height = 0.4, min_height = 17 } },
        })
      end),
      dashboard.button("s", "  Restore session", ':lua require("sessions").load_session() <CR>'),
      dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
      dashboard.button("r", "󰄉  Recent Files", function() require("snacks").picker.recent() end),
      dashboard.button("e", "  File Explorer", function() require("mini.files").open() end),
      dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      { type = "padding", val = 1 },
    }

    dashboard.section.header.opts.hl = pick_color()
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = pick_color()
    dashboard.opts.layout[1].val = 8

    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "AlphaReady",
    --   command = "set showtabline=0 | set laststatus=0",
    -- })

    local alpha_group = vim.api.nvim_create_augroup("nbl/alpha", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = alpha_group,
      desc = "Minimal UI in Alpha dashboard",
      pattern = "AlphaReady",
      once = true,
      callback = function(args)
        local prev_statuscol = vim.opt.statuscolumn
        vim.o.laststatus = 0
        vim.o.showtabline = 0
        -- vim.o.cmdheight = 0 -- uncomment if not useing noice
        vim.opt.statuscolumn = ""

        vim.api.nvim_create_autocmd("BufUnload", {
          group = alpha_group,
          buffer = args.buf,
          once = true,
          callback = function()
            vim.o.laststatus = 3
            -- vim.o.showtabline = 2
            -- vim.o.cmdheight = 1 -- uncomment if not useing noice
            vim.opt.statuscolumn = prev_statuscol
          end,
        })
        -- -- If we want Alpha to start at launch
        -- vim.api.nvim_create_autocmd("BufUnload", {
        --   group = alpha_group,
        --   buffer = args.buf,
        --   once = true,
        --   callback = vim.schedule_wrap(function()
        --     local width = vim.o.columns
        --     local min_width_threshhold = 140
        --
        --     if width >= min_width_threshhold then
        --       vim.cmd("Neotree show")
        --     end
        --   end),
        -- })
      end,
    })
  end,
}
