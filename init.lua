-- Bright Nodes
-- Build with light.

-- You will need to add the appropriate mods to the depends.txt for them to be loaded first
-- Then explicitly add the itemstrings to `items.lua` file

brightnodes = {}
brightnodes.items = {}


dofile(minetest.get_modpath("brightnodes").."/items.lua")

local function deepclone (t) -- deep-copy a table -- from https://gist.github.com/MihailJP/3931841
	if type(t) ~= "table" then return t end

	--local meta = getmetatable(t)
	local target = {}
	
	for k, v in pairs(t) do
		if k ~= "__index" and type(v) == "table" then -- omit circular reference
			target[k] = deepclone(v)
		else
			target[k] = v
		end
	end
	--setmetatable(target, meta)
	return target
end 

local strhas = function(mystr,thelist)
	if mystr:match("brightnodes:.*") then return false end

	for _,item in pairs(thelist) do
		if mystr:match(item) then return true end
	end
	return false
end

minetest.register_craftitem("brightnodes:torch",{
	description = "Brightener",
	inventory_image = "default_obsidian_glass.png^default_torch_on_floor.png",
	wield_image = "default_torch_on_floor.png",
})

minetest.register_craft({
	output = "brightnodes:torch 2",
	type = "shapeless",
	recipe = {"default:torch","default:torch"}
})

for node,def in pairs(minetest.registered_nodes) do
	if strhas(node,brightnodes.items) then
		local newdef = deepclone(def)
		local newnode = "brightnodes:"..node:gsub(":","_")
		local newdesc = "Bright "..def.description

		newdef.paramtype = "light"
		newdef.light_source = brightnodes.brightness
		newdef.light_propagates = true
		newdef.sunlight_propagates = true
		newdef.description = newdesc

		if not newdef.groups then newdef.groups = {} end
		newdef.groups.not_in_creative_inventory = 1

		minetest.register_node(newnode,newdef)

		minetest.register_craft({
			output = newnode,
			type = "shapeless",
			recipe = {"brightnodes:torch",node}
		})

		minetest.register_craft({
			output = node,
			type = "shapeless",
			recipe = {newnode}
		})
	end
end
