return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "c", "cpp", "c_sharp", "asm", "bash", "cmake", "comment", "dockerfile", "javascript", "lua", "markdown", "markdown_inline", "powershell", "python", "regex" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
 end,
}
