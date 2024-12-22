return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufWritePre' },
  opts = {
    preview_config = {
      border = CUSTOM_BORDER,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(m, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        opts.desc = string.format('Gitsigns: %s', opts.desc)
        vim.keymap.set(m, l, r, opts)
      end

      map('n', ']c', gs.next_hunk, { desc = 'Go to next diff hunk' })
      map('n', '[c', gs.prev_hunk, { desc = 'Go to previous diff hunk' })
      map('n', '<leader>gbl', gs.blame_line, { desc = '[G]it [B]lame current [L]ine' })
      map('n', '<leader>gbf', gs.blame, { desc = '[G]it [B]lame entire [F]ile' })
      map('n', '<leader>gdh', gs.preview_hunk, { desc = '[G]it Preview [D]iff [H]unk' })
      map('n', '<leader>grh', gs.reset_hunk, { desc = '[R]eset diff [H]unk over cursor' })
      map('n', '<leader>grf', gs.reset_buffer, { desc = '[G]it [R]eset diff for entire [F]ile' })
    end,
  },
}
