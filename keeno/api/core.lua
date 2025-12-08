-- Keeno API Core v1.0.0
-- https://solarae.vercel.app/

local _0x4B33 = {
    _VERSION = "1.0.0",
    _API_URL = "https://api.solarae.vercel.app/keeno",
    _DEBUG = true
}

local function _0x4C(msg, level)
    local prefixes = { [1] = "[+]", [2] = "[~]", [3] = "[-]" }
    local prefix = prefixes[level] or "[*]"

    local timestamp = os.date("%H:%M:%S")
    local formatted = string.format("%s %s %s", prefix, timestamp, msg)

    print(formatted)

    -- Send to debug API if enabled
    if _0x4B33._DEBUG then
        pcall(function()
            game:HttpGet(_0x4B33._API_URL .. "/log?msg=" .. msg .. "&level=" .. level)
        end)
    end

    return formatted
end

-- API Registry
local _0x41 = {
    Modules = {},
    Events = {},
    Configs = {},
    Players = {}
}

-- Core API Methods
function _0x4B33:RegisterModule(name, module)
    _0x41.Modules[name] = module
    _0x4C("Module registered: " .. name, 2)
    return true
end

function _0x4B33:GetModule(name)
    return _0x41.Modules[name]
end

function _0x4B33:GetAllPlayers()
    return game:GetService("Players"):GetPlayers()
end

function _0x4B33:GetLocalPlayer()
    return game:GetService("Players").LocalPlayer
end

function _0x4B33:IsInGame()
    return game:GetService("Players").LocalPlayer ~= nil
end

-- Initialize API
function _0x4B33:Initialize()
    _0x4C("Keeno API Initializing...", 1)
    _0x4C("Provided by Solarae (https://solarae.vercel.app/)", 1)

    -- Check game state
    if not self:IsInGame() then
        _0x4C("Not in game, waiting...", 2)
        game:GetService("Players").LocalPlayerAdded:Wait()
    end

    -- Load configuration
    self:LoadConfiguration()

    _0x4C("Keeno API v" .. self._VERSION .. " ready", 1)
    return true
end

function _0x4B33:LoadConfiguration()
    -- Try to fetch from API first
    local success, config = pcall(function()
        return game:HttpGet(self._API_URL .. "/config/default")
    end)

    if success and config then
        _0x41.Configs.default = game:GetService("HttpService"):JSONDecode(config)
        _0x4C("Configuration loaded from API", 1)
    else
        -- Fallback to local config
        _0x41.Configs.default = {
            esp = { enabled = true, maxDistance = 500 },
            boxes = { enabled = true, color = "#FF3366" },
            names = { enabled = true, showDistance = true },
            team = { detect = true, override = nil }
        }
        _0x4C("Using local configuration", 2)
    end
end

return _0x4B33
