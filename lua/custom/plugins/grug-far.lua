return {
  'MagicDuck/grug-far.nvim',
  config = function(_, opts)
    require('grug-far').setup(opts)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'grug-far',
      callback = function()
        -- Map q to quit after ensuring we're in normal mode
        vim.keymap.set({ 'i', 'n' }, 'q', '<Cmd>stopinsert | bd!<CR>', { buffer = true })
      end,
    })
  end,
  keys = {
    {
      '<leader>sr',
      function()
        require('grug-far').open {
          transient = true,
        }
      end,
      mode = { 'n', 'v' },
      desc = '[S]earch and [R]eplace',
    },
    {
      '<leader>sR',
      function()
        local filepath = vim.fn.expand '%:p' -- Full path (e.g., /a/b/c/d/h.lua)
        if filepath == '' or vim.fn.filereadable(filepath) == 0 then
          vim.notify('No valid file path!', vim.log.levels.WARN)
          return
        end

        -- Get workspace root (e.g., /a/b/c)
        local workspace_root = vim.fn.systemlist('git rev-parse --show-toplevel 2>/dev/null')[1] or vim.loop.cwd() -- Fallback to current dir if not in Git

        -- Trim workspace prefix and leading slashes
        local relative_path = filepath:gsub(workspace_root, ''):gsub('^[/\\]+', '')

        require('grug-far').open {
          transient = true,
          prefills = {
            filesFilter = relative_path, -- e.g., "d/h.lua" (no workspace prefix)
          },
        }
      end,
      mode = { 'n', 'v' },
      desc = '[S]earch and [R]eplace in current file',
    },
  },
}
