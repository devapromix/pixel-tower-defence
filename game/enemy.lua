ANIMATION_TYPE_RUN = 'run'
ANIMATION_TYPE_DIE = 'die'

local enemy = {
	ident = 1
}

function enemy:new(type, whichPath, speed, reward, health)
    local _enemy = {
        type = type,
        id = tostring(self.ident),
        position = deep_copy(path[1]),
        speed = speed,
        health = health,
        isDead = false,
        animationType = ANIMATION_TYPE_RUN
    }

    self.ident = self.ident + 1
    self.__index = self
    return setmetatable(_enemy, self)
end

function enemy:getImage()
    local image = nil
    return image_from_cache(image)
end

function enemy:serialize()
    return {
        type = self.type,
        id = self.id,
        position = self.position,
        speed = self.speed,
        health = self.health,
        isDead = self.isDead,
    }
end

function enemy:deserialize(de)
    local path = scene.game.map.paths[de.whichPath]
    local _enemy = {
        type = de.type,
        id = de.id,
        path = path,
        position = de.position,
        speed = de.speed,
        health = de.health,
        isDead = de.isDead,
    }

    if _enemy.isDead then
        _enemy.animationType = ANIMATION_TYPE_DIE
    else
        _enemy.animationType = ANIMATION_TYPE_RUN
    end

    self.__index = self
    return setmetatable(_enemy, self)
end

function enemy:update(state, dt)

end

function enemy:takeDamage(state, amount)

end

function enemy:froze()

end

function enemy:destroy(state)
	remove_from_table_by_key(state.enemies, self.id)
end

return enemy
