local opt = vim.opt

-- Line numbers
opt.number = true          -- Show absolute line number for the current line

-- Tabs & Indentation
opt.tabstop = 4            -- Number of spaces a tab counts for
opt.shiftwidth = 4         -- Number of spaces use for autoindent
opt.expandtab = true       -- Convert tabs to spaces
opt.smartindent = true     -- Insert indents automatically

vim.o.exrc = true

require("config.lazy")

-- Background colorscheme
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- Exit terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-N>]], { desc = 'Exit terminal mode' })

-- 1. Extend the baseline clangd configuration (Optional, only if adding settings/args)
vim.lsp.config('clangd', {
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  -- root_markers tell Neovim when to consider a folder a project workspace
  root_markers = { ".git", "compile_commands.json", "compile_flags.txt" }, 
})
-- 2. Enable it so Neovim auto-attaches whenever you open a C/C++ file
vim.lsp.enable('clangd')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { buffer = event.buf }
    
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})

-- Netrw explorer
vim.g.netrw_liststyle = 3 -- Tree mode
vim.g.netrw_winsize = 20 -- Makes the window take 20% of the screen width
vim.g.netrw_altv = 1     -- Opens split to the left
vim.keymap.set('n', '<leader>e', ':Lex<CR>', { silent = true })

-- -- Simple autocomplete
-- vim.o.complete = ".,o" -- use buffer and omnifunc
-- vim.o.completeopt = "fuzzy,menuone,noselect" -- add 'popup' for docs (sometimes)
-- vim.o.autocomplete = true
-- vim.o.pumheight = 7
--
-- vim.lsp.enable({ "mylangservers" })
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(ev)
--     vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
--       -- Optional formating of items
--       convert = function(item)
--         -- Remove leading misc chars for abbr name,
--         -- and cap field to 25 chars
--         --local abbr = item.label
--         --abbr = abbr:match("[%w_.]+.*") or abbr
--         --abbr = #abbr > 25 and abbr:sub(1, 24) .. "…" or abbr
--         --
--         -- Remove return value
--         --local menu = ""
--
--         -- Only show abbr name, remove leading misc chars (bullets etc.),
--         -- and cap field to 15 chars
--         local abbr = item.label
--         abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
--         abbr = abbr:match("[%w_.]+.*") or abbr
--         abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr
--
--         -- Cap return value field to 15 chars
--         local menu = item.detail or ""
--         menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu
--
--         return { abbr = abbr, menu = menu }
--       end,
--     })
--   end,
-- })
