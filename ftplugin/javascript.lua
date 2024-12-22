vim.b.minioperators_config = {
  evaluate = {
    func = function(content)
      local lastLine = table.remove(content.lines)
      local lines = table.concat(content.lines, '\n')
      lines = lines .. '; console.log(' .. lastLine .. ')'
      local jsCmd = "eval('" .. lines:gsub("'", "\\'") .. "')"
      local shellCmd = 'node -e "' .. jsCmd:gsub('"', '\\"') .. '"'
      local result = vim.fn.system(shellCmd):gsub('\n$', '')
      return result
    end,
  },
}
