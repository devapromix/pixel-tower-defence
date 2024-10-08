config = {
	debug = false,
	
	audio = {
		music = {
			volume = 0.2,
			},
		sound = {
			volume = 0.2,
			}
	},
	
	game = {
		name = 'Pixel Tower Defence',
		version = '0.1',
	},
	
	font = {
		default = {
			height = 40,
		},
	},
	gui = {
		scale = 4,
	}
}

file = {
	save = string.lower(config.game.name .. " save.json"),
	settings = string.lower(config.game.name .. " settings.json"),
}

keybinds = {
	fullscreen = "f11",
	pause = "p",
}

window = {
	fullscreen = true,
	width = 1920,
	height = 1080,
}

function love.conf (t)
	t.console = config.debug
	t.window.fullscreen = window.fullscreen
	t.window.msaa = 0
	t.window.fsaa = 0
	t.window.display = 1
	t.window.resizable = false
	t.window.vsync = false
	t.identity = string.lower(config.game.name.." v."..config.game.version)
	t.window.title = config.game.name
	t.window.width = window.width
	t.window.height = window.height
	t.window.icon = "assets/icons/game.png"
end
