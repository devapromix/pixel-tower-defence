local bullet = require("game.bullet")

towerTypes = {
    {
        images = {},
        price = 10,
        damage = 1,
    }
}

local tower = {
	ident = 1
}

function tower:new(type, position)
    local _tower = {
        id = tostring(self.ident),
        data = towerTypes[type],
        target = nil,
        position = position,
        rotation = 1,
        type = type
    }

    self.ident = self.ident + 1
    self.__index = self
    return setmetatable(_tower, self)
end

function tower:getImage()
	return image_from_cache(self.data.images[self.rotation])
end

function tower:serialize()
    local _tower = {
        id = self.id,
        position = self.position,
        rotation = self.rotation,
        type = self.type
    }

    if self.target ~= nil then
        _tower.target = self.target.id
    end

    return _tower
end

function tower:deserialize(de)
    local _tower = {
        id = de.id,
        data = towerTypes[de.type],
        target = scene.game.enemies[de.target],
        position = de.position,
        rotation = de.rotation,
        type = de.type
    }

    self.__index = self
    return setmetatable(_tower, self)
end

function tower:turnToTarget()
	local angle = 0 -- Треба покурити як повертати башню
    if angle < 0 then
        angle = angle + 360
    end

    if 45 < angle and angle < 135 then
        self.rotation = 1
    elseif 135 < angle and angle < 225 then
        self.rotation = 2
    elseif 225 < angle and angle < 315 then
        self.rotation = 3
    else
        self.rotation = 4
    end
end

function tower:update(state, dt)
    if self.target ~= nil then
        local dx = self.target.position[1] - self.position[1]
        local dy = self.target.position[2] - self.position[2]
    end

    for _, _bullet in pairs(state.bullets) do
        _bullet:update(state, dt)
    end
end

function tower:draw(state, x, y)
	love.graphics.draw(self:getImage(), x, y - 16)
    for _, _bullet in pairs(state.bullets) do
        _bullet:draw()
    end
end

return tower