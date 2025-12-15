-- keeno_api.lua 
-- [+] Provided to you by Solarae (https://solarae.vercel.app/)

local _0x1a3f = {_0x4c2a={},_0x5d1e={}}
local _0x3b7c = function(_0x2e9a) return game:GetService(_0x2e9a) end
local _0x5f29 = _0x3b7c('Players')
local _0x4a8d = _0x3b7c('RunService')
local _0x1c4b = _0x5f29.LocalPlayer
local _0x6d2e = _0x1c4b:GetMouse()

local _0x2b5a = function() return {} end
local _0x4e1f = function(_0x1d3c) return Drawing.new(_0x1d3c) end
local _0x5d12 = function(_0x3a9b,_0x4e2c) return Vector2.new(_0x3a9b,_0x4e2c) end
local _0x2b7f = function(_0x3d91) return _0x3d91.Character end
local _0x1e44 = function(_0x4a1b) return _0x4a1b:FindFirstChild('HumanoidRootPart') end
local _0x6a3d = function(_0x5c77) return _0x5c77:FindFirstChildOfClass('Humanoid') end

local _0x4b2e = {
    _0x4e6a = true,
    _0x5e19 = false,
    _0x437a = false,
    _0x6c3e = false,
    _0x3f8d = 1000,
    _0x2f6b = Color3.fromRGB(0, 255, 0),
    _0x3a92 = Color3.fromRGB(255, 0, 0),
    _0x5d41 = 2,
    _0x1a9d = 1,
    _0x3b7d = 13
}

local _0x29c3 = {}
local _0x1d9f = {}
local _0x6b24 = {}
local _0x4c7d = {}
local _0x3e7a = {}

local _0x3e1d = function(_0x1c4a)
    if _0x1c4a == _0x1c4b then return true end
    if _0x4b2e._0x437a then return false end
    local _0x2d5f = _0x2d5f or _0x1c4b.Team
    local _0x5f2c = _0x1c4a.Team
    return not _0x5f2c or _0x2d5f == _0x5f2c
end

local _0x5b0c = function(_0x4a9e)
    local _0x2c8b = _0x1c4b.Character
    if not _0x2c8b or not _0x4a9e then return 0 end
    local _0x3c1d = _0x1e44(_0x2c8b)
    local _0x1f2b = _0x1e44(_0x4a9e)
    if not _0x3c1d or not _0x1f2b then return 0 end
    return math.floor((_0x3c1d.Position - _0x1f2b.Position).Magnitude)
end

local _0x2a9f = function(_0x4f2d)
    local _0x3e7b, _0x4c02 = workspace.CurrentCamera:WorldToViewportPoint(_0x4f2d)
    return _0x3e7b, _0x5d12(_0x4c02.X, _0x4c02.Y)
end

local _0x4a29 = function(_0x2d78)
    if not _0x2d78 then return Vector3.new(0,0,0) end
    local _0x40c7 = _0x1e44(_0x2d78)
    return _0x40c7 and _0x40c7.Position or Vector3.new(0,0,0)
end

local _0x293b = function(_0x582d)
    _0x582d = math.max(_0x582d, 1)
    local _0x4f8e = 2000 / _0x582d
    _0x4f8e = math.clamp(_0x4f8e, 15, 80)
    return _0x5d12(_0x4f8e * 0.6, _0x4f8e)
end

local _0x5c1f = function()
    for _0x3d8a, _0x19b2 in pairs(_0x1d9f) do
        if _0x19b2 then _0x19b2.Visible = false end
    end
    for _0x3d8a, _0x35e9 in pairs(_0x6b24) do
        if _0x35e9 then _0x35e9.Visible = false end
    end
    for _0x3d8a, _0x4d1c in pairs(_0x4c7d) do
        if _0x4d1c then _0x4d1c.Visible = false end
    end
    for _0x3d8a, _0x3e7b in pairs(_0x3e7a) do
        if _0x3e7b then _0x3e7b.Visible = false end
    end
end

local _0x4d7a = function(_0x2c3a)
    local _0x5a1f = _0x2c3a.Name
    _0x29c3[_0x5a1f] = _0x2c3a
    
    local _0x1b6d = _0x4e1f('Square')
    _0x1b6d.Visible = false
    _0x1b6d.Thickness = _0x4b2e._0x5d41
    _0x1b6d.Filled = false
    _0x1d9f[_0x5a1f] = _0x1b6d
    
    local _0x2e9f = _0x4e1f('Text')
    _0x2e9f.Visible = false
    _0x2e9f.Size = _0x4b2e._0x3b7d
    _0x2e9f.Center = true
    _0x2e9f.Outline = true
    _0x2e9f.Font = 2
    _0x6b24[_0x5a1f] = _0x2e9f
    
    local _0x5c34 = _0x4e1f('Text')
    _0x5c34.Visible = false
    _0x5c34.Size = _0x4b2e._0x3b7d - 2
    _0x5c34.Center = true
    _0x5c34.Outline = true
    _0x5c34.Font = 2
    _0x4c7d[_0x5a1f] = _0x5c34
    
    local _0x3b91 = _0x4e1f('Line')
    _0x3b91.Visible = false
    _0x3b91.Thickness = _0x4b2e._0x1a9d
    _0x3e7a[_0x5a1f] = _0x3b91
end

local _0x1862 = function(_0x3176)
    local _0x2bcd = _0x3176.Name
    if _0x1d9f[_0x2bcd] then
        pcall(function() _0x1d9f[_0x2bcd]:Remove() end)
        _0x1d9f[_0x2bcd] = nil
    end
    if _0x6b24[_0x2bcd] then
        pcall(function() _0x6b24[_0x2bcd]:Remove() end)
        _0x6b24[_0x2bcd] = nil
    end
    if _0x4c7d[_0x2bcd] then
        pcall(function() _0x4c7d[_0x2bcd]:Remove() end)
        _0x4c7d[_0x2bcd] = nil
    end
    if _0x3e7a[_0x2bcd] then
        pcall(function() _0x3e7a[_0x2bcd]:Remove() end)
        _0x3e7a[_0x2bcd] = nil
    end
    _0x29c3[_0x2bcd] = nil
end

local _0x1c9b = function()
    if not _0x4b2e._0x4e6a then
        _0x5c1f()
        return
    end
    
    for _0x3d8a, _0x5f6e in pairs(_0x29c3) do
        local _0x19b2 = _0x1d9f[_0x3d8a]
        local _0x35e9 = _0x6b24[_0x3d8a]
        local _0x4d1c = _0x4c7d[_0x3d8a]
        local _0x3e7b = _0x3e7a[_0x3d8a]
        
        if _0x19b2 and _0x35e9 and _0x4d1c and _0x3e7b then
            local _0x27f8 = _0x2b7f(_0x5f6e)
            
            if _0x27f8 then
                local _0x4a29 = _0x4a29(_0x27f8)
                local _0x582d = _0x5b0c(_0x27f8)
                
                if _0x582d <= _0x4b2e._0x3f8d then
                    local _0x375c, _0x1a4e = _0x2a9f(_0x4a29)
                    
                    if _0x375c then
                        local _0x293b = _0x293b(_0x582d)
                        local _0x1638 = _0x5d12(_0x1a4e.X, _0x1a4e.Y)
                        
                        local _0x2f6b = _0x3e1d(_0x5f6e) and _0x4b2e._0x2f6b or _0x4b2e._0x3a92
                        
                        _0x19b2.Size = _0x293b
                        _0x19b2.Position = _0x5d12(_0x1638.X - _0x293b.X / 2, _0x1638.Y - _0x293b.Y / 2)
                        _0x19b2.Color = _0x2f6b
                        _0x19b2.Visible = true
                        
                        _0x35e9.Text = _0x3d8a
                        _0x35e9.Position = _0x5d12(_0x1638.X, _0x1638.Y - _0x293b.Y / 2 - 15)
                        _0x35e9.Color = _0x2f6b
                        _0x35e9.Visible = true
                        
                        if _0x4b2e._0x5e19 then
                            _0x4d1c.Text = tostring(_0x582d) .. ' studs'
                            _0x4d1c.Position = _0x5d12(_0x1638.X, _0x1638.Y + _0x293b.Y / 2 + 5)
                            _0x4d1c.Color = _0x2f6b
                            _0x4d1c.Visible = true
                        else
                            _0x4d1c.Visible = false
                        end
                        
                        if _0x4b2e._0x6c3e then
                            local _0x3b91 = workspace.CurrentCamera.ViewportSize
                            _0x3e7b.From = _0x5d12(_0x3b91.X / 2, _0x3b91.Y)
                            _0x3e7b.To = _0x5d12(_0x1638.X, _0x1638.Y)
                            _0x3e7b.Color = _0x2f6b
                            _0x3e7b.Visible = true
                        else
                            _0x3e7b.Visible = false
                        end
                    else
                        _0x19b2.Visible = false
                        _0x35e9.Visible = false
                        _0x4d1c.Visible = false
                        _0x3e7b.Visible = false
                    end
                else
                    _0x19b2.Visible = false
                    _0x35e9.Visible = false
                    _0x4d1c.Visible = false
                    _0x3e7b.Visible = false
                end
            else
                _0x19b2.Visible = false
                _0x35e9.Visible = false
                _0x4d1c.Visible = false
                _0x3e7b.Visible = false
            end
        end
    end
end

for _, _0x14d6 in pairs(_0x5f29:GetPlayers()) do
    if _0x14d6 ~= _0x1c4b then
        _0x4d7a(_0x14d6)
    end
end

_0x5f29.PlayerAdded:Connect(function(_0x2f38)
    if _0x2f38 ~= _0x1c4b then
        _0x4d7a(_0x2f38)
    end
end)

_0x5f29.PlayerRemoving:Connect(function(_0x3176)
    _0x1862(_0x3176)
end)

local _0x5f9d = _0x4a8d.RenderStepped:Connect(function()
    _0x1c9b()
end)

return {
    espEnabled = function(_0x4c1a)
        if _0x4c1a ~= nil then
            _0x4b2e._0x4e6a = _0x4c1a
            if not _0x4c1a then
                _0x5c1f()
            end
        end
        return _0x4b2e._0x4e6a
    end,
    
    distanceEnabled = function(_0x3f97)
        if _0x3f97 ~= nil then
            _0x4b2e._0x5e19 = _0x3f97
        end
        return _0x4b2e._0x5e19
    end,
    
    teamCheck = function(_0x1d5b)
        if _0x1d5b ~= nil then
            _0x4b2e._0x437a = _0x1d5b
        end
        return _0x4b2e._0x437a
    end,
    
    tracersEnabled = function(_0x6c3e)
        if _0x6c3e ~= nil then
            _0x4b2e._0x6c3e = _0x6c3e
        end
        return _0x4b2e._0x6c3e
    end,
    
    maxDistance = function(_0x2c6e)
        if type(_0x2c6e) == 'number' and _0x2c6e > 0 then
            _0x4b2e._0x3f8d = _0x2c6e
        end
        return _0x4b2e._0x3f8d
    end,
    
    friendColor = function(_0x5b87)
        if typeof(_0x5b87) == 'Color3' then
            _0x4b2e._0x2f6b = _0x5b87
        end
        return _0x4b2e._0x2f6b
    end,
    
    enemyColor = function(_0x2e1c)
        if typeof(_0x2e1c) == 'Color3' then
            _0x4b2e._0x3a92 = _0x2e1c
        end
        return _0x4b2e._0x3a92
    end,
    
    lineThickness = function(_0x3a5d)
        if type(_0x3a5d) == 'number' and _0x3a5d > 0 then
            _0x4b2e._0x5d41 = _0x3a5d
            for _, _0x19b2 in pairs(_0x1d9f) do
                if _0x19b2 then
                    _0x19b2.Thickness = _0x3a5d
                end
            end
        end
        return _0x4b2e._0x5d41
    end,
    
    tracerThickness = function(_0x1a9d)
        if type(_0x1a9d) == 'number' and _0x1a9d > 0 then
            _0x4b2e._0x1a9d = _0x1a9d
            for _, _0x3e7b in pairs(_0x3e7a) do
                if _0x3e7b then
                    _0x3e7b.Thickness = _0x1a9d
                end
            end
        end
        return _0x4b2e._0x1a9d
    end,
    
    fontSize = function(_0x4f8e)
        if type(_0x4f8e) == 'number' and _0x4f8e > 0 then
            _0x4b2e._0x3b7d = _0x4f8e
            for _, _0x35e9 in pairs(_0x6b24) do
                if _0x35e9 then
                    _0x35e9.Size = _0x4f8e
                end
            end
            for _, _0x4d1c in pairs(_0x4c7d) do
                if _0x4d1c then
                    _0x4d1c.Size = _0x4f8e - 2
                end
            end
        end
        return _0x4b2e._0x3b7d
    end,
    
    refresh = function()
        for _0x3d8a, _ in pairs(_0x29c3) do
            local _0x5f6e = _0x5f29:FindFirstChild(_0x3d8a)
            if _0x5f6e then
                _0x1862(_0x5f6e)
            end
        end
        
        for _, _0x14d6 in pairs(_0x5f29:GetPlayers()) do
            if _0x14d6 ~= _0x1c4b then
                _0x4d7a(_0x14d6)
            end
        end
        
        return true
    end,
    
    clear = function()
        for _0x3d8a, _0x19b2 in pairs(_0x1d9f) do
            if _0x19b2 then
                pcall(function() _0x19b2:Remove() end)
            end
        end
        for _0x3d8a, _0x35e9 in pairs(_0x6b24) do
            if _0x35e9 then
                pcall(function() _0x35e9:Remove() end)
            end
        end
        for _0x3d8a, _0x4d1c in pairs(_0x4c7d) do
            if _0x4d1c then
                pcall(function() _0x4d1c:Remove() end)
            end
        end
        for _0x3d8a, _0x3e7b in pairs(_0x3e7a) do
            if _0x3e7b then
                pcall(function() _0x3e7b:Remove() end)
            end
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
        _0x5c1f()
        return true
    end,
    
    getActivePlayers = function()
        local _0x2a5c = {}
        for _0x3d8a, _0x19b2 in pairs(_0x1d9f) do
            if _0x19b2 and _0x19b2.Visible then
                table.insert(_0x2a5c, _0x3d8a)
            end
        end
        return _0x2a5c
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
