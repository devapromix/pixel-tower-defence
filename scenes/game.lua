local enemy = require("game.enemy")
local tower = require("game.tower")
local bullet = require("game.bullet")

GAME_SAVE_FILE_NAME = config.game.name .. " Save.json"
GAME_SETTINGS_FILE_NAME = config.game.name .. " Settings.json"

local game = {}

function game:load()
	background = image_from_cache('assets/images/background/background.png')

end

function game:draw(mx, my)
	love.graphics.draw(background, 0, 0)

end

function game:update(dt)

end
















return game

