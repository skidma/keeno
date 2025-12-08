local _0x43 = {}
local HttpService = game:GetService("HttpService")

local _0x53 = {
    active = "default",
    profiles = {
        default = {
            esp = {
                enabled = true,
                maxDistance = 500,
                updateInterval = 0.1
            },
            visual = {
                showBoxes = true,
                showNames = true,
                showHealth = true,
                showDistance = true,
                boxColor = "#FF3366",
                boxWidth = 4,
                boxHeight = 6
            },
            team = {
                detect = true,
                override = nil,
                showTeammates = false,
                enemyColor = "#FF3366",
                teammateColor = "#33FF66"
            },
            debug = {
                enabled = true,
                consoleLevel = 1, -- 1=minimal, 2=verbose, 3=everything
                performance = true
            }
        }
    }
}

function _0x43:GetConfig(profile)
    return _0x53.profiles[profile or _0x53.active] or _0x53.profiles.default
end

function _0x43:UpdateConfig(profile, updates)
    if not _0x53.profiles[profile] then
        _0x53.profiles[profile] = {}
    end

    for key, value in pairs(updates) do
        _0x53.profiles[profile][key] = value
    end

    return true
end

function _0x43:SetActiveProfile(profile)
    if _0x53.profiles[profile] then
        _0x53.active = profile
        return true
    end
    return false
end

function _0x43:CreateProfile(name, baseProfile)
    if _0x53.profiles[name] then
        return false, "Profile already exists"
    end

    _0x53.profiles[name] = HttpService:JSONDecode(
        HttpService:JSONEncode(_0x53.profiles[baseProfile or "default"])
    )

    return true
end

function _0x43:DeleteProfile(name)
    if name == "default" then
        return false, "Cannot delete default profile"
    end

    _0x53.profiles[name] = nil
    if _0x53.active == name then
        _0x53.active = "default"
    end

    return true
end

function _0x43:ExportProfile(profile)
    return HttpService:JSONEncode(_0x53.profiles[profile or _0x53.active])
end

function _0x43:ImportProfile(name, jsonConfig)
    local success, config = pcall(function()
        return HttpService:JSONDecode(jsonConfig)
    end)

    if success then
        _0x53.profiles[name] = config
        return true
    end

    return false, "Invalid JSON configuration"
end

function _0x43:GetAllProfiles()
    local profiles = {}
    for name in pairs(_0x53.profiles) do
        table.insert(profiles, name)
    end
    return profiles
end

-- Remote configuration sync
function _0x43:LoadFromAPI(url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        return self:ImportProfile("remote", response)
    end

    return false, "Failed to load from API"
end

return _0x43
