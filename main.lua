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

end

function love.update(dt)
	scene.current:update(dt)
end

function love.draw()
	love.graphics.push()

	love.graphics.pop()
end

function love.quit()
	love.audio.stop()
end
























