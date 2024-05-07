return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-g>", builtin.find_files, {})
		vim.keymap.set("n", "<C-g>w", builtin.live_grep, {})
		vim.keymap.set("n", "<C-g>s", builtin.buffers, {})
		vim.keymap.set("n", "<C-g>v", builtin.help_tags, {})

		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		require("telescope").load_extension("ui-select")
	end,
}
