require "nvchad.autocmds"

-- Hide tabufline while CodeDiff is open (it uses its own tab)
vim.api.nvim_create_autocmd("User", {
  pattern = "CodeDiffOpen",
  callback = function()
    vim.g._codediff_showtabline = vim.o.showtabline
    vim.o.showtabline = 0
  end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "CodeDiffClose",
  callback = function()
    if vim.g._codediff_showtabline ~= nil then
      vim.o.showtabline = vim.g._codediff_showtabline
      vim.g._codediff_showtabline = nil
    end
  end,
})

-- TODO: Test: Explorer should not be able to survive alone
-- vim.api.nvim_create_autocmd("WinClosed", {
--   callback = function()
--     vim.schedule(function()
--       local aux = { snacks_explorer = true, snacks_picker_list = true, snacks_picker_input = true }
--       local wins = vim.api.nvim_tabpage_list_wins(0)
--
--       local has_real = false
--       for _, w in ipairs(wins) do
--         if vim.api.nvim_win_get_config(w).relative == "" then
--           if not aux[vim.bo[vim.api.nvim_win_get_buf(w)].filetype] then
--             has_real = true
--             break
--           end
--         end
--       end
--
--       if not has_real and #wins > 0 then
--         if #vim.api.nvim_list_tabpages() > 1 then
--           vim.cmd "tabclose!"
--         else
--           vim.cmd "qall"
--         end
--       end
--     end)
--   end,
-- })
