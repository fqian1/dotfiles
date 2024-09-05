return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
	"nvim-treesitter/nvim-treesitter-textobjects", -- Provides more advanced text objects
	"andymass/vim-matchup", -- Enhances % matching to navigate between matching pairs
  },
  opts = {
	ensure_installed = {"c", "cpp", "rust", "go", "zig", "asm", "lua"},
	sync_install = false,
	auto_install = true,
	highlight = {
	  enable = true, -- Enables syntax highlighting using Treesitter
	  additional_vim_regex_highlighting = false, -- Disable regex highlighting, which can conflict with Treesitter
	},
	indent = {
	  enable = true, -- Enables Treesitter-based indentation
	},
	default = {
	  'class',
	  'function',
	  'method'
	},
	textobjects = {
	  select = {
		enable = true,
		lookahead = true, -- Jump forward to text objects
		keymaps = {
		  ["af"] = "@function.outer", -- Select outer part of a function
		  ["if"] = "@function.inner", -- Select inner part of a function
		  ["ac"] = "@class.outer",    -- Select outer part of a class
		  ["ic"] = "@class.inner",    -- Select inner part of a class
		  ["ap"] = "@parameter.outer", -- Select outer part of a parameter
		  ["ip"] = "@parameter.inner", -- Select inner part of a parameter
		},
	  },
	},
	matchup = {
	  enable = true,
	},
  },
  build = function(_, opts)
	require('treesitter').setup(opts)
	require("nvim-treesitter.install").update({ with_sync = true })()
  end,
}
