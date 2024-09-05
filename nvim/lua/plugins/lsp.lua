return {
  {
	"williamboman/mason.nvim",
	opts = {}
  },
  {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim" },
	opts = {
	  ensure_installed = { "lua_ls", "rust_analyzer", "cpptools" }
	}
  },
  {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
	  "williamboman/mason-lspconfig.nvim",
	},
	config = function()
	  local lspconfig = require("lspconfig")

	  lspconfig.lua_ls.setup({ })
	  lspconfig.rust_analyzer.setup({ })
	end
  }
}

