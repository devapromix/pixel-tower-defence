local menu = {}

function menu:load()
	background = image_from_cache('assets/images/background/background.png')

end

function menu:draw(mx, my)
	love.graphics.draw(background, 0, 0)

end

function menu:update(dt)

end


























return menu


