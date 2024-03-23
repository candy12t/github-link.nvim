local M = {}

function M.get_current_commit()
  local result = vim.fn.system("git rev-parse HEAD")
  return string.gsub(result, "\n", "")
end

function M.get_current_branch()
  local result = vim.fn.system("git rev-parse --abbrev-ref HEAD")
  return string.gsub(result, "\n", "")
end

function M.get_top_directory()
  local result = vim.fn.system("git rev-parse --show-toplevel")
  return string.gsub(result, "\n", "")
end

function M.get_remote_url()
  local result = vim.fn.system("git ls-remote --get-url origin")
  return string.gsub(result, "\n", "")
end

return M
