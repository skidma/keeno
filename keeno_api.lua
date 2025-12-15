-- [+] keeno_api.lua
-- [+] Provided to you by Solarae (https://solarae.vercel.app/)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local _0x29c3 = {}
local _0x1d9f = {}
local _0x6b24 = {}
local _0x4c7d = {}
local _0x3e7a = {}

local _0x4b2e = {
    _0x4e6a = true,
    _0x5e19 = false,
    _0x437a = false,
    _0x3f8d = 1000,
    _0x2f6b = Color3.fromRGB(0, 255, 0),
    _0x3a92 = Color3.fromRGB(255, 0, 0),
    _0x5d41 = 2,
    _0x3b7d = 13,
    _0x6c3e = false,
    _0x1a9d = 1
}

local _0x3e1d = function(player)
    if player == LocalPlayer then return true end
    if _0x4b2e._0x437a then return false end
    local localTeam = LocalPlayer.Team
    local playerTeam = player.Team
    return not playerTeam or localTeam == playerTeam
end

local _0x5b0c = function(playerChar)
    local localChar = LocalPlayer.Character
    if not localChar or not playerChar then return 0 end
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    local playerRoot = playerChar:FindFirstChild("HumanoidRootPart")
    if not localRoot or not playerRoot then return 0 end
    return math.floor((localRoot.Position - playerRoot.Position).Magnitude)
end

local _0x2a9f = function(position)
    local camera = workspace.CurrentCamera
    if not camera then return false, Vector2.new(0, 0) end
    local screenPos, onScreen = camera:WorldToViewportPoint(position)
    return onScreen, Vector2.new(screenPos.X, screenPos.Y)
end

local _0x4a29 = function(character)
    if not character then return Vector3.new(0,0,0) end
    local root = character:FindFirstChild("HumanoidRootPart")
    return root and root.Position or Vector3.new(0,0,0)
end

local _0x293b = function(distance)
    distance = math.max(distance, 1)
    local size = 2000 / distance
    size = math.clamp(size, 15, 80)
    return Vector2.new(size * 0.6, size)
end

local _0x4d7a = function(player)
    local playerName = player.Name
    _0x29c3[playerName] = player
    
    local box = Drawing.new("Square")
    box.Visible = false
    box.Thickness = _0x4b2e._0x5d41
    box.Filled = false
    _0x1d9f[playerName] = box
    
    local nameText = Drawing.new("Text")
    nameText.Visible = false
    nameText.Size = _0x4b2e._0x3b7d
    nameText.Center = true
    nameText.Outline = true
    nameText.Font = 2
    _0x6b24[playerName] = nameText
    
    local distText = Drawing.new("Text")
    distText.Visible = false
    distText.Size = _0x4b2e._0x3b7d - 2
    distText.Center = true
    distText.Outline = true
    distText.Font = 2
    _0x4c7d[playerName] = distText
    
    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Thickness = _0x4b2e._0x1a9d
    _0x3e7a[playerName] = tracer
end

local _0x1862 = function(player)
    local playerName = player.Name
    if _0x1d9f[playerName] then _0x1d9f[playerName]:Remove() end
    if _0x6b24[playerName] then _0x6b24[playerName]:Remove() end
    if _0x4c7d[playerName] then _0x4c7d[playerName]:Remove() end
    if _0x3e7a[playerName] then _0x3e7a[playerName]:Remove() end
    _0x29c3[playerName] = nil
    _0x1d9f[playerName] = nil
    _0x6b24[playerName] = nil
    _0x4c7d[playerName] = nil
    _0x3e7a[playerName] = nil
end

local _0x1c9b = function()
    if not _0x4b2e._0x4e6a then return end
    
    for playerName, player in pairs(_0x29c3) do
        local box = _0x1d9f[playerName]
        local nameText = _0x6b24[playerName]
        local distText = _0x4c7d[playerName]
        local tracer = _0x3e7a[playerName]
        
        if box and nameText and distText and tracer then
            local char = player.Character
            
            if char then
                local charPos = _0x4a29(char)
                local distance = _0x5b0c(char)
                
                if distance <= _0x4b2e._0x3f8d then
                    local onScreen, screenPos = _0x2a9f(charPos)
                    
                    if onScreen then
                        local boxSize = _0x293b(distance)
                        local boxPos = Vector2.new(
                            screenPos.X - boxSize.X / 2,
                            screenPos.Y - boxSize.Y / 2
                        )
                        
                        local color = _0x3e1d(player) and _0x4b2e._0x2f6b or _0x4b2e._0x3a92
                        
                        box.Size = boxSize
                        box.Position = boxPos
                        box.Color = color
                        box.Visible = true
                        
                        nameText.Text = playerName
                        nameText.Position = Vector2.new(screenPos.X, boxPos.Y - 15)
                        nameText.Color = color
                        nameText.Visible = true
                        
                        if _0x4b2e._0x5e19 then
                            distText.Text = tostring(distance) .. " studs"
                            distText.Position = Vector2.new(screenPos.X, boxPos.Y + boxSize.Y + 5)
                            distText.Color = color
                            distText.Visible = true
                        else
                            distText.Visible = false
                        end
                        
                        if _0x4b2e._0x6c3e then
                            local screenSize = workspace.CurrentCamera.ViewportSize
                            tracer.From = Vector2.new(screenSize.X / 2, screenSize.Y)
                            tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                            tracer.Color = color
                            tracer.Visible = true
                        else
                            tracer.Visible = false
                        end
                    else
                        box.Visible = false
                        nameText.Visible = false
                        distText.Visible = false
                        tracer.Visible = false
                    end
                else
                    box.Visible = false
                    nameText.Visible = false
                    distText.Visible = false
                    tracer.Visible = false
                end
            else
                box.Visible = false
                nameText.Visible = false
                distText.Visible = false
                tracer.Visible = false
            end
        end
    end
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        _0x4d7a(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        _0x4d7a(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    _0x1862(player)
end)

local _0x5f9d = RunService.RenderStepped:Connect(function()
    _0x1c9b()
end)

return {
    espEnabled = function(value)
    if value ~= nil then
        _0x4b2e._0x4e6a = value
        
        -- Hide all ESP elements when disabled
        if not value then
            for playerName, box in pairs(_0x1d9f) do
                box.Visible = false
            end
            for playerName, nameText in pairs(_0x6b24) do
                nameText.Visible = false
            end
            for playerName, distText in pairs(_0x4c7d) do
                distText.Visible = false
            end
            for playerName, tracer in pairs(_0x3e7a) do
                tracer.Visible = false
            end
        end
    end
    return _0x4b2e._0x4e6a
end,
    
    distanceEnabled = function(value)
        if value ~= nil then
            _0x4b2e._0x5e19 = value
        end
        return _0x4b2e._0x5e19
    end,
    
    teamCheck = function(value)
        if value ~= nil then
            _0x4b2e._0x437a = value
        end
        return _0x4b2e._0x437a
    end,
    
    tracersEnabled = function(value)
        if value ~= nil then
            _0x4b2e._0x6c3e = value
        end
        return _0x4b2e._0x6c3e
    end,
    
    maxDistance = function(value)
        if type(value) == "number" and value > 0 then
            _0x4b2e._0x3f8d = value
        end
        return _0x4b2e._0x3f8d
    end,
    
    friendColor = function(color)
        if typeof(color) == "Color3" then
            _0x4b2e._0x2f6b = color
        end
        return _0x4b2e._0x2f6b
    end,
    
    enemyColor = function(color)
        if typeof(color) == "Color3" then
            _0x4b2e._0x3a92 = color
        end
        return _0x4b2e._0x3a92
    end,
    
    lineThickness = function(thickness)
        if type(thickness) == "number" and thickness > 0 then
            _0x4b2e._0x5d41 = thickness
            for _, box in pairs(_0x1d9f) do
                box.Thickness = thickness
            end
        end
        return _0x4b2e._0x5d41
    end,
    
    tracerThickness = function(thickness)
        if type(thickness) == "number" and thickness > 0 then
            _0x4b2e._0x1a9d = thickness
            for _, tracer in pairs(_0x3e7a) do
                tracer.Thickness = thickness
            end
        end
        return _0x4b2e._0x1a9d
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
        end
        return _0x4b2e._0x3b7d
    end,
    
    refresh = function()
        for playerName, _ in pairs(_0x29c3) do
            local player = game.Players:FindFirstChild(playerName)
            if player then
                _0x1862(player)
            end
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                _0x4d7a(player)
            end
        end
        
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
        for playerName, tracer in pairs(_0x3e7a) do
            tracer:Remove()
        end
        
        _0x29c3 = {}
        _0x1d9f = {}
        _0x6b24 = {}
        _0x4c7d = {}
        _0x3e7a = {}
        
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
        for playerName, tracer in pairs(_0x3e7a) do
            pcall(function() tracer:Remove() end)
        end
        
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
            tracersEnabled = _0x4b2e._0x6c3e,
            maxDistance = _0x4b2e._0x3f8d,
            friendColor = _0x4b2e._0x2f6b,
            enemyColor = _0x4b2e._0x3a92,
            lineThickness = _0x4b2e._0x5d41,
            tracerThickness = _0x4b2e._0x1a9d,
            fontSize = _0x4b2e._0x3b7d
        }
    end
}
