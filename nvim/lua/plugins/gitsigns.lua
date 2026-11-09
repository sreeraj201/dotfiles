return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      
      -- Keymaps
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation between hunks
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end, { desc = "Next Git Hunk" })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end, { desc = "Previous Git Hunk" })

        -- Actions
        map('n', '<leader>gp', gitsigns.preview_hunk_inline, { desc = "Preview Hunk" })
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = "Stage Hunk" })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = "Reset Hunk" })
        map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map('v', '<leader>gs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage Selected Hunk" })
        map('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset Selected Hunk" })
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = "Stage Buffer" })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = "Reset Buffer" })
        map('n', '<leader>gb', gitsigns.blame, { desc = "Blame (Full)" })
        map('n', '<leader>gd', gitsigns.diffthis, { desc = "Diff This" })
        map('n', '<leader>gD', function() gitsigns.diffthis('~') end, { desc = "Diff This (~)" })

        -- Text object for hunks (e.g. `ih` for "inner hunk")
        map({'o', 'x'}, 'ih', ':<C-u>Gitsigns select_hunk<CR>', { desc = "Select Hunk" })
      end
    }
  }
}

