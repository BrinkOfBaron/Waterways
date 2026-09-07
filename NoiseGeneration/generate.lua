--Generate.lua--
Generate = {}

function Generate:random_seeding()
	love.math.random()

end

function Generate:matrix_init(size)
	local MAP = {}
	for i=1, size do
		MAP[i] = {}
		for z=1, size do
			MAP[i][z] = love.math.noise(self:random_seeding(), self:random_seeding(), self:random_seeding())	
		end
	end

	return MAP, size
end




function debug_print(MAP, size)
	for i=1, size do
		print("\n")
		for z=1, size do
			print(MAP[i][z])
		end
	end
end

debug_print(Generate:matrix_init(8), 8) --Run as normal lua file--


