local M = {}

function M.get_current_commit()
  return vim.fn.system("git rev-parse HEAD")
end

function M.get_current_branch()
  return vim.fn.system("git rev-parse --abbrev-ref HEAD")
end

function M.get_top_directory()
  return vim.fn.system("git rev-parse --show-toplevel")
end

function M.get_remote_url()
  return vim.fn.system("git ls-remote --get-url origin")
end

return M
