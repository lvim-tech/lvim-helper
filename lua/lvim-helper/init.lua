local config = require("lvim-helper.config")
local utils = require("lvim-helper.utils")
local actions = require("lvim-helper.actions")

local M = {}

function M.setup(user_config)
	utils.merge(config, user_config)
	vim.api.nvim_create_user_command("LvimHelper", "lua require'lvim-helper.actions'.layout_show()", {})
	local group = vim.api.nvim_create_augroup("LvimHelper", {
		clear = true,
	})
	vim.api.nvim_create_autocmd({
		"VimResized",
	}, {
		callback = function()
			vim.schedule(function()
				actions.update_layout(actions.dir)
			end)
		end,
		group = group,
	})
end

return M
