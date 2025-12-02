return {
  "nvim-mini/mini.nvim",
  version = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local MiniFiles = require("mini.files")

    MiniFiles.setup({
      windows = { preview = true, width_preview = 60 },
    })

    vim.keymap.set("n", "<leader>er", function()
      local buf_name = vim.api.nvim_buf_get_name(0)
      local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
      MiniFiles.open(path)
      MiniFiles.reveal_cwd()
    end, {})
  end,
}


-- MiniFiles.setup({
-- windows = { preview = true },
-- mappings = { close = 'q' }
-- })
