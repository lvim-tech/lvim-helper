local config = require("lvim-helper.config")

local M = {}

M.merge = function(t1, t2)
	for k, v in pairs(t2) do
		if (type(v) == "table") and (type(t1[k] or false) == "table") then
			if M.is_array(t1[k]) then
				t1[k] = M.concat(t1[k], v)
			else
				M.merge(t1[k], t2[k])
			end
		else
			t1[k] = v
		end
	end
	return t1
end

M.concat = function(t1, t2)
	for i = 1, #t2 do
		table.insert(t1, t2[i])
	end
	return t1
end

M.is_array = function(t)
	local i = 0
	for _ in pairs(t) do
		i = i + 1
		if t[i] == nil then
			return false
		end
	end
	return true
end

function M.assert_string(n, val)
	return M.assert_arg(n, val, "string", nil, nil, 3)
end

function M.assert_arg(n, val, tp, verify, msg, lev)
	if type(val) ~= tp then
		error(("argument %d expected a '%s', got a '%s'"):format(n, tp, type(val)), lev or 2)
	end
	if verify and not verify(val) then
		error(("argument %d: '%s' %s"):format(n, val, msg), lev or 2)
	end
	return val
end

function M.readlines(file)
	M.assert_string(1, file)
	local f = io.open(file, "r")
	local res = {}
	if f ~= nil then
		for line in f:lines() do
			table.insert(res, line)
		end
		f:close()
	else
		table.insert(res, "File not exists!")
	end
	return res
end

return M
