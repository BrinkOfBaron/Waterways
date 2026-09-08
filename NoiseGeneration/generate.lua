--Generate.lua--
Generate = {}

function Generate:random_seeding()
	local baseValue = 1000
	return baseValue*love.math.random() --Add Ranges?--
end

function Generate:matrix_init(size)
	waterway = {}
	for i=1, size do
		waterway[i] = {}
		for z=1, size do
			local choice = love.math.noise(self:random_seeding(), self:random_seeding())	
			if(choice>=0.5)then
				choice = 1
			else
				choice = 0
			end
			waterway[i][z] = choice
		end
	end

	return waterway
end




return Generate
