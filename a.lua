repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.GameId ~= 0

if Parvus and Parvus.Loaded then
    if Parvus.Utilities and Parvus.Utilities.UI then
        Parvus.Utilities.UI:Push({
            Title = "Parvus Hub",
            Description = "Script already running!",
            Duration = 5
        })
    end
    return
end

local PlayerService = game:GetService("Players")
repeat task.wait() until PlayerService.LocalPlayer
local LocalPlayer = PlayerService.LocalPlayer

local Branch = ... or "main"
local NotificationTime = ... or 5
local IsLocal = ... or false
local QueueOnTeleport = queue_on_teleport or function() end

local function GetFile(File)
    local success, result = pcall(function()
        if IsLocal then
            return readfile("Parvus/" .. File)
        else
            return game:HttpGet(("%s%s"):format(Parvus.Source, File))
        end
    end)
    if success then
        return result
    else
        warn("Failed to get file: " .. File)
        return nil
    end
end

local function LoadScript(Script)
    local fileContent = GetFile(Script .. ".lua")
    if not fileContent then
        warn("Failed to load: " .. Script)
        return nil
    end
    
    local success, func = pcall(loadstring, fileContent, Script)
    if success and func then
        local execSuccess, result = pcall(func)
        if execSuccess then
            return result
        else
            warn("Failed to execute: " .. Script .. " - " .. result)
            return nil
        end
    else
        warn("Failed to compile: " .. Script .. " - " .. tostring(func))
        return nil
    end
end

local function GetGameInfo()
    for Id, Info in pairs(Parvus.Games) do
        if tostring(game.GameId) == Id then
            return Info
        end
    end
    return Parvus.Games.Universal
end

-- Initialize Parvus table FIRST
getgenv().Parvus = {
    Source = "https://raw.githubusercontent.com/AlexR32/Parvus/" .. Branch .. "/",
    Utilities = {},  -- Initialize empty table
    Games = {
        ["Universal" ] = { Name = "Universal",                  Script = "Universal"  },
        ["1168263273"] = { Name = "Bad Business",               Script = "Games/BB"   },
        ["3360073263"] = { Name = "Bad Business PTR",           Script = "Games/BB"   },
        ["1586272220"] = { Name = "Steel Titans",               Script = "Games/ST"   },
        ["807930589" ] = { Name = "The Wild West",              Script = "Games/TWW"  },
        ["580765040" ] = { Name = "RAGDOLL UNIVERSE",           Script = "Games/RU"   },
        ["187796008" ] = { Name = "Those Who Remain",           Script = "Games/TWR"  },
        ["358276974" ] = { Name = "Apocalypse Rising 2",        Script = "Games/AR2"  },
        ["3495983524"] = { Name = "Apocalypse Rising 2 Dev.",   Script = "Games/AR2"  },
        ["1054526971"] = { Name = "Blackhawk Rescue Mission 5", Script = "Games/BRM5" }
    }
}

-- Now load utilities with proper error handling
local MainUtil = LoadScript("Utilities/Main")
if MainUtil then
    Parvus.Utilities = MainUtil
else
    Parvus.Utilities = {}  -- Fallback empty table
end

-- Load each utility with fallbacks
local UIUtil = LoadScript("Utilities/UI")
if UIUtil then
    Parvus.Utilities.UI = UIUtil
else
    Parvus.Utilities.UI = { Push = function() end }  -- Dummy function
end

local PhysicsUtil = LoadScript("Utilities/Physics")
if PhysicsUtil then
    Parvus.Utilities.Physics = PhysicsUtil
else
    Parvus.Utilities.Physics = {}
end

local DrawingUtil = LoadScript("Utilities/Drawing")
if DrawingUtil then
    Parvus.Utilities.Drawing = DrawingUtil
else
    Parvus.Utilities.Drawing = {}
end

-- Load cursor
Parvus.Cursor = GetFile("Utilities/ArrowCursor.png")

-- Load and prepare loadstring
local LoadstringContent = GetFile("Utilities/Loadstring")
if LoadstringContent then
    Parvus.Loadstring = LoadstringContent:format(
        Parvus.Source, Branch, NotificationTime, tostring(IsLocal)
    )
else
    Parvus.Loadstring = ""
end

-- Setup teleport handler
if LocalPlayer and LocalPlayer.OnTeleport and QueueOnTeleport then
    LocalPlayer.OnTeleport:Connect(function(State)
        if State == Enum.TeleportState.InProgress and Parvus.Loadstring and Parvus.Loadstring ~= "" then
            QueueOnTeleport(Parvus.Loadstring)
        end
    end)
end

-- Load game specific script
Parvus.Game = GetGameInfo()
if Parvus.Game and Parvus.Game.Script then
    LoadScript(Parvus.Game.Script)
end

Parvus.Loaded = true

-- Final success message (only if UI exists)
if Parvus.Utilities.UI and Parvus.Utilities.UI.Push then
    Parvus.Utilities.UI:Push({
        Title = "Parvus Hub",
        Description = Parvus.Game.Name .. " loaded!\n\nThis script is open sourced\nIf you have paid for this script\nOr had to go thru ads\nYou have been scammed.",
        Duration = NotificationTime
    })
else
    -- Fallback notification if UI failed to load
    warn("Parvus Hub loaded: " .. Parvus.Game.Name)
end
