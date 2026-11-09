return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = { "c", "c++", "lua", "vim", "vimdoc", "query", "bash", "python", "json" },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
  },
}

