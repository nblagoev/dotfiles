-- Own commands

-- Shorten function name
local command = vim.api.nvim_create_user_command
local opts = { noremap = true, silent = true }
local keymap = function(mode, keys, cmd, options)
  options = options or {}
  options = vim.tbl_deep_extend("force", opts, options)
  vim.api.nvim_set_keymap(mode, keys, cmd, options)
end

command('ToggleFormat', function()
    vim.g.autoformat = not vim.g.autoformat
    vim.notify(string.format('%s formatting...', vim.g.autoformat and 'Enabling' or 'Disabling'), vim.log.levels.INFO)
end, { desc = 'Toggle conform.nvim auto-formatting', nargs = 0 })

command('ToggleInlayHints', function()
    vim.g.inlay_hints = not vim.g.inlay_hints
    vim.notify(string.format('%s inlay hints...', vim.g.inlay_hints and 'Enabling' or 'Disabling'), vim.log.levels.INFO)

    local mode = vim.api.nvim_get_mode().mode
    vim.lsp.inlay_hint.enable(vim.g.inlay_hints and (mode == 'n' or mode == 'v'))
end, { desc = 'Toggle inlay hints', nargs = 0 })

command('Scratch', function()
    vim.cmd 'bel 10new'
    local buf = vim.api.nvim_get_current_buf()
    for name, value in pairs {
        filetype = 'scratch',
        buftype = 'nofile',
        bufhidden = 'wipe',
        swapfile = false,
        modifiable = true,
    } do
        vim.api.nvim_set_option_value(name, value, { buf = buf })
    end
end, { desc = 'Open a scratch buffer', nargs = 0 })


-- Markdown preview commands using `gh-markdown-preview`
command("MarkdownPreviewStart", function()
  vim.cmd("MarkdownPreviewStop")
  local file = vim.fn.expand("%")

  -- Check if file is markdown
  if vim.bo.filetype ~= "markdown" then
    vim.notify("Not a markdown file", vim.log.levels.WARN)
    return
  end

  _G.md_preview_job = vim.fn.jobstart("gh markdown-preview " .. file, {
    detach = false,
    on_exit = function()
      _G.md_preview_job = nil
      vim.notify("Markdown preview exited", vim.log.levels.INFO)
    end,
  })
  vim.notify("Markdown preview started at http://localhost:3333", vim.log.levels.INFO)
end, {})
command("MarkdownPreviewStop", function()
  if _G.md_preview_job then
    vim.fn.jobstop(_G.md_preview_job)
    _G.md_preview_job = nil
    vim.notify("Markdown preview stopped", vim.log.levels.INFO)
  end
end, {})
command("MarkdownPreviewToggle", function()
  if _G.md_preview_job then
    vim.cmd("MarkdownPreviewStop")
  else
    vim.cmd("MarkdownPreviewStart")
  end
end, {})
vim.keymap.set(
  "n",
  "<leader>tp",
  "<cmd>MarkdownPreviewToggle<cr>",
  { desc = "Markdown preview" }
)

-- toggle more in the SimpleStatusline
vim.api.nvim_create_user_command("StatusMoreInfo", function()
  _G.show_more_info = not _G.show_more_info
  -- vim.g.show_more_info = not vim.g.show_more_info
  vim.cmd("redrawstatus!")
end, {})
keymap("n", "<leader>ti", ":StatusMoreInfo<cr>", { desc = "Status: more info" })

-- Other Commands
command("YankCwd", function()
  local cwd = vim.fn.getcwd()
  vim.cmd(string.format("call setreg('*', '%s')", cwd))
  print("Cwd copied to clipboard!")
end, {})
keymap("n", "<leader>oy", "<cmd>YankCwd<cr>", { desc = "Yank current dir" })

command("OpenGithubRepo", function()
  local mode = vim.api.nvim_get_mode().mode
  local text = ""

  if mode == "v" then
    text = vim.getVisualSelection()
    vim.fn.setreg('"', text) -- yank the selected text
  else
    local node = vim.treesitter.get_node() --[[@as TSNode]]
    -- Get the text of the node
    text = vim.treesitter.get_node_text(node, 0)
  end

  if text:match("^[%w%-%.%_%+]+/[%w%-%.%_%+]+$") == nil then
    local msg = string.format("OpenGithubRepo: '%s' Invalid format. Expected 'foo/bar' format.", text)
    vim.notify(msg, vim.log.levels.ERROR)
    return
  end

  local url = string.format("https://www.github.com/%s", text)
  print("Opening", url)
  vim.ui.open(url)
end, {})
vim.keymap.set({ "n", "v" }, "<leader>og", "<cmd>OpenGithubRepo<cr>", { desc = "Open Github Repo" })

-- Command to preview files using macOS Quick Look
command("QuickLookPreview", function()
  local mode = vim.api.nvim_get_mode().mode
  local filepath = ""

  if mode == "v" then
    filepath = vim.getVisualSelection()
  else
    filepath = vim.fn.expand("<cfile>")
  end

  -- Get current buffer's directory
  local buf_dir = vim.fn.expand("%:p:h")

  -- Resolve relative path against current buffer's directory
  filepath = vim.fn.resolve(buf_dir .. "/" .. filepath)

  -- Check if file exists
  if vim.fn.filereadable(filepath) == 0 then
    local msg = string.format("QuickLookPreview: File '%s' does not exist", filepath)
    vim.notify(msg, vim.log.levels.ERROR)
    return
  end

  -- Preview file with Quick Look
  vim.system({ "qlmanage", "-p", filepath }, {
    stdout = false,
    stderr = false,
  })
  vim.defer_fn(function()
    vim.system({ "osascript", "-e", 'tell application "qlmanage" to activate' })
  end, 200)
end, {})
vim.keymap.set(
  { "n", "v" },
  "<leader>ov",
  "<cmd>QuickLookPreview<cr>",
  { desc = "Quick Look File Preview" }
)

command("LuaInspect", function()
  local sel = vim.fn.mode() == "v" and vim.getVisualSelection() or nil
  if sel then
    local chunk, load_error = load("return " .. sel)
    if chunk then
      local success, result = pcall(chunk)
      if success then
        vim.notify(vim.inspect(result), vim.log.levels.INFO)
      else
        vim.notify("Error evaluating expression: " .. result, vim.log.levels.ERROR)
      end
    else
      vim.notify("Error loading expression: " .. load_error, vim.log.levels.ERROR)
    end
  else
    vim.api.nvim_feedkeys(":lua print(vim.inspect())", "n", true)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true), "n", true)
  end
end, {})
vim.keymap.set({ "n", "v" }, "<leader>Li", "<cmd>LuaInspect<cr>", { desc = "Lua Inspect" })

command("LuaPrint", function()
  if vim.fn.mode() == "v" then
    vim.cmd("LuaInspect")
  else
    vim.api.nvim_feedkeys(":lua print()", "n", true)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", true)
  end
end, {})
vim.keymap.set({ "n", "v" }, "<leader>Lp", "<cmd>LuaPrint<cr>", { desc = "Lua Print" })

-- Function to shuffle lines
local function shuffle_lines()
  -- Get the start and end line numbers of the visual selection
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Extract the lines within the selection
  local lines = vim.fn.getline(start_line, end_line)

  -- Shuffle the lines
  math.randomseed(os.time())
  for i = #lines, 2, -1 do
    local j = math.random(i)
    lines[i], lines[j] = lines[j], lines[i]
  end

  -- Replace the original lines with the shuffled lines
  vim.fn.setline(start_line, lines)
end

command("ShuffleLines", shuffle_lines, { range = true })

command("ConvertHEXtoUpper", function()
  vim.cmd("'<,'>s/#[0-9A-Fa-f]\\{3,8}\\(\"\\)\\?/\\=toupper(submatch(0))")
end, { range = true })

keymap("v", ",h", ":ConvertHEXtoUpper<cr>", { desc = "Covert HEX color to Uppercase" })

command("ToggleSpellCheck", function()
  if vim.wo.spell then
    vim.wo.spell = false
    vim.notify("Spell checking disabled", vim.log.levels.INFO)
  else
    vim.wo.spell = true
    vim.cmd("setlocal spell spelllang=en_us")
    vim.notify("Spell checking enabled", vim.log.levels.INFO)
  end
end, {})
keymap("n", "<leader>tS", ":ToggleSpellCheck<cr>", { desc = "Spell checking" })

-- Command to remove trailing whitespace
command("TrimTrailingWhitespace", function(cmd_opts)
  local start_line, end_line

  if cmd_opts.range == 0 then
    start_line = vim.fn.line(".")
    end_line = start_line
  else
    start_line = cmd_opts.line1
    end_line = cmd_opts.line2
  end

  -- Execute the substitution command
  vim.cmd(string.format("silent %d,%ds/\\s\\+$//e", start_line, end_line))
  vim.cmd("nohlsearch")

  -- Provide feedback
  local count = end_line - start_line + 1
  local message = "Trimmed trailing whitespace from " .. count .. " line" .. (count > 1 and "s" or "")
  vim.notify(message, vim.log.levels.INFO)
end, { range = true })

vim.keymap.set({ "n", "v" }, ",w", ":TrimTrailingWhitespace<cr>", { desc = "Trim trailing whitespace" })

-- Command to shuffle paragraphs within a visual selection
command("ShuffleParagraphs", function(cmd_opts)
  local start_line = cmd_opts.line1
  local end_line = cmd_opts.line2

  -- Get selected lines
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- Identify paragraph boundaries within selection
  local paragraphs = {}
  local current_paragraph = {}

  for _, line in ipairs(lines) do
    table.insert(current_paragraph, line)
    -- Empty line marks paragraph boundary
    if line:match("^%s*$") then
      table.insert(paragraphs, current_paragraph)
      current_paragraph = {}
    end
  end

  -- Add the last paragraph if it's not empty
  if #current_paragraph > 0 then
    table.insert(paragraphs, current_paragraph)
  end

  -- Shuffle paragraphs using Fisher-Yates algorithm
  math.randomseed(os.time())
  for i = #paragraphs, 2, -1 do
    local j = math.random(i)
    paragraphs[i], paragraphs[j] = paragraphs[j], paragraphs[i]
  end

  -- Flatten paragraphs back into lines
  local shuffled_lines = {}
  for _, paragraph in ipairs(paragraphs) do
    for _, line in ipairs(paragraph) do
      table.insert(shuffled_lines, line)
    end
  end

  -- Replace only the selected portion with shuffled paragraphs
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, shuffled_lines)
end, { range = true })

-- Command to close all opened terminals
command("CloseAllTerminals", function()
  local buffers = vim.api.nvim_list_bufs()
  local closed_count = 0

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
      local buftype = vim.bo[buf].buftype
      if buftype == "terminal" then
        vim.api.nvim_buf_delete(buf, { force = true })
        closed_count = closed_count + 1
      end
    end
  end

  vim.notify("Closed " .. closed_count .. " terminal buffers", vim.log.levels.INFO)
end, {})

-- Follow internal markdown links
command("FollowMarkdownLink", function()
  -- Get current line
  local line = vim.api.nvim_get_current_line()

  -- Extract the link target from [text](#target) format
  local target = line:match("%[.-%]%(#([^%)]+)%)")

  if not target then
    vim.notify("No markdown link found on current line", vim.log.levels.WARN)
    return
  end

  -- Convert anchor to heading text (replace - with space and _ with space)
  local heading_text = target:gsub("[-_]", " ")

  -- Escape special characters for vim regex
  heading_text = vim.fn.escape(heading_text, "\\")

  -- Search for the heading (any level) - case insensitive
  -- \c makes the search case insensitive
  local pattern = "\\c^#\\+\\s\\+" .. heading_text

  local found = vim.fn.search(pattern, "w")

  if found == 0 then
    vim.notify("Heading not found: #" .. target, vim.log.levels.WARN)
  end
end, {})

-- Set up Enter key mapping only for markdown buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<leader>ga", ":FollowMarkdownLink<cr>", { buffer = true, desc = "Follow markdown link" })
  end,
})
