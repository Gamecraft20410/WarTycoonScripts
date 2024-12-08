-- Auto-Build Script für War Tycoon mit UI
-- Entwickelt für Delta Executor von Gamecraft20410

local player = game.Players.LocalPlayer
local tycoon = nil
local autoBuilding = false
local waitTime = 5 -- Standard-Wartezeit

-- Funktion zum Finden des Tycoons
local function findTycoon()
    for _, v in pairs(workspace.Tycoons:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Owner.Value == player then
            tycoon = v
            print("Tycoon gefunden: " .. v.Name)  -- Debug-Ausgabe
            break
        end
    end
    if not tycoon then
        print("Kein Tycoon gefunden!")  -- Debug-Ausgabe
    end
end

-- Funktion zum Kauf aller Schaltflächen
local function purchaseButtons()
    if tycoon then
        for _, button in pairs(tycoon.Buttons:GetChildren()) do
            if button:FindFirstChild("Head") and button.Head:FindFirstChild("TouchInterest") then
                print("Kaufe Button: " .. button.Name)  -- Debug-Ausgabe
                firetouchinterest(player.Character.HumanoidRootPart, button.Head, 0)
                wait(0.1)
                firetouchinterest(player.Character.HumanoidRootPart, button.Head, 1)
            end
        end
    end
end

-- GUI erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(0, 200, 0, 50)
title.Text = "Auto-Build Control"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.BackgroundTransparency = 1

local startStopButton = Instance.new("TextButton")
startStopButton.Parent = frame
startStopButton.Size = UDim2.new(0, 180, 0, 50)
startStopButton.Position = UDim2.new(0, 10, 0, 60)
startStopButton.Text = "Start Auto-Build"
startStopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startStopButton.BackgroundColor3 = Color3.fromRGB(0, 128, 0)

local waitTimeLabel = Instance.new("TextLabel")
waitTimeLabel.Parent = frame
waitTimeLabel.Size = UDim2.new(0, 180, 0, 30)
waitTimeLabel.Position = UDim2.new(0, 10, 0, 120)
waitTimeLabel.Text = "Wartezeit: " .. waitTime .. " Sekunden"
waitTimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
waitTimeLabel.TextSize = 14
waitTimeLabel.BackgroundTransparency = 1

local incrementButton = Instance.new("TextButton")
incrementButton.Parent = frame
incrementButton.Size = UDim2.new(0, 80, 0, 30)
incrementButton.Position = UDim2.new(0, 10, 0, 160)
incrementButton.Text = "+"
incrementButton.TextColor3 = Color3.fromRGB(255, 255, 255)
incrementButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)

local decrementButton = Instance.new("TextButton")
decrementButton.Parent = frame
decrementButton.Size = UDim2.new(0, 80, 0, 30)
decrementButton.Position = UDim2.new(0, 100, 0, 160)
decrementButton.Text = "-"
decrementButton.TextColor3 = Color3.fromRGB(255, 255, 255)
decrementButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

-- Funktion, um die Auto-Build-Funktion zu starten/stoppen
local function toggleAutoBuild()
    autoBuilding = not autoBuilding
    if autoBuilding then
        startStopButton.Text = "Stop Auto-Build"
        print("Auto-Build gestartet!")  -- Debug-Ausgabe
        while autoBuilding do
            findTycoon()
            if tycoon then
                purchaseButtons()
                wait(waitTime)
            else
                print("Kein Tycoon gefunden!")  -- Debug-Ausgabe
                break
            end
        end
    else
        startStopButton.Text = "Start Auto-Build"
        print("Auto-Build gestoppt!")  -- Debug-Ausgabe
    end
end

-- Funktion zur Anpassung der Wartezeit
incrementButton.MouseButton1Click:Connect(function()
    waitTime = waitTime + 1
    waitTimeLabel.Text = "Wartezeit: " .. waitTime .. " Sekunden"
    print("Wartezeit erhöht auf: " .. waitTime .. " Sekunden")  -- Debug-Ausgabe
end)

decrementButton.MouseButton1Click:Connect(function()
    if waitTime > 1 then
        waitTime = waitTime - 1
        waitTimeLabel.Text = "Wartezeit: " .. waitTime .. " Sekunden"
        print("Wartezeit verringert auf: " .. waitTime .. " Sekunden")  -- Debug-Ausgabe
    end
end)

-- Button-Event für Start/Stop
startStopButton.MouseButton1Click:Connect(function()
    print("Start/Stop Button geklickt!")  -- Debug-Ausgabe
    toggleAutoBuild()
end)
