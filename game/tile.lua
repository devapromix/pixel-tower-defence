local tile = {}

function tile:new(image, towerable)
    local _tile = {
        image = "assets/images/tiles/" .. image,
        tower = nil,
        towerable = towerable,
        rendered = false
    }
    self.__index = self
    return setmetatable(_tile, self)
end

function tile:get_image()
    return image_from_cache(self.image)
end

return tile
