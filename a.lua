loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AlexR32/Parvus/main/Loader.lua"))("Parvus hitting p!")

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.GameId ~= 0

if Parvus and Parvus.Loaded then
    Parvus.Utilities.UI:Push({
        Title = "Parvus Hub",
        Description = "Script already running!",
        Duration = 5
    }) 
    return
end

--[[if Parvus and (Parvus.Game and not Parvus.Loaded) then
    Parvus.Utilities.UI:Push({
        Title = "Parvus Hub",
        Description = "Something went wrong!",
        Duration = 5
    }) return
end]]

local PlayerService = game:GetService("Players")
repeat task.wait() until PlayerService.LocalPlayer
local LocalPlayer = PlayerService.LocalPlayer

local Branch = ... or "main"
local NotificationTime = ... or 5
local IsLocal = ... or false
--local ClearTeleportQueue = clear_teleport_queue
local QueueOnTeleport = queue_on_teleport or function() end

local function GetFile(File)
    if IsLocal then
        return readfile("Parvus/" .. File)
    else
        return game:HttpGet(("%s%s"):format(Parvus.Source, File))
    end
end

local function LoadScript(Script)
    local success, result = pcall(function()
        return loadstring(GetFile(Script .. ".lua"), Script)
    end)
    if success and result then
        return result()
    else
        warn("Failed to load script: " .. Script)
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

getgenv().Parvus = {
    Source = "https://raw.githubusercontent.com/AlexR32/Parvus/" .. Branch .. "/",
    
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

-- Create utilities table if it doesn't exist
Parvus.Utilities = Parvus.Utilities or {}
Parvus.Utilities.UI = LoadScript("Utilities/UI") or { Push = function() end }
Parvus.Utilities.Physics = LoadScript("Utilities/Physics") or {}
Parvus.Utilities.Drawing = LoadScript("Utilities/Drawing") or {}

Parvus.Cursor = GetFile("Utilities/ArrowCursor.png")
Parvus.Loadstring = GetFile("Utilities/Loadstring")
if Parvus.Loadstring then
    Parvus.Loadstring = Parvus.Loadstring:format(
        Parvus.Source, Branch, NotificationTime, tostring(IsLocal)
    )
end

if LocalPlayer and LocalPlayer.OnTeleport then
    LocalPlayer.OnTeleport:Connect(function(State)
        if State == Enum.TeleportState.InProgress then
            if QueueOnTeleport and Parvus.Loadstring then
                QueueOnTeleport(Parvus.Loadstring)
            end
        end
    end)
end

Parvus.Game = GetGameInfo()
if Parvus.Game and Parvus.Game.Script then
    LoadScript(Parvus.Game.Script)
end
Parvus.Loaded = true

if Parvus.Utilities and Parvus.Utilities.UI then
    Parvus.Utilities.UI:Push({
        Title = "Parvus Hub",
        Description = Parvus.Game.Name .. " loaded!\n\nThis script is open sourced\nIf you have paid for this script\nOr had to go thru ads\nYou have been scammed.",
        Duration = NotificationTime
    })
end
