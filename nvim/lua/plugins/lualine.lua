local bo = vim.bo
local fn = vim.fn

local function selectionCount()
  local isVisualMode = fn.mode():find("[Vv]")
  if not isVisualMode then return "" end
  local starts = fn.line("v")
  local ends = fn.line(".")
  local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
  return " " .. tostring(lines) .. "L " .. tostring(fn.wordcount().visual_chars) .. "C"
end

local function clock()
  if vim.opt.columns:get() < 110 or vim.opt.lines:get() < 25 then return "" end

  local time = tostring(os.date()):sub(12, 16)
  if os.time() % 2 == 1 then time = time:gsub(":", " ") end -- make the `:` blink
  return time
end

--------------------------------------------------------------------------------

local bottomSeparators = { left = "", right = "" }
local topSeparators = { left = "", right = "" }
local emptySeparators = { left = "", right = "" }

local lualineConfig = {
  sections = {
    lualine_x = { clock },
    lualine_y = { 'filetype' },
    lualine_z = {
      { selectionCount, padding = { left = 0, right = 1 } },
      "location",
    },
  },
  options = {
    refresh = { statusline = 1000 },
    ignore_focus = {
      "DressingInput",
      "DressingSelect",
      "ccc-ui",
    },
    globalstatus = true,
    component_separators = { left = "", right = "" },
    section_separators = bottomSeparators,
  },
}

--------------------------------------------------------------------------------

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = lualineConfig
}
