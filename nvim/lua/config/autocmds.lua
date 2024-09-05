vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
	vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
  pattern = "*",
  command = "%s/\\s\\+$//e"
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = vim.api.nvim_create_augroup("AutoReload", { clear = true }),
  command = "checktime"
})

vim.api.nvim_create_autocmd("FocusLost", {
  group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
  pattern = "*",
  command = "silent! wa"
})

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("ResizeSplits", { clear = true }),
  command = "tabdo wincmd ="
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("LastEditPosition", { clear = true }),
  pattern = "*",
  callback = function()
	local line = vim.fn.line
	local col = vim.fn.col
	if line("'\"") > 1 and line("'\"") <= line("$") then
	  vim.api.nvim_exec("normal! g'\"", false)
	end
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.lua",
  callback = function()
	vim.opt.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*",
  callback = function()
	if vim.bo.filetype ~= "lua" then
	  vim.opt.shiftwidth = 4
	end
  end,
})

vim.api.nvim_create_autocmd({ "TextChanged" }, {
  callback = function()
	require("lint").try_lint()
  end,
})
