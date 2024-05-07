return {
	"nvim-treesitter/nvim-treesitter",
	priority=1000,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {"lua", "typescript", "javascript", "html", "css", "vim", "vimdoc", "query"},
			auto_install = true,
			
			highlight = {
			  enable = true,
			},
			
			autotag = {
			        enable = true,
			}
		})
		vim.cmd("syntax enable")
	end
}
