return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  enabled = false,
  config = function()
    require('oil').setup {
      default_file_explorer = false,
      columns = { 'icon' },
      keymaps = {
        ['<C-h>'] = false,
        ['<D-h>'] = false,
        ['l'] = 'actions.select',
        ['h'] = 'actions.parent',
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        hide_parent_dir = true,
      },
      prompt_save_on_select_new_entry = true,
    }

    -- Keymap to open Oil with '-'
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'OilActionsPost',
      callback = function(event)
        if event.data.actions.type == 'move' then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
  end,
}
