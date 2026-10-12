-- Bazel configuration via pesto.nvim
--
-- See `:h pesto`

local pesto = require('pesto')
pesto.setup({
    cli_completion = {
        mode = 'lua', -- Use Lua completion to avoid missing bash completion script on macOS
    },
    errorformats = {
        {
            action_mnemonic = 'CppCompile',
            compiler = 'clang',
            strip_escape_codes = true, -- Strips ANSI escape codes from Apple Clang / xcrun
        },
    },
})

-- Keymaps for Bazel workflows
vim.keymap.set('n', '<leader>pb', '<cmd>Pesto build<CR>', { desc = 'Bazel build package' })
vim.keymap.set('n', '<leader>pt', '<cmd>Pesto test<CR>', { desc = 'Bazel test package' })
vim.keymap.set('n', '<leader>pc', '<cmd>Pesto compile-one-dep<CR>', { desc = 'Bazel compile current file' })
vim.keymap.set('n', '<leader>ps', '<cmd>Pesto sp-build<CR>', { desc = 'Open BUILD file (split)' })
vim.keymap.set('n', '<leader>pv', '<cmd>Pesto vs-build<CR>', { desc = 'Open BUILD file (vsplit)' })
vim.keymap.set('n', '<leader>py', '<cmd>Pesto yank-package-label<CR>', { desc = 'Yank Bazel package label' })
