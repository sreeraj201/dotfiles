return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", 
  opts = {
    indent = {
      char = "│", -- Change your indent character here
    },
    scope = {
      enabled = true, -- Highlights the current scope/code block
    },

  },
  keys = {
    {
      "<leader>ug",
      "<cmd>IBLToggle<cr>",
      desc = "Toggle Indent Blankline",
    },
  },
}

