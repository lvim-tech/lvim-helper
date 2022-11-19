local config = require("lvim-helper.config")
local utils = require("lvim-helper.utils")
local notify = require("notify")
local nui_popup = require("nui.popup")
local nui_menu = require("nui.menu")
local nui_layout = require("nui.layout")

local M = {}

M.choice = nil
M.open = false
M.dir = "row"
M.file = nil
M.file_type = nil

local get_file = function(item)
	for content_line in pairs(config.content) do
		if config.content[content_line].type == "link" then
			if item == nil then
				M.file = config.content[content_line].file
				M.file_type = config.content[content_line].file_type
			elseif item ~= nil and config.content[content_line].title == item then
				M.file = config.content[content_line].file
				M.file_type = config.content[content_line].file_type
			end
		end
	end
end

local create_preview = function()
	M.lvim_popup = nui_popup({
		enter = false,
		focusable = false,
		size = {
			width = "60%",
			height = "100%",
		},
		position = "0%",
		border = {
			highlight = "LvimPopupBorder",
			style = config.border_style_preview,
			text = {
				top = "PREVIEW",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:LvimPopupNormal",
		},
	})
end

local menu_content = function()
	local menu_content = {}
	local menu_component
	menu_component = nui_menu.separator("", {
		char = " ",
	})
	table.insert(menu_content, menu_component)
	for content_line in ipairs(config.content) do
		if config.content[content_line].type == "separator" then
			menu_component = nui_menu.separator(config.content[content_line].title, {
				char = "=",
				text_align = "left",
			})
		elseif config.content[content_line].type == "link" then
			menu_component = nui_menu.item(config.content[content_line].title)
		end
		table.insert(menu_content, menu_component)
	end
	return menu_content
end

local create_menu = function()
	M.lvim_menu = nui_menu({
		position = "0%",
		size = {
			width = "100%",
			height = "100%",
		},
		border = {
			highlight = "LvimSelectBorder",
			style = config.border_style_menu,
			text = {
				top = "LVIM HELPER",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:LvimSelectNormal",
		},
	}, {
		lines = menu_content(),
		keymap = {
			close = {},
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			submit = {},
		},
		on_change = function(item)
			M.update_popup_content(item.text)
		end,
	})
	M.lvim_menu:map("n", "h", function()
		M.help()
	end, {})
	M.lvim_menu:map("n", { "<Esc>", "q", "<C-c>e", "<C-c>x", "<C-c>d" }, function()
		M.layout_hide()
	end, {})
	M.lvim_menu:map("n", "<C-d>", function()
		M.scroll(4)
	end, {})
	M.lvim_menu:map("n", "<C-u>", function()
		M.scroll(0)
	end, {})
	M.lvim_menu:map("n", "l", function()
		M.lvim_layout:hide()
		if M.dir == "col" then
			M.update_layout("row")
			M.dir = "row"
		else
			M.update_layout("col")
			M.dir = "col"
		end
		M.lvim_layout:show()
	end, {})
end

M.layout = function()
	create_preview()
	create_menu()
	M.lvim_layout = nui_layout(
		{
			relative = "editor",
			position = "50%",
			size = {
				width = "90%",
				height = "90%",
			},
		},
		nui_layout.Box({
			nui_layout.Box(M.lvim_menu, { size = "40%" }),
			nui_layout.Box(M.lvim_popup, { size = "60%" }),
		}, { dir = M.dir })
	)
	M.lvim_layout:mount()
end

M.update_popup_content = function(item)
	vim.api.nvim_buf_set_lines(M.lvim_popup.bufnr, 0, -1, true, {})
	get_file(item)
	local lines = utils.readlines(M.file)
	vim.api.nvim_buf_set_lines(M.lvim_popup.bufnr, 0, 1, true, lines)
	vim.api.nvim_buf_set_option(M.lvim_popup.bufnr, "filetype", M.file_type)
	M.scroll_top()
end

M.update_layout = function(dir)
	if M.open == true and dir == "row" then
		M.lvim_layout:update(nui_layout.Box({
			nui_layout.Box(M.lvim_menu, {
				size = {
					width = "40%",
					height = "100%",
				},
			}),
			nui_layout.Box(M.lvim_popup, {
				size = {
					width = "60%",
					height = "100%",
				},
			}),
		}, { dir = "row" }))
	elseif M.open == true then
		M.lvim_layout:update(nui_layout.Box({
			nui_layout.Box(M.lvim_popup, {
				size = {
					width = "100%",
					height = "60%",
				},
			}),
			nui_layout.Box(M.lvim_menu, {
				size = {
					width = "100%",
					height = "40%",
				},
			}),
		}, { dir = "col" }))
	end
end

M.layout_show = function()
	if M.open == false then
		M.open = true
		if M.lvim_layout then
			M.lvim_layout:show()
		else
			M.layout()
		end
		M.update_layout(M.dir)
	end
end

M.layout_hide = function()
	M.open = false
	M.lvim_layout:hide()
end

M.scroll_top = function()
	local win_id = M.lvim_popup.winid
	if win_id ~= nil then
		local buf = vim.api.nvim_win_get_buf(win_id)
		vim.api.nvim_buf_call(buf, function()
			vim.api.nvim_command("normal! zt")
		end)
	end
end

M.scroll = function(delta)
	local win_id = M.lvim_popup.winid
	if win_id ~= nil then
		local info = vim.fn.getwininfo(win_id)[1] or {}
		local top = info.topline or 1
		local buf = vim.api.nvim_win_get_buf(win_id)
		top = top + delta
		top = math.max(top, 1)
		top = math.min(top, M.win_buf_height(win_id) - info.height + 1)
		vim.defer_fn(function()
			vim.api.nvim_buf_call(buf, function()
				vim.api.nvim_command("normal! " .. top .. "zt")
				vim.cmd([[do WinScrolled]])
			end)
		end, 0)
	end
end

M.win_buf_height = function(win_id)
	local buf = vim.api.nvim_win_get_buf(win_id)
	if not vim.wo[win_id].wrap then
		return vim.api.nvim_buf_line_count(buf)
	end
	local width = vim.api.nvim_win_get_width(win_id)
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local height = 0
	for _, l in ipairs(lines) do
		height = height + math.max(1, (math.ceil(vim.fn.strwidth(l) / width)))
	end
	return height
end

M.help = function()
	notify(
		"Close: '<Esc>', 'q', '<C-c>e', '<C-c>x', '<C-c>d'\nScroll Down Preview: '<C-d>'\nScroll Up Preview: '<C-u>'\nSwitch Layout ('row' or 'col'): 'l'",
		"INFO",
		{
			title = "LVIM HELPER KEYS",
		}
	)
end

return M
