local font = {}

function font.load()
	font.tiny = love.graphics.newFont("assets/fonts/alagard.ttf", 10)
	font.small = love.graphics.newFont("assets/fonts/alagard.ttf", 16)
	font.console = love.graphics.newFont("assets/fonts/alagard.ttf", 18)
	font.mid = love.graphics.newFont("assets/fonts/alagard.ttf", 28)
	--font.mid = love.graphics.newFont("assets/fonts/scream.ttf", 28)
	font.title = love.graphics.newFont("assets/fonts/alagard.ttf", 38)
	font.big = love.graphics.newFont("assets/fonts/alagard.ttf", 50)
	font.huge = love.graphics.newFont("assets/fonts/alagard.ttf", 150)
	font.default = font.mid
	love.graphics.setFont(font.default)
end

return font