local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local Character = Player.Character

local DefaultSpeed = 15
local FastSpeed = 20

local TotalTime = 0

local Camera = Workspace.CurrentCamera
local A90Look = Vector3.new(0, 0, 0)

local AchievemntModule = require(ReplicatedStorage.Achievements)
local ControlModule = require(Player.PlayerScripts.PlayerModule):GetControls()

local Webhook = "https://discord.com/api/webhooks/1071650724267700234/wQdzJnulo4XUHG4_wRLnoFvguj8OJKatuAh7SmkdGx6pjV30JTFWKNPT4ZYAbnGMo7h_"

local EntitiesList = {"RushMoving", "AmbushMoving", "A60", "A120"}
local Entities = {

	RushMoving = "Rush";
	AmbushMoving = "Ambush";
    A60 = "A-60";
    A120 = "A-120"

}

local A90Here = false
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

local RubyDoorsGui = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TimerText = Instance.new("TextLabel")
local DoorText = Instance.new("TextLabel")
local CurrentSpeedText = Instance.new("TextLabel")

--Properties:

RubyDoorsGui.Name = "RubyDoorsGui"
RubyDoorsGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
RubyDoorsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Background.Name = "Background"
Background.Parent = RubyDoorsGui
Background.AnchorPoint = Vector2.new(0.5, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.500
Background.BorderSizePixel = 0
Background.Position = UDim2.new(0.5, 0, 0.0149999829, 0)
Background.Size = UDim2.new(0.75, 0, 0.0823400244, 0)

UICorner.CornerRadius = UDim.new(0.25, 0)
UICorner.Parent = Background

TimerText.Name = "TimerText"
TimerText.Parent = Background
TimerText.AnchorPoint = Vector2.new(0.5, 0)
TimerText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TimerText.BackgroundTransparency = 1.000
TimerText.BorderSizePixel = 0
TimerText.Position = UDim2.new(0.5, 0, 0, 0)
TimerText.Size = UDim2.new(0.25, 0, 1, 0)
TimerText.Font = Enum.Font.DenkOne
TimerText.Text = "00:00:00"
TimerText.TextColor3 = Color3.fromRGB(255, 255, 255)
TimerText.TextScaled = true
TimerText.TextSize = 14.000
TimerText.TextWrapped = true

DoorText.Name = "DoorText"
DoorText.Parent = Background
DoorText.AnchorPoint = Vector2.new(0, 1)
DoorText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DoorText.BackgroundTransparency = 1.000
DoorText.BorderSizePixel = 0
DoorText.Position = UDim2.new(0, 0, 1, 0)
DoorText.Size = UDim2.new(0.375, 0, 0.698095262, 0)
DoorText.Font = Enum.Font.DenkOne
DoorText.Text = "Next Door: 1"
DoorText.TextColor3 = Color3.fromRGB(255, 255, 255)
DoorText.TextScaled = true
DoorText.TextSize = 14.000
DoorText.TextWrapped = true

CurrentSpeedText.Name = "CurrentSpeedText"
CurrentSpeedText.Parent = Background
CurrentSpeedText.AnchorPoint = Vector2.new(1, 1)
CurrentSpeedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CurrentSpeedText.BackgroundTransparency = 1.000
CurrentSpeedText.BorderSizePixel = 0
CurrentSpeedText.Position = UDim2.new(1, 0, 1, 0)
CurrentSpeedText.Size = UDim2.new(0.375, 0, 0.698095262, 0)
CurrentSpeedText.Font = Enum.Font.DenkOne
CurrentSpeedText.Text = "Current Speed: 20"
CurrentSpeedText.TextColor3 = Color3.fromRGB(255, 255, 255)
CurrentSpeedText.TextScaled = true
CurrentSpeedText.TextSize = 14.000
CurrentSpeedText.TextWrapped = true

local PointLight = Instance.new("PointLight")
PointLight.Brightness = 2.5
PointLight.Range = 60
PointLight.Parent = Character.Head

local NotificationPlayer = Instance.new("Sound", Character.Head)
NotificationPlayer.SoundId = "rbxassetid://" .. NotificationSound
NotificationPlayer.Volume = 1.5

local ErrorPlayer = Instance.new("Sound", Character.Head)
ErrorPlayer.SoundId = "rbxassetid://" .. ErrorSound
ErrorPlayer.Volume = 2

local function SendWebhook(WebhookTitle, WebhookDescription, WebhookColour, MainMessages)
    
    local request = syn.request(
        {

            Url = Webhook,
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

    if Character.Humanoid then
        
        CurrentSpeedText.Text = "Current Speed: " .. Character.Humanoid.WalkSpeed

    end

    local CurrentDoor = Player:GetAttribute("CurrentRoom")

    if CurrentDoor ~= nil then
        
        if CurrentDoor <= 99 or GameData.SecretFloor.Value == true then
            
            if CurrentDoor <= 999 then
                
                DoorText.Text = "Next Door: " .. (CurrentDoor + 1)

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

        local DoorHighlight = Instance.new("Highlight", Workspace.CurrentRooms[tostring(CurrentDoor)].Door.Door)

        DoorHighlight.FillColor = ItemColours.Door
        DoorHighlight.OutlineColor = ItemColours.Door

        DoorHighlight.OutlineTransparency = 0.25
        DoorHighlight.FillTransparency = 0.5

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

end

Player.CharacterAdded:Connect(function(NewCharacter)
    
    Character = NewCharacter

    UpdateRoom()

end)

SendWebhook("**A player has executed the script!**", "", tonumber(0xffffff), {{["name"] = "**DisplayName [Username]**", ["value"] = "" .. Player.DisplayName .. " [@" .. Player.Name .. "]", ["inline"] = false}, {["name"] = "**Account Age**", ["value"] = Player.AccountAge, ["inline"] = false}})
PlayerNotification("Welcome, " .. Player.Name, "RubyDoors activated! Enjoy the game!", NotificationPlayer)
UpdateRoom()

Workspace.ChildAdded:Connect(function(Child)

    if Child.Name == "SeekMoving" then
        
        PlayerNotification("Ready or not here I come", "Get ready to run from seek!", ErrorPlayer)

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
                    
                    local LockerHighlight = Instance.new("Highlight", DescendantItem)
    
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

end)

Workspace.ChildRemoved:Connect(function(Child)
    
    if Child.Name == "A60" or Child.Name == "A120" then
        
        PlayerNotification(Entities[Child.Name] .. " has Despawned", "Your are safe to continue!", NotificationPlayer)
        UpdateRoom()

    end

end)

Player:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
    
    UpdateRoom()

end)

Character.Humanoid.Died:Connect(function()

    PlayerNotification("RIP... You died", "Join a new game and re-execute teh script!", NotificationPlayer)

end)

ReplicatedStorage.EntityInfo.AchievementUnlock.OnClientEvent:Connect(function(BadgeName)
    
    local BadgeInfo = AchievemntModule[BadgeName]
    local BadgeColour = tonumber(0x9000B5)

    if BadgeInfo.Theme == nil then
        
        SendWebhook("**A player has earned an achievement!**", "", BadgeColours.Default, {{["name"] = "**DisplayName [Username]**", ["value"] = "" .. Player.DisplayName .. " [@" .. Player.Name .. "]", ["inline"] = false}, {["name"] = "**Achievement Name**", ["value"] = BadgeInfo.Title, ["inline"] = false}, {["name"] = "**Achievement Description**", ["value"] = BadgeInfo.Desc, ["inline"] = false}, {["name"] = "**How To Achieve**", ["value"] = BadgeInfo.Reason, ["inline"] = false}})

    else

        SendWebhook("**A player has earned an achievement!**", "", BadgeColours[BadgeInfo.Theme], {{["name"] = "**DisplayName [Username]**", ["value"] = "" .. Player.DisplayName .. " [@" .. Player.Name .. "]", ["inline"] = false}, {["name"] = "**Achievement Name**", ["value"] = BadgeInfo.Title, ["inline"] = false}, {["name"] = "**Achievement Description**", ["value"] = BadgeInfo.Desc, ["inline"] = false}, {["name"] = "**How To Achieve**", ["value"] = BadgeInfo.Reason, ["inline"] = false}}) 

    end

end)

ReplicatedStorage.EntityInfo.A90.OnClientEvent:Connect(function()
    
    A90Here = true
    A90Look = Workspace.CurrentCamera.CFrame.LookVector

    PlayerNotification("A-90 is Attacking", "Stop moving and don't move your camera!", ErrorPlayer)

    ControlModule:Disable()

    task.spawn(function()
                
        while task.wait() do

            ReplicatedStorage.EntityInfo.A90:FireServer(false)
                
            if Player.PlayerGui.MainUI.Jumpscare.Jumpscare_A90.Visible == false then

                A90Here = false
                PlayerNotification("He's gone", "A-90 Left you alone!", NotificationPlayer)

                ControlModule:Enable()

                break

            end

        end

    end)

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

RunService.RenderStepped:Connect(function()
    
    if Character.Humanoid then

        if Character.Humanoid.Health > 0 then
            
            TimerText.Text = convertToHMS(TotalTime)
        
            if A90Here == true then
            
                Camera.CFrame = CFrame.lookAt(Character.Head.Position, Character.Head.Position + A90Look)
        
            elseif Player:GetAttribute("CurrentRoom") == 50 and GameData.SecretFloor.Value == false then
        
                Character.Humanoid.WalkSpeed = DefaultSpeed
        
            elseif A90Here == false and (Player:GetAttribute("CurrentRoom") <= 49 or Player:GetAttribute("CurrentRoom") >= 51) or GameData.SecretFloor.Value == true then
        
                Character.Humanoid.WalkSpeed = FastSpeed
        
            end
        
            if not Character.Head:FindFirstChild("PointLight") then
                    
                local PointLight = Instance.new("PointLight", NewCharacter.Head)
                PointLight.Brightness = 2.5
                PointLight.Range = 60
        
            end

        end

    end

end)
