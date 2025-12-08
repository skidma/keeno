local success, core = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/skidma/keeno/refs/heads/main/keeno_api.lua"))()
end)

if not success then
    return nil
end

local keeno = {}

keeno.espEnabled = true
keeno.distanceEnabled = false
keeno.teamCheck = false
keeno.tracersEnabled = false
keeno.maxDistance = 1000
keeno.friendColor = Color3.fromRGB(0, 255, 0)
keeno.enemyColor = Color3.fromRGB(255, 0, 0)
keeno.lineThickness = 2
keeno.tracerThickness = 1
keeno.fontSize = 13

setmetatable(keeno, {
    __newindex = function(self, key, value)
        rawset(self, key, value)

        if key == "espEnabled" then
            core.espEnabled(value)
        elseif key == "distanceEnabled" then
            core.distanceEnabled(value)
        elseif key == "teamCheck" then
            core.teamCheck(value)
        elseif key == "tracersEnabled" then
            core.tracersEnabled(value)
        elseif key == "maxDistance" then
            core.maxDistance(value)
        elseif key == "friendColor" then
            core.friendColor(value)
        elseif key == "enemyColor" then
            core.enemyColor(value)
        elseif key == "lineThickness" then
            core.lineThickness(value)
        elseif key == "tracerThickness" then
            core.tracerThickness(value)
        elseif key == "fontSize" then
            core.fontSize(value)
        end
    end
})

function keeno:refresh()
    return core.refresh()
end

function keeno:clear()
    return core.clear()
end

function keeno:destroy()
    return core.destroy()
end

function keeno:getActivePlayers()
    return core.getActivePlayers()
end

function keeno:getSettings()
    return core.getSettings()
end

function keeno:getStats()
    local active = #self:getActivePlayers()
    local total = #game.Players:GetPlayers() - 1
    local settings = self:getSettings()

    return {
        active = active,
        total = total,
        espEnabled = settings.espEnabled,
        maxDistance = settings.maxDistance,
        teamCheck = settings.teamCheck,
        tracersEnabled = settings.tracersEnabled
    }
end

keeno.espEnabled = keeno.espEnabled
keeno.distanceEnabled = keeno.distanceEnabled
keeno.teamCheck = keeno.teamCheck
keeno.tracersEnabled = keeno.tracersEnabled

print(" [!] Keeno Initialized")

return keeno
