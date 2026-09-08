--Main.lua--
local Generate = require("NoiseGeneration/generate")
local MATRIX_SIZE = 8 --8*8 matrix--
local GRASS = love.graphics.newImage("assets/grass.png")

local WATER = love.graphics.newImage("assets/water.png")

local flux = require("lib/flux") --Tweening--
local Camera = require("lib/camera")
local tile_constant = 16
local SCALE = {SCALEX = 0, SCALEY = 0}

text = {}
text.text = "Press X!"
text.opacity = 0

matrix = {}

function window_setup()
	love.window.setMode(1280, 720)
	love.window.setTitle("NoiseGeneration")
	love.graphics.setDefaultFilter("nearest", "nearest")
end

function love.load()
	
	window_setup()
	camera = Camera(math.floor((MATRIX_SIZE*tile_constant)/2+16+0.5),(math.floor(MATRIX_SIZE*tile_constant)/2+16+0.5))
	camera:zoomTo(2)
	matrix.matrix = Generate:matrix_init(MATRIX_SIZE)
	

	--Graphical Elements--
	flux.to(SCALE, 2, {SCALEX=1, SCALEY = 1}):ease("expoin"):after(text, 1, {opacity=1}):ease("expoin")
end

function love.keypressed(key)
	if(key=="escape")then
		love.event.quit()
	end

	if(key=="x")then
		matrix.matrix = Generate:matrix_init(MATRIX_SIZE)
	end
end

function love.update(dt)
	flux.update(dt)
end

function love.draw()
	camera:attach()
	--drawing the matrix--
	for i=1, MATRIX_SIZE do
		for z=1, MATRIX_SIZE do
			if(matrix.matrix[i][z] == 1)then
				love.graphics.draw(WATER,z*tile_constant, i*tile_constant, 0, SCALE.SCALEX, SCALE.SCALEY)

			else
				love.graphics.draw(GRASS, z*tile_constant, i*tile_constant, 0, SCALE.SCALEX, SCALE.SCALEY)
			end
		end
	end

	--Text Underneath--
	love.graphics.setColor(1,1,1,text.opacity)
	love.graphics.print(text.text, (MATRIX_SIZE*tile_constant)/2, MATRIX_SIZE*tile_constant+100)
	love.graphics.setColor(1,1,1,1)
	camera:detach()
end
