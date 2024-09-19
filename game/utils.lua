function capitalize(str)
    return (str:gsub("^%l", string.upper))
end

function barWidth(cx, mx, size)
	if cx == mx and cx == 0 then
		return 0
	end
	if (mx <= 0) then
		mx = 1
	end
	local i = math.floor((cx * size) / mx)
	if i <= 0 then
		i = 0
	end
	if (cx >= mx) then
		i = size
	end
	return i
end

function draw_centered_text(left, top, width, height, text)
	local font = love.graphics.getFont()
	local text_width = font:getWidth(text)
	local text_height = font:getHeight()
	love.graphics.print(text, left + width / 2, top + height / 2, 0, 1, 1, text_width / 2, text_height / 2)
end

function distance(from_x, from_y, to_x, to_y)
	return math.sqrt(
		(from_x - to_x) * (from_x - to_x)
		+
		(from_y - to_y) * (from_y - to_y)
	)
end

function clamp(value, min, max)
  return value < min and min or (value > max and max or value)
end

function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function signum(x)
	if x == 0 then
		return 0
	end
	return x/math.abs(x)
end

function random_element(list)
	if not list or #list == 0 then
		return
	end
	return list[love.math.random(#list)]
end

function is_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function remove_from_table_by_key(tab, key)
    tab[key] = nil
end

function amount_value(tab, val)
	ret = 0
    for _, value in ipairs(tab) do
        if value == val then
            ret = ret + 1
        end
    end
    return ret
end

function table_size(tab)
    local s = 0
    for _ in pairs(tab) do s = s + 1 end
    return s
end

function file_exists(path)
    return love.filesystem.getInfo(path, 'file') ~= nil
end

function get_left(awidth)
	return math.floor((window.width - awidth) / 2)
end

function get_top(aheight)
	return math.floor((window.height - aheight) / 2)
end

function mouse_in(left, top, width, height)
	x, y = love.mouse.getPosition()
	return (x >= left) and (y >= top) and (x <= left + width) and (y <= top + height)
end

function get_grid_position(mx, my)
	local x = math.floor(mx / config.map.tile.width) + 1
	local y = math.floor((my - config.bar.height) / config.map.tile.height) + 1
	return x, y
end

function get_cursor_position()
	local mx, my = love.mouse.getPosition()
	return get_grid_position(mx, my)
end

function get_cursor_coord(x, y)
	local nx = (x - 1) * config.map.tile.width
	local ny = (y - 1) * config.map.tile.height + config.bar.height
	return nx, ny
end

local image_cache = {}

function image_from_cache(path)
    if image_cache[path] == nil then
        image_cache[path] = love.graphics.newImage(path)
    end
    return image_cache[path]
end

local audio_cache = {}

function audio_from_cache(path)
    if audio_cache[path] == nil then
        audio_cache[path] = love.audio.newSource('assets/music/' .. path, 'static')
    end
    return audio_cache[path]:clone()
end












