return {
	"nvimtools/none-ls.nvim",

	-- Building dependencies
	-- Linux & mac os requires sudo!
	build = {
		"npm install -g eslint_d",
		"npm install -g prettier",
		"npm install -g @johnnymorganz/stylua",
		"npm install -g jq",
	},

	-- Neovim dependencies
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.completion.spell,
				require("none-ls.diagnostics.eslint_d"),
				require("none-ls.formatting.jq"),
				require("none-ls.code_actions.eslint_d"),
				null_ls.builtins.formatting.prettier,
			},
		})

		-- Setting format keybind
		vim.keymap.set("n", "<space>c", vim.lsp.buf.format, {})
	end,
}
