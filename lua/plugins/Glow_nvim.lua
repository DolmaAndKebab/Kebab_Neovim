return {
	"ellisonleao/glow.nvim",
	priority = 1000,
	cmd = "Glow",
	config = function()
		require("glow").setup({})
	end
}
