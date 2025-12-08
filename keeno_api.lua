-- keeno_api.lua - Core ESP System
-- [+] Provided to you by Solarae (https://solarae.vercel.app/)

local _0x4b33 = {_0x41a2={},_0x33c9={}}
local _0x1f7d = function(_0x5a6b) return game:GetService(_0x5a6b) end
local _0x2e8a = _0x1f7d('Players')
local _0x3b91 = _0x1f7d('RunService')
local _0x29d4 = _0x2e8a.LocalPlayer
local _0x17c3 = _0x29d4:GetMouse()

local _0x4f6d = function() return {} end
local _0x3c8a = function(_0x2a7e) return Drawing.new(_0x2a7e) end
local _0x5d12 = function(_0x1b9f,_0x4e2c) return Vector2.new(_0x1b9f,_0x4e2c) end
local _0x2b7f = function(_0x3d91) return _0x3d91.Character end
local _0x1e44 = function(_0x4a1b) return _0x4a1b:FindFirstChild('HumanoidRootPart') end

local _0x4b2e = {
    _0x437a = false,
    _0x5e19 = false,
    _0x3f8d = 1000,
    _0x29c3 = {},
    _0x1d9f = {},
    _0x6b24 = {},
    _0x4c7d = {},
    _0x2f6b = Color3.fromRGB(0, 255, 0),
    _0x3a92 = Color3.fromRGB(255, 0, 0),
    _0x5d41 = 2,
    _0x4e6a = true,
    _0x3b7d = 13
}

local _0x3e1d = function(_0x1c4a)
    if _0x1c4a == _0x29d4 then return true end
    if _0x4b2e._0x437a then return false end
    local _0x2d5f = _0x2d5f or _0x29d4.Team
    local _0x5f2c = _0x1c4a.Team
    return not _0x5f2c or _0x2d5f == _0x5f2c
end

local _0x5b0c = function(_0x4a9e)
    local _0x2c8b = _0x29d4.Character
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

local _0x4d7a = function(_0x2c3a)
    local _0x5a1f = _0x2c3a.Name
    _0x4b2e._0x29c3[_0x5a1f] = _0x2c3a
    
    local _0x1b6d = _0x3c8a('Square')
    _0x1b6d.Visible = false
    _0x1b6d.Thickness = _0x4b2e._0x5d41
    _0x1b6d.Filled = false
    _0x4b2e._0x1d9f[_0x5a1f] = _0x1b6d
    
    local _0x2e9f = _0x3c8a('Text')
    _0x2e9f.Visible = false
    _0x2e9f.Size = _0x4b2e._0x3b7d
    _0x2e9f.Center = true
    _0x2e9f.Outline = true
    _0x4b2e._0x6b24[_0x5a1f] = _0x2e9f
    
    local _0x5c34 = _0x3c8a('Text')
    _0x5c34.Visible = false
    _0x5c34.Size = _0x4b2e._0x3b7d - 2
    _0x5c34.Center = true
    _0x5c34.Outline = true
    _0x4b2e._0x4c7d[_0x5a1f] = _0x5c34
    
    print('[+] Created ESP for: ' .. _0x5a1f)
end

local _0x1c9b = function()
    for _0x3d8a, _0x5f6e in pairs(_0x4b2e._0x29c3) do
        local _0x27f8 = _0x2b7f(_0x5f6e)
        local _0x19b2 = _0x4b2e._0x1d9f[_0x3d8a]
        local _0x35e9 = _0x4b2e._0x6b24[_0x3d8a]
        local _0x4d1c = _0x4b2e._0x4c7d[_0x3d8a]
        
        if _0x19b2 and _0x35e9 and _0x4d1c then
            local _0x2e0a = false
            
            if _0x27f8 and _0x1e44(_0x27f8) then
                local _0x4a29 = _0x1e44(_0x27f8)
                local _0x375c, _0x1a4e = _0x2a9f(_0x4a29.Position)
                
                if _0x375c then
                    local _0x582d = _0x5b0c(_0x27f8)
                    
                    if _0x582d <= _0x4b2e._0x3f8d then
                        local _0x293b = 100 / _0x582d * 2
                        local _0x1638 = _0x5d12(_0x1a4e.X, _0x1a4e.Y)
                        
                        _0x19b2.Size = _0x5d12(_0x293b * 1.5, _0x293b * 2)
                        _0x19b2.Position = _0x5d12(_0x1638.X - _0x19b2.Size.X / 2, _0x1638.Y - _0x19b2.Size.Y / 2)
                        _0x19b2.Color = _0x3e1d(_0x5f6e) and _0x4b2e._0x2f6b or _0x4b2e._0x3a92
                        _0x19b2.Visible = true
                        
                        _0x35e9.Text = _0x3d8a
                        _0x35e9.Position = _0x5d12(_0x1638.X, _0x1638.Y - _0x19b2.Size.Y / 2 - 15)
                        _0x35e9.Color = _0x19b2.Color
                        _0x35e9.Visible = true
                        
                        if _0x4b2e._0x5e19 then
                            _0x4d1c.Text = tostring(_0x582d) .. ' studs'
                            _0x4d1c.Position = _0x5d12(_0x1638.X, _0x1638.Y + _0x19b2.Size.Y / 2 + 5)
                            _0x4d1c.Color = _0x19b2.Color
                            _0x4d1c.Visible = true
                        else
                            _0x4d1c.Visible = false
                        end
                        
                        _0x2e0a = true
                    end
                end
            end
            
            if not _0x2e0a then
                _0x19b2.Visible = false
                _0x35e9.Visible = false
                _0x4d1c.Visible = false
            end
        end
    end
end

local _0x493b = function(_0x2f38)
    if _0x2f38 ~= _0x29d4 then
        _0x4d7a(_0x2f38)
        print('[~] Player added: ' .. _0x2f38.Name)
    end
end

local _0x1862 = function(_0x3176)
    local _0x2bcd = _0x3176.Name
    if _0x4b2e._0x1d9f[_0x2bcd] then
        _0x4b2e._0x1d9f[_0x2bcd]:Remove()
        _0x4b2e._0x6b24[_0x2bcd]:Remove()
        _0x4b2e._0x4c7d[_0x2bcd]:Remove()
        _0x4b2e._0x29c3[_0x2bcd] = nil
        _0x4b2e._0x1d9f[_0x2bcd] = nil
        _0x4b2e._0x6b24[_0x2bcd] = nil
        _0x4b2e._0x4c7d[_0x2bcd] = nil
        print('[-] Player removed: ' .. _0x2bcd)
    end
end

local _0x5f9d = _0x3b91.RenderStepped:Connect(function()
    if _0x4b2e._0x4e6a then
        _0x1c9b()
    end
end)

for _, _0x14d6 in pairs(_0x2e8a:GetPlayers()) do
    if _0x14d6 ~= _0x29d4 then
        _0x4d7a(_0x14d6)
    end
end

_0x2e8a.PlayerAdded:Connect(_0x493b)
_0x2e8a.PlayerRemoving:Connect(_0x1862)

spawn(function()
    while wait(2) do
        if _0x4b2e._0x4e6a then
            local _0x2480 = 0
            for _0x3d8a, _0x19b2 in pairs(_0x4b2e._0x1d9f) do
                if _0x19b2.Visible then
                    _0x2480 = _0x2480 + 1
                end
            end
            print('[~] ESP Active: ' .. _0x2480 .. ' | Distance: ' .. _0x4b2e._0x3f8d .. ' | Team: ' .. tostring(_0x4b2e._0x437a))
        end
    end
end)

print('[+] Keeno ESP System Initialized')
print('[+] Provided to you by Solarae (https://solarae.vercel.app/)')

return {
    espEnabled = function(_0x4c1a)
        _0x4b2e._0x4e6a = _0x4c1a == nil and true or _0x4c1a
        print('[+] ESP ' .. (_0x4b2e._0x4e6a and 'enabled' or 'disabled'))
        return _0x4b2e._0x4e6a
    end,
    
    distanceEnabled = function(_0x3f97)
        _0x4b2e._0x5e19 = _0x3f97 == nil and true or _0x3f97
        print('[+] Distance ' .. (_0x4b2e._0x5e19 and 'enabled' or 'disabled'))
        return _0x4b2e._0x5e19
    end,
    
    teamCheck = function(_0x1d5b)
        _0x4b2e._0x437a = _0x1d5b == nil and true or _0x1d5b
        print('[+] Team check ' .. (_0x4b2e._0x437a and 'enabled' : 'disabled'))
        return _0x4b2e._0x437a
    end,
    
    maxDistance = function(_0x2c6e)
        if type(_0x2c6e) == 'number' and _0x2c6e > 0 then
            _0x4b2e._0x3f8d = _0x2c6e
            print('[+] Max distance: ' .. _0x2c6e)
        end
        return _0x4b2e._0x3f8d
    end,
    
    friendColor = function(_0x5b87)
        if typeof(_0x5b87) == 'Color3' then
            _0x4b2e._0x2f6b = _0x5b87
            print('[+] Friend color updated')
        end
        return _0x4b2e._0x2f6b
    end,
    
    enemyColor = function(_0x2e1c)
        if typeof(_0x2e1c) == 'Color3' then
            _0x4b2e._0x3a92 = _0x2e1c
            print('[+] Enemy color updated')
        end
        return _0x4b2e._0x3a92
    end,
    
    lineThickness = function(_0x3a5d)
        if type(_0x3a5d) == 'number' and _0x3a5d > 0 then
            _0x4b2e._0x5d41 = _0x3a5d
            for _, _0x19b2 in pairs(_0x4b2e._0x1d9f) do
                _0x19b2.Thickness = _0x3a5d
            end
            print('[+] Line thickness: ' .. _0x3a5d)
        end
        return _0x4b2e._0x5d41
    end,
    
    fontSize = function(_0x4f8e)
        if type(_0x4f8e) == 'number' and _0x4f8e > 0 then
            _0x4b2e._0x3b7d = _0x4f8e
            for _, _0x35e9 in pairs(_0x4b2e._0x6b24) do
                _0x35e9.Size = _0x4f8e
            end
            print('[+] Font size: ' .. _0x4f8e)
        end
        return _0x4b2e._0x3b7d
    end,
    
    refresh = function()
        for _0x3d8a, _0x5f6e in pairs(_0x4b2e._0x29c3) do
            _0x1862(_0x5f6e)
        end
        for _, _0x14d6 in pairs(_0x2e8a:GetPlayers()) do
            if _0x14d6 ~= _0x29d4 then
                _0x4d7a(_0x14d6)
            end
        end
        print('[+] ESP refreshed')
        return true
    end,
    
    clear = function()
        for _0x3d8a, _0x19b2 in pairs(_0x4b2e._0x1d9f) do
            _0x19b2:Remove()
        end
        for _0x3d8a, _0x35e9 in pairs(_0x4b2e._0x6b24) do
            _0x35e9:Remove()
        end
        for _0x3d8a, _0x4d1c in pairs(_0x4b2e._0x4c7d) do
            _0x4d1c:Remove()
        end
        
        _0x4b2e._0x29c3 = {}
        _0x4b2e._0x1d9f = {}
        _0x4b2e._0x6b24 = {}
        _0x4b2e._0x4c7d = {}
        
        print('[+] ESP cleared')
        return true
    end,
    
    destroy = function()
        _0x5f9d:Disconnect()
        _0x4b2e._0x4e6a = false
        
        for _0x3d8a, _0x19b2 in pairs(_0x4b2e._0x1d9f) do
            pcall(function() _0x19b2:Remove() end)
        end
        for _0x3d8a, _0x35e9 in pairs(_0x4b2e._0x6b24) do
            pcall(function() _0x35e9:Remove() end)
        end
        for _0x3d8a, _0x4d1c in pairs(_0x4b2e._0x4c7d) do
            pcall(function() _0x4d1c:Remove() end)
        end
        
        print('[-] Keeno ESP destroyed')
        return true
    end,
    
    getActivePlayers = function()
        local _0x2a5c = {}
        for _0x3d8a, _0x19b2 in pairs(_0x4b2e._0x1d9f) do
            if _0x19b2.Visible then
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
            maxDistance = _0x4b2e._0x3f8d,
            friendColor = _0x4b2e._0x2f6b,
            enemyColor = _0x4b2e._0x3a92,
            lineThickness = _0x4b2e._0x5d41,
            fontSize = _0x4b2e._0x3b7d
        }
    end
}
