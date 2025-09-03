require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "pyright", "ts_ls", "eslint" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
function _G.organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end
vim.keymap.set("n", "<leader>oi", _G.organize_imports, { noremap = true, silent = true })
vim.api.nvim_create_user_command("OrganizeImports", _G.organize_imports, { desc = "Organize Imports" })

