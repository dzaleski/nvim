return {
  'alexghergh/nvim-tmux-navigation',
  event = 'VeryLazy',
  config = function()
    -- Initialize the tmux navigation plugin
    local nvim_tmux_nav = require 'nvim-tmux-navigation'

    -- Configure the plugin
    nvim_tmux_nav.setup {
      disable_when_zoomed = true,
      keybindings = {
        left = '<C-h>',
        down = '<C-j>',
        up = '<C-k>',
        right = '<C-l>',
        last_active = '<C-\\>',
        next = '<C-Space>',
      },
    }

    -- Helper function to check if we're in a zoomed tmux pane
    local function is_tmux_zoomed()
      -- Check if we're in tmux and if the pane is zoomed
      local in_tmux = os.getenv 'TMUX' ~= nil
      if in_tmux then
        local handle = io.popen "tmux display-message -p '#{window_zoomed_flag}'"
        if handle then
          local result = handle:read '*a'
          handle:close()
          return result:gsub('%s+', '') == '1'
        end
      end
      return false
    end

    -- Smart jump function for down direction
    local function smart_jump_down()
      -- If in zoomed tmux pane, just use changelist
      if is_tmux_zoomed() then
        pcall(vim.cmd, 'normal! g;zz')
        return
      end

      -- Try to navigate to another window/pane down
      local success = pcall(nvim_tmux_nav.NvimTmuxNavigateDown)
      -- If no window/pane available, jump back in changelist
      if not success then
        pcall(vim.cmd, 'normal! g;zz')
      end
    end

    -- Smart jump function for up direction
    local function smart_jump_up()
      -- If in zoomed tmux pane, just use changelist
      if is_tmux_zoomed() then
        pcall(vim.cmd, 'normal! g,zz')
        return
      end

      -- Try to navigate to another window/pane up
      local success = pcall(nvim_tmux_nav.NvimTmuxNavigateUp)
      -- If no window/pane available, jump forward in changelist
      if not success then
        pcall(vim.cmd, 'normal! g,zz')
      end
    end

    -- Override C-j, C-k and their macOS equivalents
    vim.keymap.set('n', '<C-j>', smart_jump_down, { desc = 'Navigate down or jump back' })
    vim.keymap.set('n', '<C-k>', smart_jump_up, { desc = 'Navigate up or jump forward' })
    vim.keymap.set('n', '<D-j>', smart_jump_down, { desc = 'Navigate down or jump back (macOS)' })
    vim.keymap.set('n', '<D-k>', smart_jump_up, { desc = 'Navigate up or jump forward (macOS)' })

    -- Use default plugin bindings for other directions
    vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = 'Navigate left' })
    vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight, { desc = 'Navigate right' })
    vim.keymap.set('n', '<D-h>', nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = 'Navigate left (macOS)' })
    vim.keymap.set('n', '<D-l>', nvim_tmux_nav.NvimTmuxNavigateRight, { desc = 'Navigate right (macOS)' })
  end,
}
