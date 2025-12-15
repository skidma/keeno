# Keeno

## Information
Keeno is a powerful library designed for Roblox cheat developers to make developing cheats faster and easier.

## Table of Contents
- [Installation](#installation)
- [Quick Start](#quick-start)
- [API Reference](#api-reference)
- [Configuration](#configuration-properties)
- [Visual Settings](#visual-settings)
- [Methods](#methods)
- [UI Integration](#ui-integration)

## Installation

```lua
local keeno = loadstring(game:HttpGet("https://raw.githubusercontent.com/skidma/keeno/main/keeno.lua"))()
```

## Quick Start
```lua
local keeno = loadstring(game:HttpGet("https://raw.githubusercontent.com/skidma/keeno/main/keeno.lua"))()

keeno.espEnabled = true
keeno.teamCheck = true
keeno.maxDistance = 1000
```

## API Reference

### Configuration Properties
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `keeno.espEnabled` | boolean | `true` | Enable ESP |
| `keeno.distanceEnabled` | boolean | `false` | Show distance below player names |
| `keeno.teamCheck` | boolean | `false` | Color teammates green, enemies red |
| `keeno.tracersEnabled` | boolean | `false` | Draw lines from bottom of screen |
| `keeno.maxDistance` | number | `1000` | Max render distance in studs |

### Visual Settings
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `keeno.friendColor` | Color3 | `Color3.fromRGB(0, 255, 0)` | Color for teammates |
| `keeno.enemyColor` | Color3 | `Color3.fromRGB(255, 0, 0)` | Color for enemies |
| `keeno.lineThickness` | number | `2` | Box border thickness (1-5) |
| `keeno.tracerThickness` | number | `1` | Tracer line thickness (1-5) |
| `keeno.fontSize` | number | `13` | Text size for names/distances (10-20) |

### Methods

```lua
-- Refresh player list (use when players join/leave)
keeno:refresh()

-- Clears all ESP elements
keeno:clear()

-- destroys ESP 
keeno:destroy()

-- Gets all visible players
local visiblePlayers = keeno:getActivePlayers()
-- Returns: {"Player1", "Player2", "Player3"}

-- Gets users current settings
local settings = keeno:getSettings()
-- Returns: {espEnabled=true, maxDistance=1000, teamCheck=false, etc.}
```

### Range Limits
```lua
keeno.maxDistance         = 100-5000      -- Studs
keeno.lineThickness       = 1-5           -- Pixels
keeno.tracerThickness     = 1-5           -- Pixels
keeno.fontSize            = 10-20         -- Points

keeno.espEnabled          = true/false
keeno.distanceEnabled     = true/false
keeno.teamCheck           = true/false
keeno.tracersEnabled      = true/false
```

### Color References
```lua
Color3.fromRGB(255, 0, 0)       -- Red
Color3.fromRGB(0, 255, 0)       -- Green
Color3.fromRGB(0, 0, 255)       -- Blue
Color3.fromRGB(255, 255, 0)     -- Yellow
Color3.fromRGB(255, 0, 255)     -- Magenta
Color3.fromRGB(0, 255, 255)     -- Cyan
Color3.fromRGB(255, 165, 0)     -- Orange
Color3.fromRGB(128, 0, 128)     -- Purple
Color3.fromRGB(255, 192, 203)   -- Pink
Color3.fromRGB(255, 255, 255)   -- White
Color3.fromRGB(0, 0, 0)         -- Black
Color3.fromRGB(128, 128, 128)   -- Gray
```

### UI Integration
> as basic as possible might be a little different depending on the UI library that you're using. 
```lua
local Tab = Window:NewTab("ESP")
local Section = Tab:NewSection("Settings")

Section:NewToggle("Enable ESP", "Toggle ESP", function(state)
    keeno.espEnabled = state
end)

Section:NewToggle("Show Distance", "Show distance", function(state)
    keeno.distanceEnabled = state
end)

Section:NewToggle("Team Check", "Team colors", function(state)
    keeno.teamCheck = state
end)

Section:NewToggle("Tracers", "Show tracers", function(state)
    keeno.tracersEnabled = state
end)

Section:NewSlider("Max Distance", "Distance limit", 5000, 100, function(value)
    keeno.maxDistance = value
end)

Section:NewSlider("Line Thickness", "Box thickness", 5, 1, function(value)
    keeno.lineThickness = value
end)

Section:NewColorPicker("Friend Color", "Teammate color", keeno.friendColor, function(color)
    keeno.friendColor = color
end)

Section:NewColorPicker("Enemy Color", "Enemy color", keeno.enemyColor, function(color)
    keeno.enemyColor = color
end)

Section:NewButton("Refresh", "Refresh players", function()
    keeno:refresh()
end)

Section:NewButton("Clear", "Clear ESP", function()
    keeno:clear()
end)

local HotkeyTab = Window:NewTab("Hotkeys")
local HotkeySection = HotkeyTab:NewSection("Controls")

HotkeySection:NewKeybind("Toggle ESP", "Toggle ESP", Enum.KeyCode.Insert, function()
    keeno.espEnabled = not keeno.espEnabled
end)

HotkeySection:NewKeybind("Toggle UI", "Show/hide menu", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)
```
