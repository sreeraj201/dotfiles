return {
	{
	    'nvim-telescope/telescope.nvim', version = '*',
	    dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        cmd = "Telescope",
        keys = {
          { "<leader>ft", "<cmd>Telescope<cr>", desc = "Telescope main" },
          { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
          { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Telescope live grep" },
          { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Telescope buffers" },
          { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Telescope help tags" },
          { "<leader>fd", "<cmd>Telescope diagnostics<cr>",   desc = "Telescope diagnostics" },
          { "<leader>fw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",   desc = "Telescope dynamic workspace symbols" },
          { 
            "<leader>fl", 
            function()
              vim.diagnostic.open_float({
                scope = "line", 
                border = "rounded",
              })
            end, 
            desc = "Native current line diagnostics" 
          },
      },
      -- ADDED: The config function to handle mappings
      config = function()
        local actions = require("telescope.actions")
        
        require("telescope").setup({
          defaults = {
            mappings = {
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
        })
      end
	}
}

