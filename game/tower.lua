local bullet = require("game.bullet")

tower_types = {
	{
		images = {
			'assets/images/towers/weapon_crystals_N.png',
			'assets/images/towers/weapon_crystals_N.png',
			'assets/images/towers/weapon_crystals_N.png',
			'assets/images/towers/weapon_crystals_N.png'
		},
		price = 60,
		range = 3.05,
		interval = 1.5,
		damage = 1,
		sound = "snow.mp3"
	},
	{
		images = {
			'assets/images/towers/weapon_cannon_E.png',
			'assets/images/towers/weapon_cannon_N.png',
			'assets/images/towers/weapon_cannon_W.png',
			'assets/images/towers/weapon_cannon_S.png'
		},
		price = 80,
		range = 4.05,
		interval = 3.75,
		damage = 30,
		sound = "cannon.mp3"
	},
	{
		images = {
			'assets/images/towers/weapon_ballista_E.png',
			'assets/images/towers/weapon_ballista_N.png',
			'assets/images/towers/weapon_ballista_W.png',
			'assets/images/towers/weapon_ballista_S.png'
		},
		price = 50,
		range = 2.05,
		interval = 1.25,
		damage = 10,
		sound = "arrow.mp3"
	}
}

local tower = {
	ident = 1
}

function tower:new(type, position)
	local _tower = {
		id = tostring(self.ident),
		data = tower_types[type],
		target = nil,
		last_shot_at = 0,
		position = position,
		rotation = 1,
		type = type
	}
	sound.play("build.mp3")
	self.ident = self.ident + 1
	self.__index = self
	return setmetatable(_tower, self)
end

function tower:get_image()
	return image_from_cache(self.data.images[self.rotation])
end

function tower:serialize()
	local _tower = {
		id = self.id,
		last_shot_at = self.last_shot_at,
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
		data = tower_types[de.type],
		target = scene.game.enemies[de.target],
		last_shot_at = de.last_shot_at,
		position = de.position,
		rotation = de.rotation,
		type = de.type
	}
	self.__index = self
	return setmetatable(_tower, self)
end

function tower:turn_to_target()
	local angle = math.deg(math.atan2(self.target.position[1] - self.position[1],
		self.target.position[2] - self.position[2]))
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

function tower:range()
	return self.data.range
end

function tower:interval()
	return self.data.interval
end

function tower:get_damage()
	return self.data.damage
end

function tower:refund()
	sound.play("sell.mp3")
	return 3 * self.data.price / 5
end

function tower:in_range(x, y)
	local r = self:range()
	return x * x + y * y <= r * r
end

function tower:find_enemy(state)
	for _, _enemy in pairs(state.enemies) do
		local x = _enemy.position[1] - self.position[1]
		local y = _enemy.position[2] - self.position[2]
		if self:in_range(x, y) and not _enemy.isDead then
			self.target = _enemy
			return
		end
	end
end

function tower:update(state, dt)
	if self.target ~= nil then
		local x = self.target.position[1] - self.position[1]
		local y = self.target.position[2] - self.position[2]
		if self:in_range(x, y) or self.target.isDead then
			self.target = nil
		end
	end
	self:find_enemy(state)
	if self.target ~= nil then
		self:turn_to_target()
		if state.time_now - self.last_shot_at > self:interval() then
			self.last_shot_at = state.time_now
			sound.play(self.data.sound)
			local _bullet = bullet:new(self, self.target)
			state.bullets[_bullet.id] = _bullet
		end
	end
	for _, _bullet in pairs(state.bullets) do
		_bullet:update(state, dt)
	end
end

function tower:draw(state, x, y)
	love.graphics.draw(self:get_image(), x, y - 16)
	for _, _bullet in pairs(state.bullets) do
		_bullet:draw()
	end
end

return tower
