require "nvchad.autocmds"

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            timeout = 50;
        })
    end,
})
