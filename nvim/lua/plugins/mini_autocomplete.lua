return {
    {
      "nvim-mini/mini.completion",
      version = "*",
      config = function()
        require('mini.completion').setup()
      end,
    }
}
