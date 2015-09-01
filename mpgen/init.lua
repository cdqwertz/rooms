local cave_rooms = true
local cave_rooms_start = -5

if cave_rooms == false then
	minetest.register_on_mapgen_init(function(mgparams)
		minetest.set_mapgen_params({mgname="singlenode", flags="nolight"})
	end)
end

minetest.register_on_generated(function(minp, maxp, seed)
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	
	local c_air = minetest.get_content_id("air")
	local c_stonebrick = minetest.get_content_id("default:stonebrick")
	local c_stone = minetest.get_content_id("default:stone")
	local c_wood = minetest.get_content_id("default:wood")

	local c_coal = minetest.get_content_id("default:stone_with_coal")
	local c_iron = minetest.get_content_id("default:stone_with_iron")
	local c_copper = minetest.get_content_id("default:stone_with_copper")
	local c_mese = minetest.get_content_id("default:stone_with_mese")
	local c_diamond = minetest.get_content_id("default:stone_with_diamond")
	
	local c_water = minetest.get_content_id("default:water_source")
	local c_lava = minetest.get_content_id("default:lava_source")

	local rndX = 1
	local rndY = 1
	local rndZ = 1

	for z = minp.z, maxp.z do
		for y = minp.y - 16, maxp.y + 1 do
			for x = minp.x, maxp.x do
				if (cave_rooms == true and y < cave_rooms_start) or cave_rooms == false then
					local pos = area:index(x, y, z)
					if (x % 6) == 0 then
						if rndX == 1 then
							if y < -30 then
								local rnd = math.random(20)
								if rnd == 1 then
									data[pos] = c_iron
								elseif rnd == 2 then
									data[pos] = c_copper
								elseif rnd == 3 then
									data[pos] = c_mese
								elseif rnd == 4 then
									data[pos] = c_diamond
								elseif rnd == 5 then
									data[pos] = c_coal
								elseif rnd == 6 or rnd == 7 then
									data[pos] = c_stone
								else
									data[pos] = c_stonebrick
								end
							else
								data[pos] = c_wood
							end
						else
							data[pos] = c_air
						end
					elseif (y % 4) == 0 then
						if y < -30 then
							data[pos] = c_stonebrick
						else
							data[pos] = c_wood
						end
						rndX = math.random(2)
						rndZ = math.random(2)
					elseif ((z % 8) == 0) and ((((x%8)-2) ~= 0) or ((y%4-3) == 0)) then
						if rndZ == 1 then
							if y < -30 then
								local rnd = math.random(10)
								if rnd == 1 then
									data[pos] = c_iron
								elseif rnd == 2 then
									data[pos] = c_copper
								elseif rnd == 3 then
									data[pos] = c_mese
								elseif rnd == 4 then
									data[pos] = c_diamond
								else
									data[pos] = c_stonebrick
								end
							else
								data[pos] = c_wood
							end
						else
							data[pos] = c_air
						end
					elseif y < -50 and math.random(10) == 2 then
						data[pos] = c_water
					else
						data[pos] = c_air
					end
				end
			end
		end
	end
	
	vm:set_data(data)
	vm:calc_lighting()
	vm:write_to_map(data)
	vm:update_liquids()
end)

