vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move lines up and down 
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Comments
vim.api.nvim_set_keymap("n", "<C-/>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-/>", "gcc", { noremap = false })

-- Ident
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste over text without losing content of the register 
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])


vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
--vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Debugger
vim.keymap.set('n', '<F8>', "<cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true})
vim.keymap.set('n', '<F5>', "<cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true})
vim.keymap.set('n', '<F6>', "<cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true})
vim.keymap.set('n', '<F7>', "<cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true})
-- -- Python
vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true})
vim.keymap.set("n", "<leader>dpr", "<cmd>lua require('dap-python').test_method()<CR>", { noremap = true, silent = true})
vim.keymap.set("n", "<leader>dprc", "<cmd>lua require('dap-python').test_class()<CR>", { noremap = true, silent = true})
vim.keymap.set("v", "<leader>dps", "<cmd <ESC>:lua require('dap-python').debug_selection()<CR>", { noremap = true, silent = true})
-- -- Go
vim.keymap.set("n", "<leader>dgr", "<cmd>lua require('dap').continue()<CR>", { noremap = true, silent = true})
vim.keymap.set("n", "<leader>dgt", "<cmd>lua require('dap-go').debug_test()<CR>", { noremap = true, silent = true})
