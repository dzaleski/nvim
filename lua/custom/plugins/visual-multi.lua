return {
  'mg979/vim-visual-multi',
  branch = 'master',
  init = function()
    vim.g.VM_leader = '\\'

    vim.g.VM_default_mappings = 1
    vim.g.VM_theme = 'iceblue'
    vim.g.VM_silent_exit = 0
    vim.g.VM_show_warnings = 1

    vim.g.VM_maps = {
      -- Default
      ['Find Under'] = '<C-n>',
      ['Find Subword Under'] = '<C-n>',
      ['Add Cursor Down'] = '<C-Down>',
      ['Add Cursor Up'] = '<C-Up>',
      ['Select All'] = '\\A',

      ['Next'] = 'n',
      ['Prev'] = 'N',

      ['Visual Regex'] = '\\/',
      ['Visual All'] = '\\A',
      ['Remove Last'] = 'Q',
      ['Skip'] = 'q',
      ['Exit'] = '<Esc>',

      ['Switch Mode'] = '<Tab>',

      ['Find Next'] = ']',
      ['Find Prev'] = '[',
      ['Goto Next'] = '}',
      ['Goto Prev'] = '{',
      ['Seek Next'] = '<C-f>',
      ['Seek Prev'] = '<C-b>',
      ['Skip Region'] = 'q',
      ['Remove Region'] = 'Q',
      ['Invert Direction'] = 'o',
      ['Find Operator'] = 'm',
      ['Surround'] = 'S',
      ['Replace Pattern'] = 'R',

      ['Tools Menu'] = '\\`',
      ['Show Registers'] = '\\"',
      ['Case Setting'] = '\\c',
      ['Toggle Whole Word'] = '\\w',
      ['Transpose'] = '\\t',
      ['Align'] = '\\a',
      ['Duplicate'] = '\\d',
      ['Rewrite Last Search'] = '\\r',
      ['Merge Regions'] = '\\m',
      ['Split Regions'] = '\\s',
      ['Remove Last Region'] = '\\q',
      ['Visual Subtract'] = '\\s',
      ['Case Conversion Menu'] = '\\C',
      ['Search Menu'] = '\\S',

      ['Run Normal'] = '\\z',
      ['Run Last Normal'] = '\\Z',
      ['Run Visual'] = '\\v',
      ['Run Last Visual'] = '\\V',
      ['Run Ex'] = '\\x',
      ['Run Last Ex'] = '\\X',
      ['Run Macro'] = '\\@',
      ['Align Char'] = '\\<',
      ['Align Regex'] = '\\>',
      ['Numbers'] = '\\n',
      ['Numbers Append'] = '\\N',
      ['Zero Numbers'] = '\\0n',
      ['Zero Numbers Append'] = '\\0N',
      ['Shrink'] = '\\-',
      ['Enlarge'] = '\\+',

      ['Toggle Block'] = '\\<BS>',
      ['Toggle Single Region'] = '\\<CR>',
      ['Toggle Multiline'] = '\\M',

      -- Additional
      ['Select Cursor Down'] = '<M-C-j>',
      ['Select Cursor Up'] = '<M-C-k>',

      ['Erase Regions'] = '\\gr',
    }
  end,

  keys = {
    { '<C-n>', mode = { 'n', 'x' } },
    { '\\', mode = { 'n', 'x' } },
  },
}
