ANIMATION_TYPE_RUN = 'run'
ANIMATION_TYPE_DIE = 'die'

local enemy = {
	ident = 1
}

function enemy:new(type, which_path, speed, reward, health)
    local path = scene.game.map.paths[which_path]
    local _enemy = {
        type = type,
        id = tostring(self.ident),
        path = path,
        which_path = which_path,
        path_index = 1,
        position = deep_copy(path[1]),
        speed = speed,
        speedModifier = 1,
        health = health,
        isDead = false,
        reward = reward,
        currentFrame = 1,
        timeSinceFrameChange = 0,
        animationType = ANIMATION_TYPE_RUN
    }

    self.ident = self.ident + 1
    self.__index = self
    return setmetatable(_enemy, self)
end

function enemy:get_image()
    local image = string.format('assets/images/actors/%d/%s/%d.png', self.type, self.animationType, self.currentFrame)
    return image_from_cache(image)
end

function enemy:serialize()
    return {
        type = self.type,
        id = self.id,
        which_path = self.which_path,
        path_index = self.path_index,
        position = self.position,
        speed = self.speed,
        speedModifier = self.speedModifier,
        health = self.health,
        isDead = self.isDead,
        reward = self.reward,
        currentFrame = self.currentFrame,
        timeSinceFrameChange = self.timeSinceFrameChange
    }
end

function enemy:deserialize(de)
    local path = scene.game.map.paths[de.which_path]
    local _enemy = {
        type = de.type,
        id = de.id,
        path = path,
        which_path = de.which_path,
        path_index = de.path_index,
        position = de.position,
        speed = de.speed,
        speedModifier = de.speedModifier,
        health = de.health,
        isDead = de.isDead,
        reward = de.reward,
        currentFrame = de.currentFrame,
        timeSinceFrameChange = de.timeSinceFrameChange
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
    self.timeSinceFrameChange = self.timeSinceFrameChange + dt
    if self.timeSinceFrameChange > 0.1 then
        self.currentFrame = self.currentFrame + 1
        if self.currentFrame == 20 and self.isDead then
            self:destroy(state)
        end
        self.currentFrame = self.currentFrame % 20 + 1
        self.timeSinceFrameChange = self.timeSinceFrameChange - 0.1
    end

    if self.path_index >= #self.path then
        state.lives = state.lives - 1
        self.isDead = true
        self:destroy(state)
        return
    end

    local prevPos = self.path[self.path_index]
    local nextPos = self.path[self.path_index + 1]
    local reached = false

    if prevPos[1] < nextPos[1] then
        self.position[1] = self.position[1] + self.speed*dt*self.speedModifier
        if self.position[1] > nextPos[1] then
            reached = true
        end
    elseif prevPos[1] > nextPos[1] then
        self.position[1] = self.position[1] - self.speed*dt*self.speedModifier
        if self.position[1] < nextPos[1] then
            reached = true
        end
    elseif prevPos[2] < nextPos[2] then
        self.position[2] = self.position[2] + self.speed*dt*self.speedModifier
        if self.position[2] > nextPos[2] then
            reached = true
        end
    elseif prevPos[2] > nextPos[2] then
        self.position[2] = self.position[2] - self.speed*dt*self.speedModifier
        if self.position[2] < nextPos[2] then
            reached = true
        end
    end

    if reached then
        self.path_index = self.path_index + 1
        self.position = deep_copy(nextPos)
    end
end

function enemy:take_damage(state, amount)
	self.health = self.health - amount
	if self.health <= 0 then
		self.isDead = true
		state.money = state.money + self.reward
	end
end

function enemy:froze()
--Заморозка
end

function enemy:destroy(state)
	remove_from_table_by_key(state.enemies, self.id)
end

return enemy
