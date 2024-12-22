------------- UTILS ----------
local M = {}

---@class TermConfig
---@field direction "new" | "vnew" | "tabnew"
---@field cmd string
---@field new? boolean
---@field focus boolean
---@param opts TermConfig
function M.term(opts, ...)
  local terminal = vim.iter(vim.fn.getwininfo()):find(function(v)
    return v.terminal == 1
  end)
  if terminal and not opts.new then
    vim.api.nvim_buf_call(terminal.bufnr, function()
      vim.cmd '$'
    end)
    return vim.api.nvim_chan_send(vim.bo[terminal.bufnr].channel, string.format(opts.cmd .. '\n', ...))
  end

  local current_win = vim.api.nvim_get_current_win()
  local size = math.floor(vim.api.nvim_win_get_height(0) / 3)
  vim.cmd[opts.direction] { range = opts.direction == 'new' and { size } or { nil } }
  local term = vim.fn.termopen(vim.env.SHELL) --[[@as number]]
  if not opts.focus then
    vim.cmd.stopinsert()
    vim.api.nvim_set_current_win(current_win)
  end
  vim.api.nvim_chan_send(term, string.format(opts.cmd .. '\n', ...))
end

---@param fn function
---@param dir? string
function M.wrap_lcd(fn, dir)
  local current_cwd = vim.uv.cwd()
  local _dir = dir or vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  vim.cmd.lcd { args = { _dir }, mods = { silent = true } }
  local ret = fn()
  vim.cmd.lcd { args = { current_cwd }, mods = { silent = true } }
  return ret
end

return M
