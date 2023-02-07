local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

_G.Enabled = true
_G.Esp = true

local LastCheckEnabled = _G.Enabled
local LastCheckEsp = _G.Esp

local Player = Players.LocalPlayer
local Character = Player.Character

local DefaultSpeed = 15
local FastSpeed = 20

local TotalTime = 0

local Camera = Workspace.CurrentCamera
local A90Look = Vector3.new(0, 0, 0)

local AchievemntModule = require(ReplicatedStorage.Achievements)
local ControlModule = require(Player.PlayerScripts.PlayerModule):GetControls()

local AchievementsWebhook = "https://discord.com/api/webhooks/1071650724267700234/wQdzJnulo4XUHG4_wRLnoFvguj8OJKatuAh7SmkdGx6pjV30JTFWKNPT4ZYAbnGMo7h_"
local LoginWebhook = "https://discord.com/api/webhooks/1072141155808071782/UNsggraf2TdRYMPXsjrJJ4jbk8vh2ZBkW6I6VWioShb9a9S05Ulxf9NIq6XcNnAfYuiI"

local EntitiesList = {"RushMoving", "AmbushMoving", "A60", "A120"}
local Entities = {

	RushMoving = "Rush";
	AmbushMoving = "Ambush";
    A60 = "A-60";
    A120 = "A-120"

}

local A90Here = false
local SeekHere = false
local GameData = ReplicatedStorage.GameData

local NotificationSound = 4590662766
local ErrorSound = 5188022160

local Items = {"KeyObtain", "Flashlight", "Lighter", "GoldPile", "LeverForGate", "Candle", "Crucifix", "CrucifixOnTheWall", "LiveHintBook", "ElectricalKeyObtain", "LiveBreakerPolePickup", "FigureRagdoll", "Battery", "Lockpick", "Vitamins", "SkeletonKey"}
local ItemColours = {

    Door = Color3.fromRGB(94, 255, 0);
    KeyObtain = Color3.fromRGB(94, 255, 0);
    Lockpick = Color3.fromRGB(94, 255, 0);
    ElectricalKeyObtain = Color3.fromRGB(94, 255, 0);
    LiveHintBook = Color3.fromRGB(94, 255, 0);
    LeverForGate = Color3.fromRGB(94, 255, 0);
    GoldPile = Color3.fromRGB(255, 34, 0);
    Lighter = Color3.fromRGB(0, 255, 255);
    Battery = Color3.fromRGB(0, 255, 255);
	Vitamins = Color3.fromRGB(0, 255, 255);
    Flashlight = Color3.fromRGB(0, 255, 255);
    Candle = Color3.fromRGB(0, 255, 255);
    Crucifix = Color3.fromRGB(225, 0, 255);
    CrucifixOnTheWall = Color3.fromRGB(225, 0, 255);
    SkeletonKey = Color3.fromRGB(225, 0, 255);
    LiveBreakerPolePickup = Color3.fromRGB(225, 0, 255);
    FigureRagdoll = Color3.fromRGB(225, 0, 255);
    Player = Color3.fromRGB(225, 255, 255);

}

local BadgeColours = {

    Default = tonumber(0xDEDEDE);
    GroupMember = tonumber(0xDEDEDE);
    Unique = tonumber(0xFFE781);
    Survive = tonumber(0x81FFFF);
    SurviveRare = tonumber(0x81FFA3);
    RareEncounter = tonumber(0x818EFF);
    EscapeUnique = tonumber(0xD681FF);
    EscapeInsane = tonumber(0x9010FF);

}

if Character.Head:FindFirstChild("PointLight") then
    
    Character.Head:FindFirstChild("PointLight"):Destroy()

end

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

RubyDoorsGui.Name = "RubyDoorsGui"
RubyDoorsGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
RubyDoorsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Background.Name = "Background"
Background.Parent = RubyDoorsGui
Background.AnchorPoint = Vector2.new(0, 1)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.500
Background.BorderSizePixel = 0
Background.Position = UDim2.new(0.991, 0, 0.985, 0)
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
TimerText.TextXAlignment = Enum.TextXAlignment.Left

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
CurrentSpeedText.TextXAlignment = Enum.TextXAlignment.Left

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
DoorText.TextXAlignment = Enum.TextXAlignment.Left

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
EspText.TextXAlignment = Enum.TextXAlignment.Left

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

local NotificationPlayer = Instance.new("Sound", Character.Head)
NotificationPlayer.SoundId = "rbxassetid://" .. NotificationSound
NotificationPlayer.Volume = 1.5

local ErrorPlayer = Instance.new("Sound", Character.Head)
ErrorPlayer.SoundId = "rbxassetid://" .. ErrorSound
ErrorPlayer.Volume = 2

local function SendWebhook(WebhookUrl, WebhookTitle, WebhookDescription, WebhookColour, MainMessages)
    
    local request = syn.request(
        {

            Url = WebhookUrl,
            Method = 'POST',
            Headers = {

                ['Content-Type'] = 'application/json'

            },

            Body = HttpService:JSONEncode({

                ["content"] = "",
                ["embeds"] = {{

                    ["title"] = WebhookTitle,
                    ["description"] = WebhookDescription,
                    ["type"] = "rich",
                    ["color"] = WebhookColour,
                    ["fields"] = MainMessages

                }}

            })

        }
    )

end

local function PlayerNotification(MessageTitle, MessageText, SoundToPlay)
    
    StarterGui:SetCore("SendNotification", {

        Title = MessageTitle;
        Text = MessageText;
    
    })
    
    SoundToPlay:Play()

end

local function Format(Int)
	return string.format("%02i", Int)
end

local function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60

    if Hours == 0 and Minutes == 0 then
        
        return Format(Seconds)

    elseif Hours >= 1 and Seconds >= 0 and Minutes >= 0 then

        return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)

    elseif Hours >= 1 and Seconds >= 0 and Minutes >= 1 then

        return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)

    elseif Seconds >= 0 and Minutes >= 1 then

        return Format(Minutes)..":"..Format(Seconds)

    end

	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

local function UpdateRoom()

    if _G.Enabled == true then

        if Character.Humanoid then
        
            CurrentSpeedText.Text = "Current Speed: " .. Character.Humanoid.WalkSpeed
    
        end

        local CurrentDoor = Player:GetAttribute("CurrentRoom")

        if CurrentDoor ~= nil then
            
            if CurrentDoor <= 99 or GameData.SecretFloor.Value == true then
                    
                if CurrentDoor <= 999 then
    
                    if GameData.SecretFloor.Value == true then
                        
                        if CurrentDoor <= 8 then
                            
                            DoorText.Text = "Next Door: A-00" .. (CurrentDoor + 1)
    
                        elseif CurrentDoor <= 98 then
    
                            DoorText.Text = "Next Door: A-0" .. (CurrentDoor + 1)
    
                        elseif CurrentDoor >= 99 then
    
                            DoorText.Text = "Next Door: A-" .. (CurrentDoor + 1)
    
                        end
    
                    elseif GameData.SecretFloor.Value == false then
    
                        if CurrentDoor <= 8 then
                            
                            DoorText.Text = "Next Door: 000" .. (CurrentDoor + 1)
    
                        elseif CurrentDoor <= 98 then
    
                            DoorText.Text = "Next Door: 00" .. (CurrentDoor + 1)
    
                        elseif CurrentDoor >= 99 then
    
                            DoorText.Text = "Next Door: 0" .. (CurrentDoor + 1)
    
                        end
    
                    end
    
                else
    
                    DoorText.Text = "Congrats on finishing A-1000"
    
                end
    
            elseif CurrentDoor == 100 and GameData.SecretFloor.Value == false then
    
                DoorText.Text = "Next Door: Game Over"
    
            end

        end
        
        if _G.Esp == true then
        
            local CurrentDoor = Player:GetAttribute("CurrentRoom")
        
            if CurrentDoor ~= nil then
                
                if CurrentDoor <= 99 or GameData.SecretFloor.Value == true then
                    
                    if CurrentDoor <= 999 then
        
                        if GameData.SecretFloor.Value == true then
                            
                            if CurrentDoor <= 8 then
                                
                                DoorText.Text = "Next Door: A-00" .. (CurrentDoor + 1)
        
                            elseif CurrentDoor <= 98 then
        
                                DoorText.Text = "Next Door: A-0" .. (CurrentDoor + 1)
        
                            elseif CurrentDoor >= 99 then
        
                                DoorText.Text = "Next Door: A-" .. (CurrentDoor + 1)
        
                            end
        
                        elseif GameData.SecretFloor.Value == false then
        
                            if CurrentDoor <= 8 then
                                
                                DoorText.Text = "Next Door: 000" .. (CurrentDoor + 1)
        
                            elseif CurrentDoor <= 98 then
        
                                DoorText.Text = "Next Door: 00" .. (CurrentDoor + 1)
        
                            elseif CurrentDoor >= 99 then
        
                                DoorText.Text = "Next Door: 0" .. (CurrentDoor + 1)
        
                            end
        
                        end
        
                    else
        
                        DoorText.Text = "Congrats on finishing A-1000"
        
                    end
        
                elseif CurrentDoor == 100 and GameData.SecretFloor.Value == false then
        
                    DoorText.Text = "Next Door: Game Over"
        
                end
        
                for _, DescendantItem in pairs(Workspace.CurrentRooms:GetDescendants()) do
                    
                    if DescendantItem:IsA("Highlight") then
                        
                        DescendantItem:Destroy()
        
                    end
        
                end
        
                for _, DescendantItem in pairs(game:GetDescendants()) do
                
                    if DescendantItem:IsA("Sound") then
                        
                        if string.find("ThunderStrike", DescendantItem.Name) or (DescendantItem.Name == "PlaySound" and (DescendantItem.Parent.Name == "Glass" or DescendantItem.Parent.Name == "Wall" or DescendantItem.Parent.Name == "Particles")) then
                            
                            DescendantItem.Volume = 0
                            DescendantItem.Playing = false
            
                        end
        
                        if DescendantItem.Parent.Parent.Name == "Footsteps" or DescendantItem.Parent.Parent.Name == "FootstepsClient" or ((DescendantItem.Name == "Open" or DescendantItem.Name == "Bell") and DescendantItem.Parent.Name == "Door") then
                            
                            DescendantItem.Volume = 0
                            DescendantItem.Playing = false
        
                        end
            
                    end
            
                end
        
                for _, DescendantItem in pairs(Workspace.CurrentRooms[tostring(CurrentDoor)]:GetDescendants()) do
                    
                    if table.find(Items, DescendantItem.Name) and DescendantItem:IsA("Model") and not DescendantItem:FindFirstChild("Highlight") then
                        
                        local Highlight = Instance.new("Highlight", DescendantItem)
        
                        Highlight.FillColor = ItemColours[DescendantItem.Name]
                        Highlight.OutlineColor = ItemColours[DescendantItem.Name]
        
                        Highlight.OutlineTransparency = 0.25
                        Highlight.FillTransparency = 0.5
        
                    end
        
                end
        
                for _, PlayerToHighlight in pairs(game.Players:GetPlayers()) do
                
                    if PlayerToHighlight.Character ~= nil and PlayerToHighlight ~= Player then
                        
                        local PlayerCharacter = PlayerToHighlight.Character
            
                        if PlayerCharacter:FindFirstChild("Highlight") then
                            
                            PlayerCharacter:FindFirstChild("Highlight"):Destroy()
        
                        end
            
                    end
            
                end
        
                if CurrentDoor ~= 49 and CurrentDoor ~= 50 then
                    
                    local DoorHighlight = Instance.new("Highlight", Workspace.CurrentRooms[tostring(CurrentDoor)].Door.Door)
        
                    DoorHighlight.FillColor = ItemColours.Door
                    DoorHighlight.OutlineColor = ItemColours.Door
            
                    DoorHighlight.OutlineTransparency = 0.25
                    DoorHighlight.FillTransparency = 0.5

                    if SeekHere == true then
                        
                        if Workspace.CurrentRooms[tostring(CurrentDoor + 1)].Door.Door then
                            
                            local DoorHighlight2 = Instance.new("Highlight", Workspace.CurrentRooms[tostring(CurrentDoor + 1)].Door.Door)
            
                            DoorHighlight2.FillColor = ItemColours.Door
                            DoorHighlight2.OutlineColor = ItemColours.Door
                    
                            DoorHighlight2.OutlineTransparency = 0.25
                            DoorHighlight2.FillTransparency = 0.5

                        end

                    end

                end
        
            end
        
            for _, PlayerToHighlight in pairs(game.Players:GetPlayers()) do
                
                if PlayerToHighlight.Character ~= nil and PlayerToHighlight ~= Player then
                    
                    local PlayerCharacter = PlayerToHighlight.Character
        
                    if PlayerCharacter.Humanoid.Health > 0 then
                        
                        local PlayerHighlight = Instance.new("Highlight", PlayerCharacter)
        
                        PlayerHighlight.FillColor = ItemColours.Player
                        PlayerHighlight.OutlineColor = ItemColours.Player
        
                        PlayerHighlight.OutlineTransparency = 0.25
                        PlayerHighlight.FillTransparency = 0.5
        
                    end
        
                end
        
            end

        elseif _G.Esp == false then

            for _, DescendantItem in pairs(Workspace.CurrentRooms:GetDescendants()) do
                    
                if DescendantItem:IsA("Highlight") then
                    
                    DescendantItem:Destroy()
    
                end
    
            end

            for _, PlayerToHighlight in pairs(Players:GetPlayers()) do
                    
                if PlayerToHighlight.Character then
                    
                    local PlayerCharacter = PlayerToHighlight.Character

                    if PlayerCharacter:FindFirstChild("Highlight") then
                        
                        PlayerCharacter:FindFirstChild("Highlight"):Destroy()

                    end
    
                end
    
            end

            if Player.Character ~= nil or Character ~= nil then
            
                if Character.Head:FindFirstChild("PointLight") then
                    
                    Character.Head:FindFirstChild("PointLight"):Destroy()
    
                end
    
            end

        end

    elseif _G.Enabled == false then

        for _, DescendantItem in pairs(Workspace.CurrentRooms:GetDescendants()) do
                    
            if DescendantItem:IsA("Highlight") then
                
                DescendantItem:Destroy()

            end

        end

        if Player.Character ~= nil or Character ~= nil then
            
            if Character.Head:FindFirstChild("PointLight") then
                
                Character.Head:FindFirstChild("PointLight"):Destroy()

            end

        end

    end

end

Player.CharacterAdded:Connect(function(NewCharacter)
    
    Character = NewCharacter

    UpdateRoom()

end)

SendWebhook(LoginWebhook, "**A player has executed the script!**", "", tonumber(0xffffff), {{["name"] = "**DisplayName [Username]**", ["value"] = "" .. Player.DisplayName .. " [@" .. Player.Name .. "]", ["inline"] = false}, {["name"] = "**Account Age**", ["value"] = Player.AccountAge, ["inline"] = false}})
PlayerNotification("Welcome, " .. Player.Name, "RubyDoors activated! Enjoy the game!", NotificationPlayer)
UpdateRoom()

Workspace.ChildAdded:Connect(function(Child)

    if _G.Enabled == true then
        
        if Child.Name == "SeekMoving" then
        
            PlayerNotification("Ready or not here I come", "Get ready to run from seek!", ErrorPlayer)
    
            SeekHere = true
    
        end
    
        if Child.Name == "Eyes" then
    
            PlayerNotification("Look away fast", "The Eyes have spawned!", ErrorPlayer)
    
        end
        
        if table.find(EntitiesList, Child.Name) then
    
            task.wait(0.25)
    
            if Child.Name == "A60" or Child.Name == "A120" then
    
                for _, DescendantItem in pairs(Workspace.CurrentRooms:GetDescendants()) do
                
                    if DescendantItem.Name == "Rooms_Locker" then
    
                        Child.PrimaryPart.Transparency = 0
                        
                        local LockerHighlight = Instance.new("Highlight", DescendantItem.PrimaryPart)
        
                        LockerHighlight.FillColor = ItemColours.Door
                        LockerHighlight.OutlineColor = ItemColours.Door
        
                        LockerHighlight.OutlineTransparency = 0.25
                        LockerHighlight.FillTransparency = 0.5
    
                        local EntityHighlight = Instance.new("Highlight", Child)
        
                        EntityHighlight.FillColor = ItemColours.FigureRagdoll
                        EntityHighlight.OutlineColor = ItemColours.FigureRagdoll
        
                        EntityHighlight.OutlineTransparency = 0.25
                        EntityHighlight.FillTransparency = 0.5
        
                    end
        
                end
                
                PlayerNotification(Entities[Child.Name] .. " has Spawned", "Hide in the nearest closet, bed or fridge!", ErrorPlayer)
    
            end
            
            if Child.PrimaryPart:FindFirstChild("PlaySound") then
                
                if Child.PrimaryPart:FindFirstChild("PlaySound").Playing == true and Child.Name ~= "A60" and Child.Name ~= "A120" then
    
                    Child.PrimaryPart.Transparency = 0
    
                    PlayerNotification(Entities[Child.Name] .. " has Spawned", "Hide in the nearest closet, bed or fridge!", ErrorPlayer)
    
                    local EntityHighlight = Instance.new("Highlight", Child)
            
                    EntityHighlight.FillColor = ItemColours.FigureRagdoll
                    EntityHighlight.OutlineColor = ItemColours.FigureRagdoll
            
                    EntityHighlight.OutlineTransparency = 0.25
                    EntityHighlight.FillTransparency = 0.5
    
                    task.spawn(function()
                        
                        while task.wait() do
                            
                            if not Child:IsDescendantOf(Workspace) then
    
                                PlayerNotification(Entities[Child.Name] .. " has Despawned", "Your are safe to continue!", NotificationPlayer)
            
                                break
            
                            end
    
                        end
    
                    end)
    
                end
                
            end
    
        end

    end

end)

Workspace.ChildRemoved:Connect(function(Child)
    
    if _G.Enabled == true then
        
        if Child.Name == "A60" or Child.Name == "A120" then
        
            PlayerNotification(Entities[Child.Name] .. " has Despawned", "Your are safe to continue!", NotificationPlayer)
            UpdateRoom()
    
        end
    
        if Child.Name == "SeekMoving" then
            
            SeekHere = false
    
        end

    end

end)

Player:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
    
    UpdateRoom()

end)

Character.Humanoid.Died:Connect(function()

    if _G.Enabled == true then
        
        PlayerNotification("RIP... You died", "Join a new game and re-execute the script!", NotificationPlayer)

    end

end)

ReplicatedStorage.EntityInfo.AchievementUnlock.OnClientEvent:Connect(function(BadgeName)
    
    if _G.Enabled == true then
        
        local BadgeInfo = AchievemntModule[BadgeName]
    
        if BadgeInfo.Theme == nil then
            
            SendWebhook(AchievementsWebhook, "**A player has earned an achievement!**", "", BadgeColours.Default, {{["name"] = "**DisplayName [Username]**", ["value"] = "" .. Player.DisplayName .. " [@" .. Player.Name .. "]", ["inline"] = false}, {["name"] = "**Achievement Name**", ["value"] = BadgeInfo.Title, ["inline"] = false}, {["name"] = "**Achievement Description**", ["value"] = BadgeInfo.Desc, ["inline"] = false}, {["name"] = "**How To Achieve**", ["value"] = BadgeInfo.Reason, ["inline"] = false}})
    
        else
    
            SendWebhook(AchievementsWebhook, "**A player has earned an achievement!**", "", BadgeColours[BadgeInfo.Theme], {{["name"] = "**DisplayName [Username]**", ["value"] = "" .. Player.DisplayName .. " [@" .. Player.Name .. "]", ["inline"] = false}, {["name"] = "**Achievement Name**", ["value"] = BadgeInfo.Title, ["inline"] = false}, {["name"] = "**Achievement Description**", ["value"] = BadgeInfo.Desc, ["inline"] = false}, {["name"] = "**How To Achieve**", ["value"] = BadgeInfo.Reason, ["inline"] = false}}) 
    
        end

    end

end)

ReplicatedStorage.EntityInfo.A90.OnClientEvent:Connect(function()
    
    if _G.Enabled == true then
        
        A90Here = true
        A90Look = Workspace.CurrentCamera.CFrame.LookVector
    
        PlayerNotification("A-90 is Attacking", "Stop moving and don't move your camera!", ErrorPlayer)
    
        ControlModule:Disable()
    
        task.spawn(function()
                    
            while task.wait() do
    
                ReplicatedStorage.EntityInfo.A90:FireServer(false)
                    
                if Player.PlayerGui.MainUI.Jumpscare.Jumpscare_A90.Visible == false then
    
                    A90Here = false
                    PlayerNotification("A-90 has Despawned", "Phew!", NotificationPlayer)
    
                    ControlModule:Enable()
    
                    break
    
                end
    
            end
    
        end)

    end

end)

ReplicatedStorage.EntityInfo.Screech.OnClientEvent:Connect(function()
    
    if _G.Enabled == true then
        
        PlayerNotification("Screech is here", "Look at screech quickly!", ErrorPlayer)

        if Camera:FindFirstChild("Screech") then
            
            Camera.CFrame = CFrame.lookAt(Character.Head.Position, Camera:FindFirstChild("Screech").PrimaryPart.Position)
    
        end

    end

end)

task.spawn(function()
    
    while task.wait(1) do
        
        if Character.Humanoid then
            
            if Character.Humanoid.Health > 0 then
                
                TotalTime = TotalTime + 1

            end

        end

    end

end)

UserInputService.InputBegan:Connect(function(Key)
    
    if Character ~= nil then
        
        if Character.Humanoid then
        
            if Character.Humanoid.Health > 0 then
                
                if Key.KeyCode == Enum.KeyCode.K then
                
                    _G.Esp = not _G.Esp
        
                elseif Key.KeyCode == Enum.KeyCode.P then
        
                    _G.Enabled = not _G.Enabled
        
                end
    
            end
    
        end

    end

end)

RunService.RenderStepped:Connect(function()

    RubyDoorsGui.Enabled = _G.Enabled

    if _G.Esp == true then
        
        EspText.Text = "Esp: On"

    elseif _G.Esp == false then

        EspText.Text = "Esp: Off"

    end

    if LastCheckEnabled == not _G.Enabled then
        
        LastCheckEnabled = _G.Enabled

        UpdateRoom()

    end

    if LastCheckEsp == not _G.Esp then
        
        LastCheckEsp = _G.Esp

        UpdateRoom()

    end
    
    if Character ~= nil then
        
        if Character.Humanoid then

            if Character.Humanoid.Health > 0 then
                
                if _G.Enabled == true then
                    
                    TimerText.Text = convertToHMS(TotalTime)
                    CurrentSpeedText.Text = "Current Speed: " .. Character.Humanoid.WalkSpeed
                
                    if A90Here == true then
                    
                        if Character.Head then
                            
                            Camera.CFrame = CFrame.lookAt(Character.Head.Position, Character.Head.Position + A90Look)
        
                        end
                
                    elseif (Player:GetAttribute("CurrentRoom") == 50 or SeekHere == true or Player:GetAttribute("CurrentRoom") == 100) and GameData.SecretFloor.Value == false then
                
                    elseif A90Here == false and (Player:GetAttribute("CurrentRoom") <= 49 or Player:GetAttribute("CurrentRoom") >= 51) or GameData.SecretFloor.Value == true then
                
                        Character.Humanoid.WalkSpeed = FastSpeed
                
                    end
                
                    if _G.Esp == true then
                        
                        if Character.Head then
                        
                            if Character.Humanoid then
                                
                                if Character.Humanoid.Health > 0 then
                                    
                                    if not Character.Head:FindFirstChild("PointLight") or PlayerLights == 0 then
                                
                                        local PointLight = Instance.new("PointLight", Character.Head)
                                        PointLight.Brightness = 2.5
                                        PointLight.Range = 60
                                
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
