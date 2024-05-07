return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"folke/neodev.nvim",
		"pmizio/typescript-tools.nvim",
		"b0o/SchemaStore.nvim",
		"sigmaSd/deno-nvim",
		"roobert/tailwindcss-colorizer-cmp.nvim",
	},
	priority = 1000,
	lazy = false,
	config = function()
		-- Setting up CMP
		local cmp = require("cmp")

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- Setting up CMP Autopair
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- Setting up Vs code like snippets from Luasnip
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Setting up Mason Nvim
		require("mason").setup()

		-- Setting up Mason-lspconfig Nvim
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "tsserver", "html", "cssls", "jsonls", "yamlls", "denols" },
		})

		-- Setting up LSP Servers with lspconfig Nvim
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspconfig = require("lspconfig")

		-- Extra Plugins for LSP
		require("neodev").setup({})
		require("typescript-tools").setup({})
		require("lspconfig").jsonls.setup({
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
		require("lspconfig").yamlls.setup({
			settings = {
				yaml = {
					schemaStore = {
						enable = false,
						url = "",
					},
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		})
		require("deno-nvim").setup({})

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		-- Tailwind CSS Completion
		require("tailwindcss-colorizer-cmp").setup({
			color_square_width = 2,
		})

		require("cmp").config.formatting = {
			format = require("tailwindcss-colorizer-cmp").formatter,
		}

		lspconfig.tsserver.setup({ capabilities = capabilities })
		lspconfig.html.setup({ capabilities = capabilities })
		lspconfig.cssls.setup({ capabilities = capabilities })
		lspconfig.jsonls.setup({ capabilities = capabilities })
		lspconfig.yamlls.setup({ capabilities = capabilities })
		lspconfig.denols.setup({ capabilities = capabilities })

		-- Setting up Lsp keybinds

		vim.keymap.set("n", "<C-x>", vim.lsp.buf.hover, {})
		vim.keymap.set("n", "<space>x", vim.lsp.buf.definition, {})
		vim.keymap.set({ "n", "v" }, "<C-c>", vim.lsp.buf.code_action, {})
	end,
}
