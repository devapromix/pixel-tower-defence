config = {
	debug = false,
	
	audio = {
		volume = 0.5,
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

keybinds = {
	fullscreen = "f11",
	pause = "p",
}

window = {
	fullscreen = true,
}

function love.conf (t)
	t.console = config.debug
	t.window.fullscreen = window.fullscreen
	t.window.msaa = 0
	t.window.fsaa = 0
	t.window.display = 1
	t.window.resizable = false
	t.window.vsync = false
	t.identity = config.game.name..config.game.version
	t.window.title = config.game.name
	--t.window.width = window.width
	--t.window.height = window.height
	t.window.icon = "assets/icons/game.png"
end
