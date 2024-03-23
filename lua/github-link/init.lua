local githublink = require("github-link.core")

local M = {}

function M.setup()
  vim.api.nvim_create_user_command("GetCurrentCommitLink", function(opts)
    githublink.get_link("commit", opts.line1, opts.line2)
  end, { range = true, nargs = 0 })

  vim.api.nvim_create_user_command("GetCurrentBranchLink", function(opts)
    githublink.get_link("branch", opts.line1, opts.line2)
  end, { range = true, nargs = 0 })
end

return M
