require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

-- Editor custom mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "q", "<Nop>", { desc = "Disable macro recording" })
map({ "n", "v", "o" }, "E", "$", { desc = "Go to end of line" })
map({ "n", "v", "o" }, "B", "^", { desc = "Go to start of line" })
-- Delete without yanking
map({ "n", "v" }, "d", '"_d', { desc = "Delete" })
map({ "n", "v" }, "D", '"_D', { desc = "Delete to end of line" })
map({ "n", "v" }, "x", '"_x', { desc = "Delete character" })
map({ "n", "v" }, "X", '"_X', { desc = "Delete character before cursor" })
map({ "n", "v" }, "c", '"_c', { desc = "Change text" })
map({ "n", "v" }, "C", '"_C', { desc = "Change to end of line" })
-- Yank but keep the selection
map("v", "y", "ygv", { desc = "Yank" })
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

-- Handle telescope git errors
local function git_repo(telescope_cmd)
  return function()
    -- Check if in a git repo
    vim.fn.system "git rev-parse --is-inside-work-tree"
    if vim.v.shell_error == 0 then
      require("telescope.builtin")[telescope_cmd]()
    else
      vim.notify("Not a git repository.", vim.log.levels.WARN, { title = "Telescope" })
    end
  end
end

-- Git
map("n", "<leader>gc", git_repo "git_commits", { desc = "Git commits" })
map("n", "<leader>gs", git_repo "git_status", { desc = "Git status" })
map("n", "<leader>gb", git_repo "git_branches", { desc = "Git branch" })
map("n", "<leader>gf", git_repo "git_files", { desc = "Git files" })
map("n", "<leader>ga", git_repo "git_stash", { desc = "Git stash" })

-- Formatting
map("n", "<leader>m", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format file" })

-- Find (Telescope)
map(
  "n",
  "<leader>fa",
  "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
  { desc = "Find all files" }
)
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })
map("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<leader>fm", "<cmd> Telescope marks <CR>", { desc = "Find marks" })
map("n", "<leader>ft", "<cmd> TodoTelescope <CR>", { desc = "Find todo" })

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
