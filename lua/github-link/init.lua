local M = {}

function M.setup()
  vim.api.nvim_create_user_command("GetCurrentCommitLink", function() end, { range = true, nargs = 0 })
  vim.api.nvim_create_user_command("GetCurrentBranchLink", function() end, { range = true, nargs = 0 })
end

return M
