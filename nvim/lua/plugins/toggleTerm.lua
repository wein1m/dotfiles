return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    border = "curved",
    direction = "float",
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "n",
        "q",
        "<cmd>close<CR>",
        { noremap = true, silent = true }
      )
    end,
    on_close = function(term)
      vim.cmd("startinsert!")
    end,
  },
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    })

    ---------------------------------------------------
    --          🐰 Custom Open Terminal 🐰           --
    ---------------------------------------------------
    local Terminal = require("toggleterm.terminal").Terminal

    local function TerminalAction(cmd)
      local term = Terminal:new({
        cmd = cmd,
        direction = "float",
      })

      return function()
        term:toggle()
      end
    end

    _G.pwshToggle = TerminalAction("pwsh")
    _G.btopToggle = TerminalAction("btop")

    local function setKeymaps(func, keymap)
      return vim.api.nvim_set_keymap(
        "n",
        keymap,
        "<cmd>lua " .. func .. "Toggle()<CR>",
        { noremap = true, silent = true }
      )
    end

    setKeymaps("pwsh", "<A-;>");
    setKeymaps("btop", "<leader>b")
  end,
}

