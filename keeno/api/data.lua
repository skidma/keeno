local _0x43 = {}
local _0x4D = game:GetService("Players")
local _0x57 = workspace

-- Player Data Cache
local _0x50 = {}

function _0x43:FetchPlayerData(player)
    if not player or not player.Character then
        return nil
    end

    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not rootPart then
        return nil
    end

    local localPlayer = _0x4D.LocalPlayer
    local localChar = localPlayer.Character
    local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")

    local distance = 0
    if localRoot then
        distance = (rootPart.Position - localRoot.Position).Magnitude
    end

    local data = {
        Player = player,
        Character = character,
        Humanoid = humanoid,
        RootPart = rootPart,
        Position = rootPart.Position,
        Health = humanoid.Health,
        MaxHealth = humanoid.MaxHealth,
        Distance = math.floor(distance),
        Team = player.Team,
        IsAlive = humanoid.Health > 0,
        LastUpdate = tick()
    }

    _0x50[player] = data
    return data
end

function _0x43:GetAllPlayerData()
    local players = _0x4D:GetPlayers()
    local data = {}

    for _, player in ipairs(players) do
        if player ~= _0x4D.LocalPlayer then
            local playerData = self:FetchPlayerData(player)
            if playerData then
                table.insert(data, playerData)
            end
        end
    end

    return data
end

function _0x43:GetCachedPlayerData(player)
    return _0x50[player]
end

function _0x43:ClearCache()
    _0x50 = {}
end

function _0x43:UpdateCache()
    local players = _0x4D:GetPlayers()

    -- Remove old entries
    for player in pairs(_0x50) do
        if not table.find(players, player) then
            _0x50[player] = nil
        end
    end

    -- Update existing
    for _, player in ipairs(players) do
        if player ~= _0x4D.LocalPlayer then
            self:FetchPlayerData(player)
        end
    end
end

return _0x43
