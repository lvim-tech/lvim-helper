local api = vim.api
local settings = require 'lvim-helper.settings'

local M = {}

function M.merge(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == "table") and (type(t1[k] or false) == "table") then
            M.merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end
    return t1
end

function M.file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function M.lines_from(file)
    for line in io.lines(file) do
        print(line) --
    end
end

function M.assert_string(n, val)
    return M.assert_arg(n, val, 'string', nil, nil, 3)
end

function M.assert_arg(n, val, tp, verify, msg, lev)
    if type(val) ~= tp then
        error(("argument %d expected a '%s', got a '%s'"):format(n, tp,
                                                                 type(val)),
              lev or 2)
    end
    if verify and not verify(val) then
        error(("argument %d: '%s' %s"):format(n, val, msg), lev or 2)
    end
    return val
end

function M.readlines(filename)
    M.assert_string(1, filename)
    local f, err = io.open(filename, 'r')
    if not f then return raise(err) end
    local res = {}
    for line in f:lines() do table.insert(res, line) end
    f:close()
    return res
end

function M.size_of_table_files()
    size = 0
    for _ in pairs(settings.settings.files) do size = size + 1 end
    return size
end

-- function is_file_in_table(file)
--     for i, v in ipairs(files) do if v == file then return true end end
-- end

-- function M.set_files(add_files)
--     for _, file in ipairs(add_files) do
--         if not is_file_in_table(file) then table.insert(files, file) end
--     end
-- end

return M
