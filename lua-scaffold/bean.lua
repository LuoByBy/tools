----------
-- data --
----------

local classField = {
	playerInfo = {
		permanCarCount = {
			init = 0,
		},
		championCount = {
			init = 0,
		},
		carModifyCount = {
			init = 0,
		},
		hornPoint = {
			init = 0,
		},
		permanDressPoint = {
			init = 0,
		},
		pveStarCount = {
			init = 0,
		},
	},
}

local tab = 4

----------
-- code --
----------

local function getTab()
	local ret = ""
	for i = 1, tab do 
		ret = ret .. " "
	end
	return ret
end

local function getInit(fieldName, initValue)
	return getTab() .. fieldName .. " = " .. initValue .. "\n"
end

local function getGetter(className, fieldName)
	local functionName = string.upper(string.sub(fieldName, 1, 1)) .. string.sub(fieldName, 2, -1)
	local ret = "function " .. className .. ":get" .. functionName .. "()\n"
	ret = ret .. getTab() .. "return self." .. fieldName .. "\n"
	ret = ret .. "end\n\n"
	return ret
end

local function getSetter(className, fieldName)
	local functionName = string.upper(string.sub(fieldName, 1, 1)) .. string.sub(fieldName, 2, -1)
	local ret = "function " .. className .. ":set" .. functionName .. "(" .. fieldName .. ")\n"
	ret = ret .. getTab() .. "self." .. fieldName .. " = " .. fieldName .. "\n"
	ret = ret .. "end\n\n"
	return ret
end

local outFile = io.open("out.lua" ,"w")

for class, fields in pairs(classField) do 
	for field, info in pairs(fields) do 
		local init = getInit(field, info.init)
		outFile:write(init)
	end
end

for class, fields in pairs(classField) do 
	for field, _ in pairs(fields) do 
		local getter = getGetter(class, field)
		outFile:write(getter)
		local setter = getSetter(class, field)
		outFile:write(setter)
	end
end

outFile:close()  