local bullet = require("game.bullet")

towerTypes = {}

local tower = {
	ident = 1
}

function tower:new(type, position)
	local _tower = {}

    return setmetatable(_tower, self)
end

function tower:getImage()

end

function tower:serialize()
	local _tower = {}
	
	return _tower
end

function tower:deserialize(de)
	local _tower = {}

    self.__index = self
    return setmetatable(_tower, self)
end

function tower:turnToTarget()

end

function tower:update(state, dt)

end

function tower:draw(state, x, y)
    for _, _bullet in pairs(state.bullets) do
        _bullet:draw()
    end
end

return tower