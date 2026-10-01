-- PLUGINS
--
-- See `:h :packadd`, `:h vim.pack`

-- Add the "nohlsearch" package to automatically disable search highlighting after
-- 'updatetime' and when going to insert mode.
vim.cmd('packadd! nohlsearch')

-- Install third-party plugins via "vim.pack.add()".
vim.pack.add({
    -- Quickstart configs for LSP
    'https://github.com/neovim/nvim-lspconfig',
    -- Fuzzy picker
    'https://github.com/ibhagwan/fzf-lua',
    -- Autocompletion
    'https://github.com/nvim-mini/mini.completion',
    -- Enhanced quickfix/loclist
    'https://github.com/stevearc/quicker.nvim',
    -- Git integration
    'https://github.com/lewis6991/gitsigns.nvim',
    -- JJ integration
    'https://github.com/evanphx/jjsigns.nvim',
    -- Telescope (and Plenary)
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/zschreur/telescope-jj.nvim',
})

require('fzf-lua').setup { fzf_colors = true }
require('mini.completion').setup {}
require('quicker').setup {}
require('gitsigns').setup {}
