local githublink = require("github-link.core")

local M = {}

local subcommands = {
  get_commit_link = githublink.ref_type_commit,
  get_branch_link = githublink.ref_type_branch,
}

function M.setup()
  vim.api.nvim_create_user_command("GitHubLink", function(opts)
    githublink.get_link(subcommands[opts.args], opts.line1, opts.line2)
  end, {
    range = true,
    nargs = 1,
    complete = function()
      local keys = {}
      for k, _ in pairs(subcommands) do
        table.insert(keys, k)
      end
      return keys
    end,
  })
end

return M
