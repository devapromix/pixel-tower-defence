require "import"

function love.load()
	math.randomseed(os.time())
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.window.setVSync(1)

	font.load()

	scene.switch('menu')
end

function love.mousepressed(x, y, button, istouch, presses)
	scene.mousedown[button] = true
end

function love.mousereleased(x, y, button, istouch, presses)
	scene.mousedown[button] = false
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' and scene.current == scene.game then
		scene.game:pause()
	end

	if scene.current == scene.game and (scene.game.state == GAME_STATE_WIN or scene.game.state == GAME_STATE_LOSE) then
		scene.game.state = GAME_STATE_STOPPED
		scene.switch('menu')
	end
end

function love.update(dt)
	scene.current:update(dt)
end

function love.draw()
	love.graphics.push()
	local sx = love.graphics.getPixelWidth() / window.width
	local sy = love.graphics.getPixelHeight() / window.height
	love.graphics.scale(sx, sy)
	local mx, my = love.mouse.getPosition()
	scene.current:draw(mx/sx, my/sy)
	love.graphics.pop()
end

function love.quit()
	love.audio.stop()
end
