local bullet = {
	ident = 1
}

function bullet:new(tower, enemy)
    local _bullet = {
        id = tostring(self.ident),
        position = deep_copy(tower.position),
        tower = tower,
        target = enemy,
        rotation = 0
    }

    self.ident = self.ident + 1
    self.__index = self
    return setmetatable(_bullet, self)
end

function bullet:get_image()
    self:turn_to_target()
    local image = string.format('assets/images/bullets/%d.png', self.tower.type)
    return image_from_cache(image)
end


function bullet:serialize()
    local _bullet = {
        id = self.id,
        position = self.position,
        rotation = self.rotation
    }

    if self.tower ~= nil then
        _bullet.tower = self.tower.id
    end

    if self.target ~= nil then
        _bullet.target = self.target.id
    end

    return _bullet
end

function bullet:deserialize(de)
    local tower = scene.game.towers[de.tower]

    local _bullet = {
        id = de.id,
        position = deep_copy(de.position),
        tower = tower,
        target = tower.target,
        rotation = de.rotation
    }

    self.__index = self
    return setmetatable(_bullet, self)
end

function bullet:turn_to_target()
    local angle = math.atan2(self.target.position[1] - self.position[1], self.target.position[2] - self.position[2])
    if angle < 0 then
        angle = angle + 2 * math.pi
    end
    self.rotation = math.pi / 4 - angle
end

function bullet:update(state, dt)
    local x = self.target.position[1] - self.position[1]
    local y = self.target.position[2] - self.position[2]

    self.position[1] = self.position[1] + 10 * x * dt
    self.position[2] = self.position[2] + 10 * y * dt

    if x*x+y*y < 0.25 then
        self.target:take_damage(state, self.tower:get_damage())
        if self.tower.type == 1 then
            self.target:froze()
        end
        self:destroy(state)
    end
end

function bullet:draw()
    local width = window.width / 2
    local height = window.height / 2 - 6 * 65

    local x = width + (self.position[1] - self.position[2]) * 65
    local y = height + (self.position[1] + self.position[2] - 2) * 32

    local image = self:get_image()
    love.graphics.draw(image, x, y, self.rotation, 1, 1, image:getWidth() / 2, image:getHeight() / 2)
end

function bullet:destroy(state)
    remove_from_table_by_key(state.bullets, self.id)
end

return bullet
