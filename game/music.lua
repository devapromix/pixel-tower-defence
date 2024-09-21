local music = {}

music.currentSource = nil
music.currentName = nil

local cache = {}

local function audio_from_cache(path)
    if cache[path] == nil then
        if not love.filesystem.getInfo(path) then 
            if config.debug then
				print("Could not find file: " .. path)
			end
            return false
        end
		cache[path] = love.audio.newSource(path, "stream")
    end
    return cache[path]:clone()
end

function music.play(name)
    if name == "" or name == music.currentName then return end
    music.stop()
    if name then
        music.currentName = name
        music.currentSource = audio_from_cache("assets/songs/" .. name)
        music.setVolume(config.audio.music.volume)
        music.currentSource:setLooping(true)
        music.currentSource:play()
    end
end

function music.setVolume(vol)
    if music.currentSource then
        music.currentSource:setVolume(vol)
    end
end

function music.stop()
    if music.currentSource then 
        music.currentSource:stop() 
        music.currentSource = nil
        music.currentName = ''
    end
end

return music