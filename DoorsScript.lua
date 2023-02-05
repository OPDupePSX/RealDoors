local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local Character = Player.Character

local Webhook = "https://discord.com/api/webhooks/1071650724267700234/wQdzJnulo4XUHG4_wRLnoFvguj8OJKatuAh7SmkdGx6pjV30JTFWKNPT4ZYAbnGMo7h_"

local EntitiesList = {"RushMoving", "AmbushMoving", "A60", "A120"}
local Entities = {

	RushMoving = "Rush";
	AmbushMoving = "Ambush";
    A60 = "A-60";
    A120 = "A-120"

}

local NotificationSound = 4590662766
local ErrorSound = 5188022160

local Items = {"KeyObtain", "Lighter", "GoldPile", "LeverForGate", "Candle", "Crucifix", "LiveHintBook", "ElectricalKeyObtain", "LiveBreakerPolePickup", "FigureRagdoll", "Battery", "Lockpick", "Vitamins", "SkeletonKey"}
local SpecialItems = {"Crucifix", "SkeletonKey"}
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
    SkeletonKey = Color3.fromRGB(225, 0, 255);
    LiveBreakerPolePickup = Color3.fromRGB(225, 0, 255);
    FigureRagdoll = Color3.fromRGB(225, 0, 255);
    Player = Color3.fromRGB(225, 255, 255);

}

local NextDoorGui = Instance.new("ScreenGui")
local Bar = Instance.new("Frame")
local DoorText = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")

NextDoorGui.Name = "NextDoorGui"
NextDoorGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
NextDoorGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Bar.Name = "Bar"
Bar.Parent = NextDoorGui
Bar.AnchorPoint = Vector2.new(0.5, 0)
Bar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Bar.BackgroundTransparency = 0.500
Bar.BorderSizePixel = 0
Bar.Position = UDim2.new(0.5, 0, 0.0149999978, 0)
Bar.Size = UDim2.new(0.449999988, 0, 0.0636135563, 0)

DoorText.Name = "DoorText"
DoorText.Parent = Bar
DoorText.AnchorPoint = Vector2.new(0.5, 0.5)
DoorText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DoorText.BackgroundTransparency = 1.000
DoorText.BorderSizePixel = 0
DoorText.Position = UDim2.new(0.5, 0, 0.5, 0)
DoorText.Size = UDim2.new(1, 0, 1, 0)
DoorText.Font = Enum.Font.GothamBold
DoorText.Text = "Next Door: 1"
DoorText.TextColor3 = Color3.fromRGB(255, 255, 255)
DoorText.TextScaled = true
DoorText.TextSize = 14.000
DoorText.TextWrapped = true

UICorner.CornerRadius = UDim.new(0.25, 0)
UICorner.Parent = Bar

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

local function UpdateRoom()
    
    local CurrentDoor = Player:GetAttribute("CurrentRoom")
    local SpecialItemsInRoom = 0

    if CurrentDoor == 100 then
        
        DoorText.Text = "Next Door: Game Over"

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

                if table.find(SpecialItems, DescendantItem.Name) then
                    
                    SpecialItemsInRoom = SpecialItemsInRoom + 1

                end

            end

            if SpecialItemsInRoom > 0 then

                PlayerNotification("There are special items in your room", "There is " .. tostring(SpecialItemsInRoom) .. " special items in your room!", NotificationPlayer)

            end

            NotificationPlayer:Play()

        end

        local DoorHighlight = Instance.new("Highlight", Workspace.CurrentRooms[tostring(CurrentDoor)].Door.Door)

        DoorHighlight.FillColor = ItemColours.Door
        DoorHighlight.OutlineColor = ItemColours.Door

        DoorHighlight.OutlineTransparency = 0.25
        DoorHighlight.FillTransparency = 0.5

    elseif CurrentDoor <= 99 then
            
        DoorText.Text = "Next Door: " .. (CurrentDoor + 1)

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

                if table.find(SpecialItems, DescendantItem.Name) then
                    
                    SpecialItemsInRoom = SpecialItemsInRoom + 1

                end

            end

            if SpecialItemsInRoom > 0 then

                PlayerNotification("There are special items in your room", "There is " .. tostring(SpecialItemsInRoom) .. " special items in your room!", NotificationPlayer)

            end

            NotificationPlayer:Play()

        end

        for _, DescendantItem in pairs(Workspace.CurrentRooms[tostring(CurrentDoor + 1)]:GetDescendants()) do
            
            if table.find(Items, DescendantItem.Name) and DescendantItem:IsA("Model") and not DescendantItem:FindFirstChild("Highlight") then
                
                local Highlight = Instance.new("Highlight", DescendantItem)

                Highlight.FillColor = ItemColours[DescendantItem.Name]
                Highlight.OutlineColor = ItemColours[DescendantItem.Name]

                Highlight.OutlineTransparency = 0.25
                Highlight.FillTransparency = 0.5

                if table.find(SpecialItems, DescendantItem.Name) then
                    
                    SpecialItemsInRoom = SpecialItemsInRoom + 1

                end

            end

            if SpecialItemsInRoom > 0 then

                PlayerNotification("There are special items in the next room", "There is " .. tostring(SpecialItemsInRoom) .. " special items in the next room!", NotificationPlayer)

            end

            NotificationPlayer:Play()

        end

        local DoorHighlight = Instance.new("Highlight", Workspace.CurrentRooms[tostring(CurrentDoor)].Door.Door)

        DoorHighlight.FillColor = ItemColours.Door
        DoorHighlight.OutlineColor = ItemColours.Door

        DoorHighlight.OutlineTransparency = 0.25
        DoorHighlight.FillTransparency = 0.5

    end

    for _, PlayerToHighlight in pairs(game.Players:GetPlayers()) do
        
        if PlayerToHighlight.Character ~= nil  and Player.Highlight ~= Player then
            
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

SendWebhook("**A player has executed the script!**", "", tonumber(0xffffff), {{["name"] = "**DisplayName [Username]**", ["value"] = "" .. Player.DisplayName .. " [@" .. Player.Name .. "]", ["inline"] = false}, {["name"] = "**Account Age**", ["value"] = Player.AccountAge, ["inline"] = false}})
PlayerNotification("Welcome, " .. Player.Name, "RubyDoors activated! Enjoy the game!", NotificationPlayer)
UpdateRoom()

ReplicatedStorage.EntityInfo.A90.OnClientEvent:Connect(function()

    PlayerNotification("A-90 is Attacking!", "STOP MOVING", ErrorPlayer)

end)

Workspace.ChildAdded:Connect(function(Child)

    if Child.Name == "SeekMoving" then
        
        PlayerNotification("Ready or not here I come", "Get ready to run from seek!", ErrorPlayer)

    end

    if Child.Name == "Eyes" then

        PlayerNotification("Look away fast", "The Eyes have spawned!", ErrorPlayer)

    end
    
    if table.find(EntitiesList, Child.Name) then

        task.wait(0.25)
        
        if Child.PrimaryPart:FindFirstChild("PlaySound").Playing == true then

            PlayerNotification(Entities[Child.Name] .. " has Spawned", "Hide in the nearest closet, bed or fridge!", ErrorPlayer)

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

Player:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
    
    UpdateRoom()

end)

Character.Humanoid.Died:Connect(function()

    PlayerNotification("RIP... You died", "Join a new game and re-execute teh script!", NotificationPlayer)

end)