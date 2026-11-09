return {
    { 
        "ellisonleao/gruvbox.nvim", priority = 1000 , config = true,
          config = function()
            require("gruvbox").setup({
              contrast = "hard",
              palette_overrides = {
                dark0_hard = "#000000",
                -- dark0_hard = "#161616",
              },
            })
            vim.o.background = "dark"
            vim.cmd([[colorscheme gruvbox]])
          end,
    }
}
