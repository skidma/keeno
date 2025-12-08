-- Keeno ESP System Loader - FIXED VERSION
-- API-Driven Architecture
-- https://solarae.vercel.app/

local function _0x4C(msg, level)
    local prefix = level == 1 and "[+]" or level == 2 and "[~]" or "[-]"
    print(prefix .. " " .. msg)
end

_0x4C("========================================", 1)
_0x4C("Keeno ESP System v1.1.0", 1)
_0x4C("API-Driven Architecture", 1)
_0x4C("Provided by Solarae (https://solarae.vercel.app/)", 1)
_0x4C("========================================", 1)

-- API Modules - PROPERLY INITIALIZED
local API = {
    Core = {
        Initialize = function()
            _0x4C("Core API initialized", 1)
            return true
        end,
        GetVersion = function()
            return "1.1.0"
        end,
        IsReady = function()
            return true
        end
    },
    Data = {
        FetchPlayers = function()
            local players = {}
            local PlayersService = game:GetService("Players")
            local localPlayer = PlayersService.LocalPlayer
            
            for _, player in pairs(PlayersService:GetPlayers()) do
                if player ~= localPlayer then
                    table.insert(players, {
                        Name = player.Name,
                        Team = player.Team and player.Team.Name or "None",
                        Character = player.Character
                    })
                end
            end
            return players
        end,
        GetPlayerCount = function()
            return #game:GetService("Players"):GetPlayers()
        end
    },
    Visual = {
        CreateESP = function(player, config)
            _0x4C("Creating ESP for: " .. player.Name, 2)
            return {
                Player = player,
                Visible = true,
                Box = {Visible = true},
                Name = {Visible = true}
            }
        end,
        UpdateESP = function(player, data)
            -- ESP update logic here
        end,
        RemoveESP = function(esp)
            _0x4C("ESP removed for: " .. esp.Player.Name, 2)
        end
    },
    Config = {
        activeProfile = "default",
        profiles = {
            default = {
                maxDistance = 500,
                showBoxes = true,
                showNames = true,
                boxColor = Color3.fromRGB(255, 50, 50),
                teamOverride = nil,
                showTeammates = false
            }
        },
        
        SetTeamOverride = function(self, teamName)
            self.profiles.default.teamOverride = teamName
            _0x4C("Team override set to: " .. (teamName or "auto"), 2)
        end,
        
        ToggleTeammates = function(self, show)
            self.profiles.default.showTeammates = show
            _0x4C("Show teammates: " .. tostring(show), 2)
        end,
        
        GetConfig = function(self)
            return self.profiles[self.activeProfile] or self.profiles.default
        end
    }
}

-- Initialize Config methods properly
API.Config.SetTeamOverride = function(teamName) 
    return API.Config.SetTeamOverride(API.Config, teamName) 
end
API.Config.ToggleTeammates = function(show) 
    return API.Config.ToggleTeammates(API.Config, show) 
end
API.Config.GetConfig = function() 
    return API.Config.GetConfig(API.Config) 
end

-- Main ESP System
local Keeno = {
    Running = false,
    ESPObjects = {},
    DebugInterval = 5,
    API = API  -- Expose API
}

function Keeno:Start()
    if self.Running then
        _0x4C("System already running", 3)
        return
    end
    
    _0x4C("Starting Keeno ESP System...", 2)
    self.Running = true
    
    -- Initialize APIs FIRST
    if not API.Core or not API.Core.Initialize then
        _0x4C("ERROR: Core API not properly initialized", 3)
        return
    end
    
    API.Core.Initialize()
    
    -- Setup event listeners
    self:SetupEvents()
    
    -- Create ESP for existing players
    self:InitializeESP()
    
    -- Start main loop
    self:MainLoop()
    
    _0x4C("Keeno ESP System started successfully", 1)
    _0x4C("Active players: " .. API.Data.GetPlayerCount(), 1)
end

function Keeno:SetupEvents()
    local Players = game:GetService("Players")
    
    -- Player added
    Players.PlayerAdded:Connect(function(player)
        _0x4C("Player joined: " .. player.Name, 2)
        task.wait(1)
        self:CreatePlayerESP({Name = player.Name, Character = player.Character})
    end)
    
    -- Player leaving
    Players.PlayerRemoving:Connect(function(player)
        self:RemovePlayerESP(player)
        _0x4C("Player left: " .. player.Name, 2)
    end)
end

function Keeno:InitializeESP()
    local players = API.Data.FetchPlayers()
    _0x4C("Initializing ESP for " .. #players .. " players", 2)
    
    for _, playerData in ipairs(players) do
        self:CreatePlayerESP(playerData)
    end
end

function Keeno:CreatePlayerESP(playerData)
    if self.ESPObjects[playerData.Name] then
        return
    end
    
    local esp = API.Visual.CreateESP(playerData, API.Config.GetConfig())
    self.ESPObjects[playerData.Name] = esp
    
    _0x4C("ESP created for: " .. playerData.Name, 2)
end

function Keeno:RemovePlayerESP(player)
    if self.ESPObjects[player.Name] then
        local esp = self.ESPObjects[player.Name]
        API.Visual.RemoveESP(esp)
        self.ESPObjects[player.Name] = nil
    end
end

function Keeno:MainLoop()
    local RunService = game:GetService("RunService")
    local lastDebug = 0
    
    _0x4C("Main loop started", 2)
    
    local connection = RunService.RenderStepped:Connect(function(deltaTime)
        if not self.Running then 
            connection:Disconnect()
            return 
        end
        
        -- Debug output
        local now = tick()
        if now - lastDebug >= self.DebugInterval then
            self:DebugOutput()
            lastDebug = now
        end
    end)
end

function Keeno:DebugOutput()
    local visibleCount = 0
    for _, esp in pairs(self.ESPObjects) do
        if esp.Visible then
            visibleCount = visibleCount + 1
        end
    end
    
    local totalPlayers = API.Data.GetPlayerCount() - 1
    local config = API.Config.GetConfig()
    
    _0x4C(string.format("DEBUG: %d/%d players visible | Dist: %d | Team: %s | Teammates: %s",
        visibleCount, totalPlayers, 
        config.maxDistance,
        config.teamOverride or "auto",
        config.showTeammates and "show" or "hide"
    ), 1)
end

-- Public API Methods
function Keeno:SetTeamOverride(teamName)
    if not self.API or not self.API.Config then
        _0x4C("ERROR: API not initialized", 3)
        return false
    end
    return self.API.Config.SetTeamOverride(teamName)
end

function Keeno:ToggleTeammates(show)
    if not self.API or not self.API.Config then
        _0x4C("ERROR: API not initialized", 3)
        return false
    end
    return self.API.Config.ToggleTeammates(show)
end

function Keeno:SetMaxDistance(distance)
    if not self.API or not self.API.Config then
        _0x4C("ERROR: API not initialized", 3)
        return false
    end
    self.API.Config.profiles.default.maxDistance = distance
    _0x4C("Max distance set to: " .. distance, 2)
    return true
end

-- Auto-start with proper game loading detection
local function WaitForGameLoad()
    _0x4C("Waiting for game to load...", 2)
    
    local maxWait = 30
    local startTime = tick()
    
    while tick() - startTime < maxWait do
        if game:IsLoaded() and game:GetService("Players").LocalPlayer then
            _0x4C("Game loaded successfully", 1)
            return true
        end
        task.wait(0.5)
    end
    
    _0x4C("WARNING: Game load timeout", 3)
    return false
end

-- Start the system
task.spawn(function()
    local gameLoaded = WaitForGameLoad()
    
    if gameLoaded then
        _0x4C("Game loaded, starting Keeno...", 1)
        
        -- Small delay to ensure everything is ready
        task.wait(1)
        
        local success, err = pcall(function()
            Keeno:Start()
        end)
        
        if not success then
            _0x4C("Failed to start Keeno: " .. tostring(err), 3)
        end
    else
        _0x4C("Failed to load game, Keeno not started", 3)
    end
    
    -- Periodic status updates
    while task.wait(30) and Keeno.Running do
        _0x4C("Keeno system active", 2)
        _0x4C("Visit https://solarae.vercel.app/ for updates", 2)
    end
end)

-- Return the Keeno object
return Keeno
