local tile = {}

function tile:new(image, towerable)
    local t = {
        image = 'assets/images/tiles/' .. image,
        tower = nil,
        towerable = towerable,
        rendered = false
    }
    self.__index = self
    return setmetatable(t, self)
end

function tile:getImage()
    return image_from_cache(self.image)
end

return tile
