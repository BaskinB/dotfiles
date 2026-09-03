-- Add plugin with vim.pack
vim.pack.add { 'https://github.com/nvimdev/dashboard-nvim' }
-- Define our logo
local logo = [[





███████╗██╗      ██████╗ ████████╗██╗  ██╗██╗   ██╗ ██████╗ ██████╗ ██████╗ ███████╗
██╔════╝██║     ██╔═══██╗╚══██╔══╝██║  ██║╚██╗ ██╔╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
███████╗██║     ██║   ██║   ██║   ███████║ ╚████╔╝ ██║     ██║   ██║██║  ██║█████╗  
╚════██║██║     ██║   ██║   ██║   ██╔══██║  ╚██╔╝  ██║     ██║   ██║██║  ██║██╔══╝  
███████║███████╗╚██████╔╝   ██║   ██║  ██║   ██║   ╚██████╗╚██████╔╝██████╔╝███████╗
╚══════╝╚══════╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝





]]

-- Configure the Dashboard plugin
require('dashboard').setup({
	theme = "doom",
	hide = {
		statusline = false,
	},
	config = {
		header = vim.split(logo, "\n"),
		center = {
			{
				action = 'lua require("telescope.builtin").find_files()',
				desc = " Find File",
				icon = " ",
				key = "f",
			},
			{ action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
			{
				action = 'lua require("telescope.builtin").oldfiles()',
				desc = " Recent Files",
				icon = " ",
				key = "r",
			},
			{
				action = 'lua require("telescope.builtin").live_grep()',
				desc = " Find Text",
				icon = " ",
				key = "g",
			},
			
			{
				action = function()
					vim.api.nvim_input("<cmd>qa<cr>")
				end,
				desc = " Quit",
				icon = " ",
				key = "q",
			},
		},
		footer = function()
			local stats = #vim.pack.get()
			return { "⚡ Neovim loaded " .. stats .. " plugins" }
		end,
	},
})
