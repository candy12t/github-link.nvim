local M = {}

local helloworld = function()
  print("Hello, World!")
end

function M.setup()
  vim.api.nvim_create_user_command("HelloWorld", helloworld, {})
end

return M
