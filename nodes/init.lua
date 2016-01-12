minetest.register_abm({
	nodenames = {"default:torch"},
	neighbors = {"default:water_source"},
	interval = 1.0,
	chance = 1,
	action = function(pos)
		minetest.set_node(pos, {name = "default:water_source"})
	end,
})
