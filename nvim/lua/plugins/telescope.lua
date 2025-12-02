return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.1.9',
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find Files~" })
    vim.keymap.set("n", "<C-o>", builtin.live_grep, {})
  end,
}
