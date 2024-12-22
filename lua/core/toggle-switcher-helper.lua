-- lua/toggle_switcher.lua

local M = {}

-- Define file toggle pairs (suffix mapping)
local toggle_pairs = {
  ['component.ts'] = 'component.html',
  ['component.html'] = 'component.ts',
  ['en.json'] = 'da.json',
  ['da.json'] = 'en.json',
  ['Query.cs'] = 'QueryHandler.cs',
  ['QueryHandler.cs'] = 'Query.cs',
  ['Command.cs'] = 'CommandHandler.cs',
  ['CommandHandler.cs'] = 'Command.cs',
}

-- Define the quick switcher toggle function
M.quick_switcher_toggle = function()
  local current_file = vim.fn.expand '%:t' -- Get the current file name (basename only)
  local current_dir = vim.fn.expand '%:p:h' -- Get the directory path
  local target_file = nil

  -- Iterate over each suffix in the toggle_pairs to find a match
  for suffix, toggle_to in pairs(toggle_pairs) do
    -- Check if the current file name contains the suffix
    if current_file:match(suffix) then
      -- Remove the suffix from the current file name and add the new target suffix
      target_file = current_file:gsub(suffix .. '$', '') .. toggle_to
      break
    end
  end

  if target_file then
    -- Construct the full target file path with the current directory
    local target_file_path = current_dir .. '/' .. target_file

    -- Check if the target file exists
    if vim.loop.fs_stat(target_file_path) then
      vim.cmd('e ' .. target_file_path)
    else
      vim.notify('Target file does not exist: ' .. target_file_path, vim.log.levels.WARN)
    end
  else
    vim.notify('No toggle pair found for ' .. current_file, vim.log.levels.INFO)
  end
end

vim.keymap.set('n', '<D-o>', function() -- Support for macos
  M.quick_switcher_toggle()
end, { desc = 'Toggle between related files' })

vim.keymap.set('n', '<A-o>', function()
  M.quick_switcher_toggle()
end, { desc = 'Toggle between related files' })

return M
