vim.o.number = true
vim.o.wrap = false
vim.o.swapfile = false

-- usr_30.txt in the vim help explains tabbing
vim.o.shiftwidth = 4
vim.o.softtabstop = -1
vim.o.expandtab = true
vim.o.signcolumn = "yes"

-- aesthetics
vim.o.winborder = "rounded"

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>r', ':restart<CR>')
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

vim.keymap.set('n', '<leader>1', ':edit $HOME/.config/nvim/init.lua<CR>')

vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.lsp.enable({ "lua_ls", "rust_analyzer"})
