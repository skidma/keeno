local _0x56 = {}
local Drawing = Drawing

local _0x45 = {} -- ESP Objects storage

-- Color conversion utilities
function _0x56:HexToColor(hex)
    hex = hex:gsub("#", "")
    return Color3.fromRGB(
        tonumber(hex:sub(1, 2), 16),
        tonumber(hex:sub(3, 4), 16),
        tonumber(hex:sub(5, 6), 16)
    )
end

-- ESP Object Management
function _0x56:CreateESPObject(player)
    if _0x45[player] then
        self:RemoveESPObject(player)
    end

    local esp = {
        Box = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        HealthBar = Drawing.new("Square"),
        HealthText = Drawing.new("Text"),
        Player = player
    }

    -- Configure box
    esp.Box.Thickness = 2
    esp.Box.Filled = false
    esp.Box.ZIndex = 1

    -- Configure name
    esp.Name.Size = 14
    esp.Name.Center = true
    esp.Name.Outline = true
    esp.Name.Font = 2
    esp.Name.ZIndex = 2

    -- Configure health bar
    esp.HealthBar.Thickness = 1
    esp.HealthBar.Filled = true
    esp.HealthBar.ZIndex = 0

    -- Configure health text
    esp.HealthText.Size = 12
    esp.HealthText.Center = true
    esp.HealthText.Outline = true
    esp.HealthText.Font = 2
    esp.HealthText.ZIndex = 2

    _0x45[player] = esp
    return esp
end

function _0x56:UpdateESP(player, config)
    local esp = _0x45[player]
    if not esp then return end

    local playerData = self:GetPlayerData(player)
    if not playerData then return end

    -- World to screen calculation
    local camera = workspace.CurrentCamera
    local screenPos, onScreen = camera:WorldToViewportPoint(playerData.Position)

    if onScreen and playerData.Distance <= config.maxDistance then
        -- Box calculations
        local scale = 1000 / screenPos.Z
        local width = config.boxWidth * scale
        local height = config.boxHeight * scale

        -- Update box
        esp.Box.Size = Vector2.new(width, height)
        esp.Box.Position = Vector2.new(screenPos.X - width / 2, screenPos.Y - height / 2)
        esp.Box.Color = self:HexToColor(config.boxColor)
        esp.Box.Visible = config.showBoxes

        -- Update name
        local nameText = playerData.Player.Name
        if config.showDistance then
            nameText = nameText .. " [" .. playerData.Distance .. "m]"
        end

        esp.Name.Text = nameText
        esp.Name.Position = Vector2.new(screenPos.X, screenPos.Y - height / 2 - 15)
        esp.Name.Color = Color3.new(1, 1, 1)
        esp.Name.Visible = config.showNames

        -- Update health bar
        if config.showHealth then
            local healthPercent = playerData.Health / playerData.MaxHealth
            local healthWidth = width * healthPercent
            local healthHeight = 3

            esp.HealthBar.Size = Vector2.new(healthWidth, healthHeight)
            esp.HealthBar.Position = Vector2.new(
                screenPos.X - width / 2,
                screenPos.Y + height / 2 + 2
            )

            -- Health bar color gradient
            local healthColor = Color3.new(
                2 * (1 - healthPercent),
                2 * healthPercent,
                0
            ):Clamp(Color3.new(0, 0, 0), Color3.new(1, 1, 1))

            esp.HealthBar.Color = healthColor
            esp.HealthBar.Visible = true

            -- Health text
            esp.HealthText.Text = math.floor(playerData.Health) .. "/" .. math.floor(playerData.MaxHealth)
            esp.HealthText.Position = Vector2.new(screenPos.X, screenPos.Y + height / 2 + 10)
            esp.HealthText.Color = healthColor
            esp.HealthText.Visible = true
        else
            esp.HealthBar.Visible = false
            esp.HealthText.Visible = false
        end
    else
        -- Hide if not on screen
        esp.Box.Visible = false
        esp.Name.Visible = false
        esp.HealthBar.Visible = false
        esp.HealthText.Visible = false
    end
end

function _0x56:RemoveESPObject(player)
    local esp = _0x45[player]
    if esp then
        esp.Box:Remove()
        esp.Name:Remove()
        esp.HealthBar:Remove()
        esp.HealthText:Remove()
        _0x45[player] = nil
    end
end

function _0x56:ClearAllESP()
    for player, esp in pairs(_0x45) do
        self:RemoveESPObject(player)
    end
end

return _0x56
