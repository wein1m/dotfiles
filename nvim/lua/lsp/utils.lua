local tag_state = session.state.tags
local diagnostics_state = session.state.ui.diagnostics_state

-- {{{ utils
-- pos in range
local function in_range(pos, range)
  if pos[1] < range['start'].line or pos[1] > range['end'].line then
    return false
  end

  if (pos[1] == range['start'].line and pos[2] < range['start'].character) or
      (pos[1] == range['end'].line and pos[2] > range['end'].character) then
    return false
  end

  return true
end

-- {{{ tag_state api
-- clear buffer tags and context cache
local function clear_buffer_tags(bufnr)
  -- equivalent to removing buffer entry from cache to end tracking
  tag_state.context[bufnr] = nil
  tag_state.cache[bufnr] = nil
  tag_state.req_state[bufnr] = nil
end

-- calculate and update context at current location using latest cache
local function update_context()
  local bufnr = vim.api.nvim_get_current_buf()
  local symbols = tag_state.cache[bufnr]
  if not symbols or vim.tbl_isempty(symbols) then return end

  local hovered_line = vim.api.nvim_win_get_cursor(0)
  local contexts = {}

  -- go through all symbols in this buffer
  for index = #symbols, 1, -1 do
    local current = symbols[index]

    if current.range and in_range(hovered_line, current.range) then
      table.insert(contexts, {
        kind = current.kind,
        name = current.name,
        detail = current.detail,
        range = current.range,
      })
    end
  end

  if not vim.tbl_isempty(contexts) then
    -- sort based on ascending tag end locations
    table.sort(contexts, function(a, b)
      return (a.range['end'].line > b.range['end'].line) or
          (b.range['end'].character > b.range['end'].character)
    end)

    tag_state.context[bufnr] = contexts
    return
  end

  -- no context found
  tag_state.context[bufnr] = nil
end

-- get current context with formatting
-- format_fn(context) can format as context needed
local function get_context(bufnr, format_fn)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  format_fn = format_fn or (function(context) return context end)

  if tag_state.context[bufnr] == nil then return format_fn({}) end
  return format_fn(tag_state.context[bufnr])
end

-- toggle global(workspace) / local(buffer) diagnostics qflist
-- powered by diagnostics api, does not depend on lsp directly
local function toggle_diagnostics_list(global)
  if global then
    if not diagnostics_state['global'] then
      if #vim.diagnostic.get(nil) > 0 then
        vim.diagnostic.setqflist()
        diagnostics_state['global'] = true

        require('statusline').set_statusline_func('Workspace Diagnostics')()
        vim.cmd [[ wincmd p ]]
      end
    else
      diagnostics_state['global'] = false
      vim.cmd [[ cclose ]]
    end
  else
    local current_buf = vim.api.nvim_get_current_buf()

    if not diagnostics_state['local'][current_buf] then
      if #vim.diagnostic.get(0) > 0 then
        vim.diagnostic.setloclist()
        diagnostics_state['local'][current_buf] = true

        require('statusline').set_statusline_func('Diagnostics')()
        vim.cmd [[ wincmd p ]]
      end
    else
      diagnostics_state['local'][current_buf] = false
      vim.cmd [[ lclose ]]
    end
  end
end

return {
  -- misc
  get_context             = get_context,
  toggle_diagnostics_list = toggle_diagnostics_list,

  -- context tag_state api
  update_context          = update_context,
  clear_buffer_tags       = clear_buffer_tags,
}
