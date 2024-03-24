local git = require("github-link.git")

local M = {
  ref_type_commit = "commit",
  ref_type_branch = "branch",
}

local get_current_filepath = function()
  return vim.fn.expand("%:p")
end

local resolve_ref = function(ref_type)
  if ref_type == M.ref_type_commit then
    return git.get_current_commit()
  elseif ref_type == M.ref_type_branch then
    return git.get_current_branch()
  else
    error(string.format("invalid ref type: %s", ref_type), 0)
  end
end

local build_line = function(start_line, end_line)
  if start_line == end_line then
    return string.format("L%s", start_line)
  end
  return string.format("L%s-L%s", start_line, end_line)
end

local build_url = function(url, ref, file, line)
  local pos = vim.fn.match(file, "\\.md$")
  if pos ~= -1 then
    return string.format("%s/blob/%s/%s?plain=1#%s", url, ref, file, line)
  end
  return string.format("%s/blob/%s/%s#%s", url, ref, file, line)
end

local trim_suffix_git = function(str)
  return vim.fn.substitute(str, "\\.git$", "", "")
end

local to_repo_url = function(url)
  if vim.fn.match(url, "^git") ~= -1 then
    -- git@github.com:user/repo.git
    local matches = vim.fn.matchlist(url, "^git@github.com:\\(.*\\)$")
    return string.format("https://github.com/%s", trim_suffix_git(matches[2]))
  elseif vim.fn.match(url, "^ssh") ~= -1 then
    -- ssh://git@github.com/user/repo.git
    local matches = vim.fn.matchlist(url, "^ssh://git@github.com/\\(.*\\)$")
    return string.format("https://github.com/%s", trim_suffix_git(matches[2]))
  elseif vim.fn.match(url, "^https") ~= -1 then
    -- https://github.com/user/repo.git
    local matches = vim.fn.matchlist(url, "^https://github.com/\\(.*\\)$")
    return string.format("https://github.com/%s", trim_suffix_git(matches[2]))
  else
    error(string.format("invalid or unsupported protocol url: %s", url), 0)
  end
end

function M.get_link(ref_type, start_line, end_line)
  local ok, ref = pcall(resolve_ref, ref_type)
  if not ok then
    vim.api.nvim_err_writeln(tostring(ref))
    return
  end

  local filepath_from_toplevel = string.sub(get_current_filepath(), string.len(git.get_top_directory()) + 2)
  local line = build_line(start_line, end_line)

  local ok, repo_url = pcall(to_repo_url, git.get_remote_url())
  if not ok then
    vim.api.nvim_err_writeln(tostring(repo_url))
    return
  end

  local url = build_url(repo_url, ref, filepath_from_toplevel, line)
  vim.fn.setreg("+", url)
  print(string.format("clipped %s", url))
end

return M
