---
--- Generated by dreammo(https://github.com/dream-mo/lua-php)
--- Created by dreammo.
--- DateTime: 2019/10/25 11:20 下午

local JSON = require("json")

local M = {}

---
---file_get_contents
---获取文件内容
--- @param path string
--- @return string
function M.file_get_contents(path)
    if not path then
        error("file path is required")
    end
    local file = io.open(path)
    str = file:read("*a")
    file:close()
    return str
end

---
---file_put_contents
---写文件
--- @param path string
--- @param content string
--- @param append string
--- @return nil
function M.file_put_contents(path, content, append)
    if not path then
        error("file path is required")
    end
    content = content or ""
    local mode = "w"
    if append then
        mode = "a+"
    end
    local file = io.open(path, mode)
    file:write(content)
    file:close()
end

---unlink
--- @param file string
---
function M.unlink(file_path)
    return os.remove(file_path)
end

---
---touch
--- @param file_path string
--- @return boolean
function M.touch(file_path)
    local file = io.open(file_path, "w")
    file:close()
    return true
end

---
---time
---获取当前时间戳
--- @return number
function M.time()
    return os.time()
end

---
---date
---格式化日期
--- @param format string
--- @param time number
--- @return string
function M.date(format, time)
    format = format or "%Y-%y-%d %H:%M:%S"
    if time then
        if type(time) ~= 'number' then
            error("time param must be number type")
        else
            return os.date(format, time)
        end
    else
        return os.date(format)
    end
end

---
---strlen
--- @param str string
--- @return number
function M.strlen(str)
    return utf8.len(str)
end

---
---md5
---获取内容md5摘要
--- @param content string
--- @return string
function M.md5(content)
    local md5 = require("md5")
    if not md5 then
        error("please install md5 module,use `luarocks install md5`")
    else
        return md5.sumhexa(content)
    end
end

---
---is_string
--- @param val any
--- @return boolean
function M.is_string(val)
    if type(val) == 'string' then
        return true
    else
        return false
    end
end

---
---is_number
--- @param val any
--- @return boolean
function M.is_number(val)
    if type(val) == 'number' then
        return true
    else
        return false
    end
end

---
---is_bool
--- @param val any
--- @return boolean
function M.is_bool(val)
    if type(val) == 'boolean' then
        return true
    else
        return false
    end
end

---
---is_nil
--- @param val any
--- @return boolean
function M.is_nil(val)
    if type(val) == 'nil' then
        return true
    else
        return false
    end
end
---
---is_table
--- @param val any
--- @return boolean
function M.is_table(val)
    if type(val) == 'table' then
        return true
    else
        return false
    end
end

---
---is_array
--- @param val any
--- @return boolean
function M.is_array(val)
    return M.is_table(val)
end

---
---boolval
--- @param val any
--- @return boolean
function M.boolval(val)
    local v = false
    if v then
        v = true
    end
    return v
end

---
---boolval
--- @param val any
--- @return boolean
function M.strval(val)
    return string.tostring(val)
end

---
---boolval
--- @param val number
--- @return boolean
function M.intval(val)
    return math.floor(val)
end

---
---die
--- @param val any
function M.die(val)
    if M.is_number(val) then
        os.exit(val)
    elseif M.is_string(val) then
        print(val)
        os.exit()
    else
        os.exit()
    end
end

---
--- @param val any
--- @return string
---
local function var_dump_str(val)
    local str = ''
    if M.is_string(val) then
        str = string.format('string(%d)"' .. val .. '"', utf8.len(val))
    elseif M.is_number(val) then
        str = string.format('number(%d)', val)
    elseif M.is_bool(val) then
        str = string.format('boolean(%s)', tostring(val))
    elseif M.is_table(val) or M.is_array(val) then
        local prefix = 'table(%d){\n'
        local i = 0
        for k, v in pairs(val) do
            if M.is_number(k) then
                str = str .. string.format('  [' .. k .. ']=>\n')
            elseif M.is_string(k) then
                str = str .. string.format('  ["' .. k .. '"]=>\n')
            end

            if M.is_table(v) then
                local j = 0
                for _, v2 in pairs(v) do
                    j = j + 1
                end
                str = str .. '  ' .. 'table' .. string.format("(%d)", j) .. '{...}' .. '\n'
            else
                str = str .. '  ' .. var_dump_str(v) .. '\n'
            end

            i = i + 1
        end
        str = string.format(prefix .. str .. '}', i)
    end
    return str
end

---
---var_dump
--- @param ... any
function M.var_dump(...)
    for _,val in pairs({...}) do
        print(var_dump_str(val))
    end
end

---
---var_export
--- @param val any
--- @return string
function M.var_export(val)
    return var_dump_str(val)
end

---
---implode
--- @param flag string
--- @param tb table
--- @return string
function M.implode(flag, tb)
    flag = flag or ""
    return table.concat(tb, flag)
end

---
---str_split
--- @param str string
--- @param len number
--- @return table
---
function M.str_split(str, len)
    str = str or ""
    local tb = {}
    if str == "" then
        return tb
    else
        len = len or 1
        local i = 1
        local step = len - 1
        while (i <= string.len(str)) do
            table.insert(tb, string.sub(str, i, i + step))
            i = i + step + 1
        end
        return tb
    end
end

---
---count
--- @param tb table
--- @return number
function M.count(tb)
    tb = tb or {}
    local i = 0
    for _, v in pairs(tb) do
        i = i + 1
    end
    return i
end

--- explode str to table
local explode_tb = {}
local function explode(tb, flag)
    local function add(res_tb, origin_tb, str, index, i)
        table.insert(res_tb, str)
        table.insert(index, i)
        for _, v2 in pairs(index) do
            origin_tb[v2] = nil
        end
    end

    if PHP.count(tb) ~= 0 then
        local str = ''
        local index = {}
        for i, v in pairs(tb) do
            if v == flag then
                add(explode_tb, tb, str, index, i)
                explode(tb, flag)
            else
                str = str .. v
                table.insert(index, i)
                if not tb[i + 1] then
                    add(explode_tb, tb, str, index, i)
                end
            end
        end
    end
end

---
---explode
--- @param str string
--- @param flag string
function M.explode(str, flag)
    flag = flag or ''
    explode(M.str_split(str), flag)
    return explode_tb
end

---
---ord
--- @param char string
--- @return number
function M.ord(char)
    return string.byte(char)
end

---
---char
--- @param char_code number
--- @return string
function M.chr(char_code)
    return string.char(char_code)
end

---
---md5_file
--- @param file string
--- @return string
function M.md5_file(file)
    local content = M.file_get_contents(file)
    return M.md5(content)
end

---
---str_repeat
--- @param str string
--- @param times number
--- @return string
function M.str_repeat(str, times)
    times = times or 0
    return string.rep(str, times)
end

---
---str_replace
--- @param find string
--- @param replace string
--- @param str string
--- @return string
function M.str_replace(find, replace, str)
    local res_str = string.gsub(str, find, replace)
    return res_str
end

---
---strpos
--- @param str string
--- @param find string
--- @return number
function M.strpos(str, find)
    local start_idx = string.find(str, find)
    return start_idx
end

---
---strtoupper
--- @param str string
--- @return string
function M.strtoupper(str)
    return string.upper(str)
end

---
---strtolower
--- @param str string
--- @return string
function M.strtolower(str)
    return string.lower(str)
end

---
---strrev
--- @param str string
--- @return string
function M.strrev(str)
    return string.reverse(str)
end

---
---substr
--- @param str string
--- @param start_idx string
--- @param end_idx string
--- @return string
function M.substr(str, start_idx, end_idx)
    return string.sub(str, start_idx, end_idx)
end

---
---sprintf
--- @param format string
--- @param ... any
--- @return string
function M.sprintf(format, ...)
    return string.format(format, table.unpack({ ... }))
end

---
---printf
--- @param format string
--- @param ... any
--- @return nil
function M.printf(format, ...)
    local res_str = M.sprintf(format, table.unpack({ ... }))
    print(res_str)
end

---
---ltrim
--- @param str string
--- @param flag string
--- @return string
local function base_trim(str, flag, all)
    all = all or false
    flag = flag or ""
    if flag == "" then
        return str
    else
        local tb = M.str_split(str)
        for i, v in ipairs(tb) do
            if all then
                if (v == flag) then
                    tb[i] = nil
                end
            else
                if (v == flag) then
                    tb[i] = nil
                else
                    break
                end
            end
        end
        local tmp_tb = {}
        for _, t_v in pairs(tb) do
            table.insert(tmp_tb, t_v)
        end
        return table.concat(tmp_tb)
    end
end
---
---ltrim
--- @param str string
--- @param flag string
--- @return string
function M.ltrim(str, flag)
    return base_trim(str, flag)
end

---
---rtrim
--- @param str string
--- @param flag string
--- @return string
function M.rtrim(str, flag)
    str = str or ""
    str = string.reverse(str)
    local res_str = M.ltrim(str, flag)
    return string.reverse(res_str)
end

---
---rtrim
--- @param str string
--- @param flag string
--- @return string
function M.trim(str, flag)
    return base_trim(str, flag, true)
end

---
---array_column
--- @param tb table
--- @param column string
--- @return table
function M.array_column(tb, column)
    local res_tb = {}
    for _,v in pairs(tb) do
        if M.is_table(v) then
            for key, tb_val in pairs(v) do
                if key == column then
                    table.insert(res_tb, tb_val)
                end
            end
        end
    end
    return res_tb
end

---
--- @param tb table
--- @param need_key string
--- @return table
local function array_key_values(tb, need_key)
    need_key = need_key or false
    local res = {}
    for k,v in pairs(tb) do
        if need_key then
            table.insert(res, k)
        else
            table.insert(res, v)
        end
    end
    return res
end

---
---array_keys
--- @param tb table
--- @return table
function M.array_values(tb)
    return array_key_values(tb)
end

---
---array_keys
--- @param tb table
--- @return table
function M.array_keys(tb)
    return array_key_values(tb, true)
end

---
---array_reverse
--- @param tb table
--- @return table
function M.array_reverse(tb)
    local keys = M.array_keys(tb)
    local len = M.count(keys)
    local res_tb = {}
    for i=len, 1, -1 do
        res_tb[keys[i]] = tb[keys[i]]
    end
    return res_tb
end

---
---array_push
--- @param tb table
--- @param val table
--- @return nil
function M.array_push(tb, val)
    table.insert(tb, val)
end

---
---array_pop
--- @param tb table
--- @return nil
function M.array_pop(tb)
    table.remove(tb)
end

---
---array_shift
--- @param tb table
--- @return nil
function M.array_shift(tb)
    table.remove(tb, 1)
end

---
---array_unshift
--- @param tb table
--- @param item any
--- @return nil
function M.array_unshift(tb, item)
    table.insert(tb, 1, item)
end

---
--- in_array
--- @param tb table
--- @param item any
--- @return boolean
function M.in_array(tb, item)
    local exists = false
    for _,v in pairs(tb) do
        if item == v then
            exists = true
            break
        end
    end
    return exists
end

---
---key_exists
--- @param tb table
--- @param key number|string
--- @return boolean
function M.key_exists(tb, key)
    local keys = M.array_keys(tb)
    return M.in_array(keys, key)
end

---
--- array_unique
--- @param tb table
--- @return nil
function M.array_unique(tb)
    local tmp_tb = {}
    for _,v in pairs(tb) do
        if not M.in_array(tmp_tb, v) then
            table.insert(tmp_tb, v)
        end
    end
    return tmp_tb
end

---array_sort_asc
--- @param tb table
function M.array_sort_asc(tb)
    table.sort(tb)
end

---
---array_sort_desc
--- @param tb table
--- @return nil
function M.array_sort_desc(tb)
    table.sort(tb, function(a, b)
        if (a > b) then
            return true
        else
            return false
        end
    end
    )
end

---
---array_rand
--- @param tb table
--- @return any
function M.array_rand(tb)
    math.randomseed(os.time())
    local rand_idx = math.random(M.count(tb))
    return tb[rand_idx]
end

---
---array_merge
--- @param ... table
--- @return table
function M.array_merge(...)
    local tb = {}
    for _,v in pairs({...}) do
        if M.is_table(v) then
            for k, val in pairs(v) do
                tb[k] = val
            end
        end
    end
    return tb
end

---
---json_encode
--- @param val any
--- @return string
function M.json_encode(val)
    return JSON:encode(val)
end

---
---json_decode
--- @param json_str string
--- @return table
function M.json_decode(json_str)
    return JSON:decode(json_str)
end

return M