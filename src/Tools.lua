local MV = MageVendor
MV.Tools = {};

local Tools = MV.Tools

------------------
-- NUMBER TOOLS --
------------------

function Tools:FormatSeconds(seconds)
	local hours = floor(seconds / 3600)
	local minutes = floor(seconds / 60) - hours * 60
	local seconds = seconds - minutes * 60 - hours * 3600
	return ("%02d:%02d:%02d"):format(hours, minutes, seconds)
end

------------------
-- STRING TOOLS --
------------------

function Tools:Trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function Tools:Split(s)
	local r = {}
	for token in string.gmatch(s, "[^%s]+") do
		table.insert(r, token)
	end
	return r
end

-----------------
-- TABLE TOOLS --
-----------------

function Tools:InTable(tbl, val)
	for _,v in pairs(tbl) do
		if v == val then return true end
	end
	return false
end

function Tools:TableCopy(tbl, cache)
	if type(tbl) ~= "table" then return tbl end
	cache = cache or {}
	if cache[tbl] then return cache[tbl] end
	local copy = {}
	cache[tbl] = copy
	for k, v in pairs(tbl) do
		copy[self:TableCopy(k, cache)] = self:TableCopy(v, cache)
	end
	return copy
end

function Tools:TableLength(table)
	local count = 0
	for _,_ in pairs(table) do
		count = count + 1
	end
	return count
end

-----------------
-- OTHER TOOLS --
-----------------

function Tools:GUIDToID(guid)
	if not guid then return nil end
	local id = guid:match("^%w+%-0%-%d+%-%d+%-%d+%-(%d+)%-[A-Z%d]+$")
	return tonumber(id)
end
