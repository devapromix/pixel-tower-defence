-- MATH --

function capitalize(str)
    return (str:gsub("^%l", string.upper))
end

function bar_width(cx, mx, size)
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

function deep_copy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            setmetatable(copy, deep_copy(getmetatable(orig), copies))
            for orig_key, orig_value in next, orig, nil do
                copy[deep_copy(orig_key, copies)] = deep_copy(orig_value, copies)
            end
        end
    else
        copy = orig
    end
    return copy
end

function distance(from_x, from_y, to_x, to_y)
	return math.sqrt(
		(from_x - to_x) * (from_x - to_x)
		+
		(from_y - to_y) * (from_y - to_y)
	)
end

function distance2(sx, sy, tx, ty)
    local x_diff = sx - tx
    local y_diff = sy - ty
    if x_diff < 0 then x_diff = x_diff * -1 end
    if y_diff < 0 then y_diff = y_diff * -1 end
    return math.max(x_diff, y_diff)
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

function math.round(val)
	local dec = val - math.floor(val)
	if dec >= .5 then
		return math.ceil(val)
	else
		return math.floor(val)
	end
end

function math.random_bool()
	if math.random() >= 0.5 then
		return true
	else
		return false
	end
end

-- TABLE --

function remove_from_table_by_key(tab, key)
    tab[key] = nil
end

function table.empty(tab)
	while next(tab) do
		tab[next(tab)] = nil
	end
end

function table.random(tab)
  return tab[math.random(#tab)]
end

function table.random_key(tab)
	if (tab[1] ~= nil) then
		return random(#tab)
	else
		local keys = {}
		for key, obj in pairs(tab) do
			keys[#keys + 1] = key
		end
		return keys[random(#keys)]
	end
end

function table.count(tab)
	local ret = 0
	for _,__ in pairs(tab) do
		ret = ret + 1
	end
	return ret
end

function table.shuffle(tab)
	if table.count(tab) == 1 and #tab == 1 then
		return tab
	end
	local ret = {}
	while next(tab) ~= nil do
		local key = table.random_key(tab)
		ret[#ret + 1] = tab[key]
		tab[key] = nil
	end
	return ret
end

function table.in_table(needle, haystack)
	for i, v in pairs(haystack) do
		if (v == needle) then 
			return i end
	end
	return false
end

function table.is_empty(tab)
	local next = next
	return next(tab) == nil
end

function table.amount(tab, val)
	ret = 0
    for _, value in ipairs(tab) do
        if value == val then
            ret = ret + 1
        end
    end
    return ret
end

function table.size(tab)
    local s = 0
    for _ in pairs(tab) do s = s + 1 end
    return s
end

function table.copy(tab)
	local u = {}
	for k, v in pairs(tab) do
		u[k] = v
	end
	return setmetatable(u, getmetatable(tab))
end

function table.copy2(tab)
	local copy = {}
	for k, v in pairs(tab) do
		copy[k] = v
		if type(v) == 'table' then
			table.copy2(v)
		end
	end
	return copy
end

function table.pos(line, col, tab)
	for index, valeur in ipairs(tab) do
		if valeur.line == line and valeur.col == col then
			return index
		end
	end
	return 0
end

function table.contains(tab, element)
  for _, value in pairs(tab) do
    if value == element then
      return true
    end
  end
  return false
end

function table.append(dst, src)
    for i = 1, #src do dst[#dst+1] = src[i] end
    return dst
end

function table.lower(t)
	local tt = {}
	for i, e in ipairs(t) do tt[i] = e:lower() end
	return tt
end

function table.capitalize(t)
	local tt = {}
	for i, e in ipairs(t) do tt[i] = e:capitalize() end
	return tt
end

-- FILE --

function file_exists(path)
    return love.filesystem.getInfo(path, 'file') ~= nil
end

-- STRING --

function string.explode(str, delim)
	local parts = {}
	for part in string.gmatch(str, "[^" .. delim .."]+") do
		parts[#parts + 1] = part
	end
	return parts
end

function string.capitalize(str)
    if #str > 1 then
        return string.upper(str:sub(1, 1))..str:sub(2)
    elseif #str == 1 then
        return str:upper()
    else
        return str
    end
end

function string.vowel(string)
	local s = string:sub(1,1)
	if (s == "a" or s == "e" or s=="i" or s=="o" or s=="u" or s=="sometimes y") then
		return true
	end
	return false
end

function string.ordinal(number)
    local suffix = "th"
    number = tonumber(number)
    local base = number % 10
    if base == 1 then
        suffix = "st"
    elseif base == 2 then
        suffix = "nd"
    elseif base == 3 then
        suffix = "rd"
    end
    return number .. suffix
end

function string.ucfirst(string)
	string = tostring(string)
	return string:gsub("%a", string.upper, 1)
end

function string.lcfirst(string)
	string = tostring(string)
	return string:gsub("%a", string.lower, 1)
end

-- UTILS --

function list_to_obj(list)
	local set = {}
	for _,l in pairs(list) do
		set[l.name] = l
	end
	return set
end

function obj_to_list(obj)
	local list = {}
	for k,v in ipairs(obj) do 
		list[k] = v 
	end
	return list
end

function echo(s, x, y, c)
	x, y = math.floor(x), math.floor(y)
	love.graphics.setColor(25, 25, 25, 255)
	love.graphics.print(s, x + 1, y + 1)
	love.graphics.setColor(c, 250)
	love.graphics.print(s, x, y)
end

function rgba(r, g, b, a)
	return {r / 255, g / 255, b / 255, a}
end

function calc_angle(fromx, fromy, tox, toy)
	local xdiff = tox - fromx
	local ydiff = toy - fromy
	local rad = math.atan2(ydiff, xdiff) + math.pi * .5
	return 2 * math.pi + rad
end

function collision(x1, y1, w1, h1, x2, y2, w2, h2)
	return (
		x2 < x1 + w1 and
		x1 < x2 + w2 and
		y1 < y2 + h2 and
		y2 < y1 + h1
	)
end

function get_left(awidth)
	return math.floor((window.width - awidth) / 2)
end

function get_top(aheight)
	return math.floor((window.height - aheight) / 2)
end

function mouse_in(left, top, width, height)
	local x, y = mouse.get_pos()
	return (x >= left) and (y >= top) and (x <= left + width) and (y <= top + height)
end

function get_grid_position(mx, my)
	local x = math.floor(mx / config.map.tile.width) + 1
	local y = math.floor((my - config.bar.height) / config.map.tile.height) + 1
	return x, y
end

function get_cursor_position()
	local x, y = mouse.get_pos()
	return get_grid_position(x, y)
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
		image_cache[path]:setFilter("nearest", "nearest")
    end
    return image_cache[path]
end

local audio_cache = {}

function audio_from_cache(path)
    if audio_cache[path] == nil then
        audio_cache[path] = love.audio.newSource(path, 'static')
    end
    return audio_cache[path]:clone()
end


local function triangle_area(a, b, c)
    return math.abs(a[1]*(b[2] - c[2]) + b[1]*(c[2] - a[2]) + c[1]*(a[2] - b[2]))/2
end

local function rect_area(a, b, c, d)
    return math.abs(a[1]*b[2] - b[1]*a[2] + b[1]*c[2] - c[1]*b[2] + c[1]*d[2] - d[1]*c[2] + d[1]*a[2] - a[1]*d[2])/2
end

function point_in_rect(a, b, c, d, m)
    local amb = triangle_area(a, m, b)
    local bmc = triangle_area(b, m, c)
    local cmd = triangle_area(c, m, d)
    local dma = triangle_area(d, m, a)
    local abcd = rect_area(a, b, c, d)
    return math.abs(amb + bmc + cmd + dma - abcd) <= 1e-6
end

function is_rect(px, py, rx, ry, rw, rh)
	if px > rx and px < rx + rw and py > ry and py < ry + rh then
		return true
	else 
		return false 
	end
end
function dir_from_string(str)
	if str == "left" then
		dx = -1 dy = 0
	elseif str == "right" then
		dx = 1 dy = 0
	elseif str == "down" then
		dx = 0 dy = 1
	elseif str == "up" then
		dx = 0 dy = -1
	end
	return dx or 0, dy or 0
end

function random_element(list)
	if not list or #list == 0 then
		return
	end
	return list[love.math.random(#list)]
end












