require "nvchad.mappings"
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

local builtin = require "telescope.builtin"
map("n", "<leader>pf", builtin.find_files, { desc = "find files" })
map("n", "<M-p>", builtin.git_files, { desc = "find git files" })

-- Harpoon keymaps
local mark = require "harpoon.mark"
local ui = require "harpoon.ui"

map("n", "<leader>a", mark.add_file)
map("n", "<A-e>", ui.toggle_quick_menu)
map("n", "<A-h>", function()
  ui.nav_file(1)
end)
map("n", "<A-t>", function()
  ui.nav_file(2)
end)
map("n", "<A-n>", function()
  ui.nav_file(3)
end)
map("n", "<A-s>", function()
  ui.nav_file(4)
end)

map({ "n", "t" }, "<A-j>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

-- Move highlighted lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("x", "p", '"_dP')

-- Copy into clipboard buffer
map("n", "<leader>y", '"+y')

-- DAP keymaps
local dap = require "dap"
map("n", "<leader>db", dap.toggle_breakpoint, {})
map("n", "<leader>dc", dap.continue, {})
map("n", "<leader>dn", dap.step_over, {})
map("n", "<leader>di", dap.step_into, {})
map("n", "<leader>do", dap.step_out, {})
map("n", "<leader>dr", dap.restart, {})
map("n", "<leader>dx", dap.terminate, {})
map("n", "<leader>?", function()
  require("dapui").eval(nil, { enter = true })
end)
