local scene = {
    current = nil,
    menu = require('scenes.menu'),
    game = require('scenes.game'),
    mousedown = {},
}

scene.switch = function(name)
    scene.current = scene[name]
    scene.current:load()
end

scene.ismousedown = function(button)
    local ret = scene.mousedown[button]
    scene.mousedown[button] = false
    return ret
end


return scene