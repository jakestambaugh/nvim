-- Telescope

local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_mru = true,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer, -- Insert mode
        },
        n = {
          ["dd"] = require("telescope.actions").delete_buffer,    -- Normal mode
        },
      },
    },
  },
})

telescope.load_extension("jj")
vim.keymap.set('n', '<leader><leader>', function()
    require('telescope.builtin').find_files({ hidden = true})
end, { desc = 'Find files (including hidden)'})

vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep (Ripgrep)' })
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>jj', telescope.extensions.jj.diff, {})
vim.keymap.set('n', 'gr', builtin.lsp_references, {})

-- Use the quickfix list
-- Send workspace diagnostics to quickfix list and open the window
vim.keymap.set('n', '<leader>q', function()
    vim.diagnostic.setqflist({ open = false, })
    builtin.quickfix()
end, { desc = 'LSP to Quickfix' })

-- Open and close the quickfix window manually if needed
vim.keymap.set('n', '<leader>co', builtin.quickfix, { desc = 'Open Quickfix' })
vim.keymap.set('n', '<leader>cc', '<cmd>cclose<CR>', { desc = 'Close Quickfix' })
