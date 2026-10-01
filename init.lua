require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.commands')

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

-- LSP
--
-- see `:h lsp`
--
-- Uses the pre-made configs from github.com/neovim/nvim-lspconfig

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('gopls')

-- use lua_ls for neovim
vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using (most
                -- likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
                    vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
                },
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                -- library = vim.api.nvim_get_runtime_file('', true),
            },
        })
    end,
    settings = {
        Lua = {},
    },
})

-- LSPs
vim.lsp.enable('lua_ls')

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

-- Telescope

local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.load_extension("jj")
vim.keymap.set('n', '<leader><leader>', function()
    require('telescope.builtin').find_files({ hidden = true})
end, { desc = 'Find files (including hidden)'})
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
