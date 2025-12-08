-- keeno_api.lua - Core ESP System
-- [+] Provided to you by Solarae (https://solarae.vercel.app/)

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Storage
local _0x29c3 = {} -- Players
local _0x1d9f = {} -- Boxes
local _0x6b24 = {} -- Names
local _0x4c7d = {} -- Distances

-- Settings
local _0x4b2e = {
    _0x4e6a = true,      -- espEnabled
    _0x5e19 = false,     -- distanceEnabled
    _0x437a = false,     -- teamCheck
    _0x3f8d = 1000,      -- maxDistance
    _0x2f6b = Color3.fromRGB(0, 255, 0), -- friendColor
    _0x3a92 = Color3.fromRGB(255, 0, 0), -- enemyColor
    _0x5d41 = 2,         -- lineThickness
    _0x3b7d = 13         -- fontSize
}

-- Team check
local _0x3e1d = function(player)
    if player == LocalPlayer then return true end
    if _0x4b2e._0x437a then return false end
    local localTeam = LocalPlayer.Team
    local playerTeam = player.Team
    return not playerTeam or localTeam == playerTeam
end

-- Distance calculation
local _0x5b0c = function(playerChar)
    local localChar = LocalPlayer.Character
    if not localChar or not playerChar then return 0 end
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    local playerRoot = playerChar:FindFirstChild("HumanoidRootPart")
    if not localRoot or not playerRoot then return 0 end
    return math.floor((localRoot.Position - playerRoot.Position).Magnitude)
end

-- World to screen
local _0x2a9f = function(position)
    local camera = workspace.CurrentCamera
    if not camera then return false, Vector2.new(0, 0) end
    local screenPos, onScreen = camera:WorldToViewportPoint(position)
    return onScreen, Vector2.new(screenPos.X, screenPos.Y)
end

-- Get character bounding box
local _0x4a29 = function(character)
    if not character then return {Position = Vector3.new(0,0,0), Size = Vector3.new(5,6,0)} end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return {Position = Vector3.new(0,0,0), Size = Vector3.new(5,6,0)} end
    
    -- Estimate character size (adjustable based on distance)
    local size = Vector3.new(2, 4, 0) -- Base size
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        size = Vector3.new(3, humanoid.HipHeight * 2, 0)
    end
    
    return {
        Position = root.Position,
        Size = size
    }
end

-- Create ESP for player
local _0x4d7a = function(player)
    local playerName = player.Name
    _0x29c3[playerName] = player
    
    -- Create box
    local box = Drawing.new("Square")
    box.Visible = false
    box.Thickness = _0x4b2e._0x5d41
    box.Filled = false
    _0x1d9f[playerName] = box
    
    -- Create name
    local nameText = Drawing.new("Text")
    nameText.Visible = false
    nameText.Size = _0x4b2e._0x3b7d
    nameText.Center = true
    nameText.Outline = true
    _0x6b24[playerName] = nameText
    
    -- Create distance
    local distText = Drawing.new("Text")
    distText.Visible = false
    distText.Size = _0x4b2e._0x3b7d - 2
    distText.Center = true
    distText.Outline = true
    _0x4c7d[playerName] = distText
    
    print('[+] Created ESP for: ' .. playerName)
end

-- Remove ESP
local _0x1862 = function(player)
    local playerName = player.Name
    if _0x1d9f[playerName] then
        _0x1d9f[playerName]:Remove()
        _0x1d9f[playerName] = nil
    end
    if _0x6b24[playerName] then
        _0x6b24[playerName]:Remove()
        _0x6b24[playerName] = nil
    end
    if _0x4c7d[playerName] then
        _0x4c7d[playerName]:Remove()
        _0x4c7d[playerName] = nil
    end
    _0x29c3[playerName] = nil
    print('[-] Removed ESP for: ' .. playerName)
end

-- Calculate box size based on distance
local _0x293b = function(distance)
    -- Base size at 50 studs
    local baseSize = 50
    
    -- Clamp distance to prevent division by zero
    distance = math.max(distance, 1)
    
    -- Size decreases as distance increases
    local size = baseSize / (distance / 50)
    
    -- Clamp size between reasonable values
    size = math.clamp(size, 20, 150)
    
    return Vector2.new(size * 0.6, size) -- Width is 60% of height
end

-- Update ESP
local _0x1c9b = function()
    if not _0x4b2e._0x4e6a then return end
    
    for playerName, player in pairs(_0x29c3) do
        local box = _0x1d9f[playerName]
        local nameText = _0x6b24[playerName]
        local distText = _0x4c7d[playerName]
        
        if box and nameText and distText then
            local char = player.Character
            
            if char then
                local charInfo = _0x4a29(char)
                local distance = _0x5b0c(char)
                
                if distance <= _0x4b2e._0x3f8d then
                    local onScreen, screenPos = _0x2a9f(charInfo.Position)
                    
                    if onScreen then
                        -- Calculate dynamic box size based on distance
                        local boxSize = _0x293b(distance)
                        
                        -- Position box centered on character
                        local boxPos = Vector2.new(
                            screenPos.X - boxSize.X / 2,
                            screenPos.Y - boxSize.Y / 2
                        )
                        
                        -- Update box
                        box.Size = boxSize
                        box.Position = boxPos
                        box.Color = _0x3e1d(player) and _0x4b2e._0x2f6b or _0x4b2e._0x3a92
                        box.Visible = true
                        
                        -- Update name
                        nameText.Text = playerName
                        nameText.Position = Vector2.new(screenPos.X, boxPos.Y - 15)
                        nameText.Color = box.Color
                        nameText.Visible = true
                        
                        -- Update distance
                        if _0x4b2e._0x5e19 then
                            distText.Text = tostring(distance) .. " studs"
                            distText.Position = Vector2.new(screenPos.X, boxPos.Y + boxSize.Y + 5)
                            distText.Color = box.Color
                            distText.Visible = true
                        else
                            distText.Visible = false
                        end
                    else
                        box.Visible = false
                        nameText.Visible = false
                        distText.Visible = false
                    end
                else
                    box.Visible = false
                    nameText.Visible = false
                    distText.Visible = false
                end
            else
                box.Visible = false
                nameText.Visible = false
                distText.Visible = false
            end
        end
    end
end

-- Initialize players
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        _0x4d7a(player)
    end
end

-- Player added/removed
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        _0x4d7a(player)
        print('[~] Player added: ' .. player.Name)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    _0x1862(player)
end)

-- Main loop
local _0x5f9d = RunService.RenderStepped:Connect(function()
    _0x1c9b()
end)

-- Debug stats
spawn(function()
    while task.wait(2) do
        if _0x4b2e._0x4e6a then
            local active = 0
            for _, box in pairs(_0x1d9f) do
                if box.Visible then
                    active = active + 1
                end
            end
            print('[~] ESP Active: ' .. active .. ' | Max Distance: ' .. _0x4b2e._0x3f8d .. ' | Team Check: ' .. tostring(_0x4b2e._0x437a))
        end
    end
end)

print('[+] Keeno ESP System Initialized')
print('[+] Provided to you by Solarae (https://solarae.vercel.app/)')

-- Public API
return {
    espEnabled = function(value)
        if value ~= nil then
            _0x4b2e._0x4e6a = value
            print('[+] ESP ' .. (value and 'enabled' or 'disabled'))
        end
        return _0x4b2e._0x4e6a
    end,
    
    distanceEnabled = function(value)
        if value ~= nil then
            _0x4b2e._0x5e19 = value
            print('[+] Distance ' .. (value and 'enabled' or 'disabled'))
        end
        return _0x4b2e._0x5e19
    end,
    
    teamCheck = function(value)
        if value ~= nil then
            _0x4b2e._0x437a = value
            print('[+] Team check ' .. (value and 'enabled' or 'disabled'))
        end
        return _0x4b2e._0x437a
    end,
    
    maxDistance = function(value)
        if type(value) == "number" and value > 0 then
            _0x4b2e._0x3f8d = value
            print('[+] Max distance: ' .. value)
        end
        return _0x4b2e._0x3f8d
    end,
    
    friendColor = function(color)
        if typeof(color) == "Color3" then
            _0x4b2e._0x2f6b = color
            print('[+] Friend color updated')
        end
        return _0x4b2e._0x2f6b
    end,
    
    enemyColor = function(color)
        if typeof(color) == "Color3" then
            _0x4b2e._0x3a92 = color
            print('[+] Enemy color updated')
        end
        return _0x4b2e._0x3a92
    end,
    
    lineThickness = function(thickness)
        if type(thickness) == "number" and thickness > 0 then
            _0x4b2e._0x5d41 = thickness
            for _, box in pairs(_0x1d9f) do
                box.Thickness = thickness
            end
            print('[+] Line thickness: ' .. thickness)
        end
        return _0x4b2e._0x5d41
    end,
    
    fontSize = function(size)
        if type(size) == "number" and size > 0 then
            _0x4b2e._0x3b7d = size
            for _, text in pairs(_0x6b24) do
                text.Size = size
            end
            for _, text in pairs(_0x4c7d) do
                text.Size = size - 2
            end
            print('[+] Font size: ' .. size)
        end
        return _0x4b2e._0x3b7d
    end,
    
    refresh = function()
        -- Remove all
        for playerName, _ in pairs(_0x29c3) do
            local player = game.Players:FindFirstChild(playerName)
            if player then
                _0x1862(player)
            end
        end
        
        -- Re-add all players except local
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                _0x4d7a(player)
            end
        end
        
        print('[+] ESP refreshed')
        return true
    end,
    
    clear = function()
        for playerName, box in pairs(_0x1d9f) do
            box:Remove()
        end
        for playerName, nameText in pairs(_0x6b24) do
            nameText:Remove()
        end
        for playerName, distText in pairs(_0x4c7d) do
            distText:Remove()
        end
        
        _0x29c3 = {}
        _0x1d9f = {}
        _0x6b24 = {}
        _0x4c7d = {}
        
        print('[+] ESP cleared')
        return true
    end,
    
    destroy = function()
        _0x5f9d:Disconnect()
        _0x4b2e._0x4e6a = false
        
        for playerName, box in pairs(_0x1d9f) do
            pcall(function() box:Remove() end)
        end
        for playerName, nameText in pairs(_0x6b24) do
            pcall(function() nameText:Remove() end)
        end
        for playerName, distText in pairs(_0x4c7d) do
            pcall(function() distText:Remove() end)
        end
        
        _0x29c3 = {}
        _0x1d9f = {}
        _0x6b24 = {}
        _0x4c7d = {}
        
        print('[-] Keeno ESP destroyed')
        return true
    end,
    
    getActivePlayers = function()
        local active = {}
        for playerName, box in pairs(_0x1d9f) do
            if box.Visible then
                table.insert(active, playerName)
            end
        end
        return active
    end,
    
    getSettings = function()
        return {
            espEnabled = _0x4b2e._0x4e6a,
            distanceEnabled = _0x4b2e._0x5e19,
            teamCheck = _0x4b2e._0x437a,
            maxDistance = _0x4b2e._0x3f8d,
            friendColor = _0x4b2e._0x2f6b,
            enemyColor = _0x4b2e._0x3a92,
            lineThickness = _0x4b2e._0x5d41,
            fontSize = _0x4b2e._0x3b7d
        }
    end
}
