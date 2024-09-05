return {
  "mfussenegger/nvim-lint",
  event = "BufWritePost", -- Trigger linter on file save
  config = function()
    local lint = require("lint")

    -- Set up linters by filetype
    lint.linters_by_ft = {
      rust = { "clippy" }, -- For Rust
      lua = { "luacheck" } -- For Lua
    }

    -- Automatically lint on save
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
