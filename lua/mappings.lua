require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

-- Editor custom mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "q", "<Nop>", { desc = "Disable macro recording" })
map({ "n", "v", "o" }, "E", "$", { desc = "Go to end of line" })
map({ "n", "v", "o" }, "B", "^", { desc = "Go to start of line" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })
----

-- Whichkey mappings
-- Code
map("n", "<leader>c", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>r", function()
  require "nvchad.lsp.renamer"()
end, { desc = "Rename" })

-- Buffers
map("n", "<leader>b", "<cmd> enew <CR>", { desc = "Create buffer" })
map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Close buffer" })

-- Tree
map("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Explorer" })

-- Comments
map("n", "<leader>/", "gcc", { desc = "Comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "Comment toggle", remap = true })

-- Handle git errors
local function git_repo_snacks(snacks_cmd)
  return function()
    -- Check if in a git repo
    vim.fn.system "git rev-parse --is-inside-work-tree"
    if vim.v.shell_error == 0 then
      local ok, snacks = pcall(require, "snacks")
      if ok then
        snacks.picker[snacks_cmd]()
      end
    else
      vim.notify("Not a git repository.", vim.log.levels.WARN, { title = "Snacks Picker" })
    end
  end
end

-- Git
map("n", "<leader>gc", git_repo_snacks "git_log", { desc = "Git commits" })
map("n", "<leader>gs", git_repo_snacks "git_status", { desc = "Git status" })
map("n", "<leader>gb", git_repo_snacks "git_branches", { desc = "Git branch" })
map("n", "<leader>gf", git_repo_snacks "git_files", { desc = "Git files" })
map("n", "<leader>ga", git_repo_snacks "git_stash", { desc = "Git stash" })

-- Formatting
map("n", "<leader>m", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format file" })

-- Find (Snacks Picker)
map("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Find files" })
map("n", "<leader>fa", function()
  Snacks.picker.files { hidden = true, ignored = true, follow = true }
end, { desc = "Find all files" })
map("n", "<leader>fw", function()
  Snacks.picker.grep()
end, { desc = "Grep project" })
map("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Find buffers" })
map("n", "<leader>fo", function()
  Snacks.picker.recent()
end, { desc = "Find oldfiles" })
map("n", "<leader>fz", function()
  Snacks.picker.lines()
end, { desc = "Find in current buffer" })
map("n", "<leader>fh", function()
  Snacks.picker.help()
end, { desc = "Help page" })
map("n", "<leader>fm", function()
  Snacks.picker.marks()
end, { desc = "Find marks" })
map("n", "<leader>ft", function()
  Snacks.picker.todo_comments()
end, { desc = "Find todo" })

-- Terminal
map({ "n", "t" }, "<A-f>", function()
  require("floaterm").toggle()
end, { desc = "Toggle Floaterm" })

-- Remove NvChad defaults
pcall(nomap, "n", "<leader>h") -- Horizontal term
pcall(nomap, "n", "<leader>v") -- Vertical term
pcall(nomap, "n", "<leader>n") -- Line number
pcall(nomap, "n", "<leader>rn") -- Relative number
pcall(nomap, "n", "<leader>ra") -- Old rename
pcall(nomap, "n", "<leader>ds") -- Loclist diagnostics
pcall(nomap, "n", "<leader>pt") -- Pick hidden term
pcall(nomap, "n", "<leader>D") -- Type definition
pcall(nomap, "n", "<leader>ca") -- Old code action
pcall(nomap, "n", "<leader>ch") -- LSP help
pcall(nomap, "n", "<leader>cm") -- Default LSP implementation
pcall(nomap, "n", "<leader>ma") -- Old marks
pcall(nomap, "n", "<leader>gt") -- Old git status
pcall(nomap, "n", "<leader>fm") -- Old general format (replaced by <leader>m)
pcall(nomap, "n", "<C-n>") -- Unmap default NvimTree toggle

-- Override NvChad default buffer-local actions
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      pcall(vim.keymap.del, "n", "<leader>ra", { buffer = args.buf })
      pcall(vim.keymap.del, "n", "<leader>D", { buffer = args.buf })
    end)
  end,
})
