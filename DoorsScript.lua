local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RbxAnalyticService = game:GetService("RbxAnalyticsService")

local Player = Players.LocalPlayer
local Character = Player.Character

local Webhook = "https://discord.com/api/webhooks/1071650724267700234/wQdzJnulo4XUHG4_wRLnoFvguj8OJKatuAh7SmkdGx6pjV30JTFWKNPT4ZYAbnGMo7h_"

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

                ["title"] = "**A player has executed the script!**",
                ["description"] = "",
                ["type"] = "rich",
                ["color"] = tonumber(0xffffff),
                ["fields"] = {

                    {

                        ["name"] = "**DisplayName [Username] **`" .. Player.DisplayName .. " [@" .. Player.Name .. "]`",
                        ["value"] = "",
                        ["inline"] = true

                    },
                    {

                        ["name"] = "**Account Age: **`" .. Player.AccountAge .. "`",
                        ["value"] = "",
                        ["inline"] = true

                    },

                }

            }}

        })

    }
)

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

StarterGui:SetCore("SendNotification", {

	Title = "Welcome, " .. Player.Name;
	Text = "RubyDoors activated! Enjoy the game!";

})

NotificationPlayer:Play()

ReplicatedStorage.EntityInfo.A90.OnClientEvent:Connect(function()
    
    game.StarterGui:SetCore("SendNotification", {

        Title = "A-90 is Attacking!";
        Text = "STOP MOVING";

    })

    ErrorPlayer:Play()

end)

Workspace.ChildAdded:Connect(function(Child)

    if Child.Name == "SeekMoving" then
        
        game.StarterGui:SetCore("SendNotification", {

            Title = "Ready or not here I come";
            Text = "Get ready to run from seek!";

        })

        ErrorPlayer:Play()

    end

    if Child.Name == "Eyes" then
        
        game.StarterGui:SetCore("SendNotification", {

            Title = "Look away fast";
            Text = "The Eyes have spawned!";

        })

        ErrorPlayer:Play()

    end
    
    if table.find(EntitiesList, Child.Name) then

        task.wait(0.25)
        
        if Child.PrimaryPart:FindFirstChild("PlaySound").Playing == true then
            
            game.StarterGui:SetCore("SendNotification", {

                Title = Entities[Child.Name] .. " has Spawned";
                Text = "Hide in the nearest closet, bed or fridge!";
    
            })

            ErrorPlayer:Play()

            task.spawn(function()
                
                while task.wait() do
                    
                    if not Child:IsDescendantOf(Workspace) then
                    
                        game.StarterGui:SetCore("SendNotification", {
    
                            Title = Entities[Child.Name] .. " has Despawned";
                            Text = "Your are safe to continue!";
                
                        })

                        NotificationPlayer:Play()
    
                        break
    
                    end

                end

            end)

        end

    end

end)

Player:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
    
    local CurrentDoor = Player:GetAttribute("CurrentRoom")
    local ItemsInRoom = 0
    local SpecialItemsInRoom = 0

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

            ItemsInRoom = ItemsInRoom + 1

            if table.find(SpecialItems, DescendantItem.Name) then
                
                SpecialItemsInRoom = SpecialItemsInRoom + 1

            end

        end

        if SpecialItemsInRoom > 0 then
            
            game.StarterGui:SetCore("SendNotification", {
    
                Title = "There are special items in your room";
                Text = "There is " .. tostring(SpecialItemsInRoom) .. " special items in your room!";
    
            })
    
            NotificationPlayer:Play()

        end

        game.StarterGui:SetCore("SendNotification", {
    
            Title = "There are items in your room";
            Text = "There is " .. tostring(ItemsInRoom) .. " items in your room!";

        })

        NotificationPlayer:Play()

    end

    local DoorHighlight = Instance.new("Highlight", Workspace.CurrentRooms[tostring(CurrentDoor)].Door.Door)

    DoorHighlight.FillColor = ItemColours.Door
    DoorHighlight.OutlineColor = ItemColours.Door

    DoorHighlight.OutlineTransparency = 0.25
    DoorHighlight.FillTransparency = 0.5

end)

Character.Humanoid.Died:Connect(function()
    
    StarterGui:SetCore("SendNotification", {

        Title = "RIP... You died";
        Text = "Join a new game and re-execute teh script!";
    
    })
    
    NotificationPlayer:Play()

end)
