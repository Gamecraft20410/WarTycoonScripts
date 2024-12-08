-- Auto-Build Script für War Tycoon
-- Entwickelt für Delta Executor von Gamecraft20410

local player = game.Players.LocalPlayer
local tycoon = nil

-- Funktion zum Finden des Tycoons
local function findTycoon()
    for _, v in pairs(workspace.Tycoons:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Owner.Value == player then
            tycoon = v
            break
        end
    end
end

-- Funktion zum Kauf aller Schaltflächen
local function purchaseButtons()
    if tycoon then
        for _, button in pairs(tycoon.Buttons:GetChildren()) do
            if button:FindFirstChild("Head") and button.Head:FindFirstChild("TouchInterest") then
                firetouchinterest(player.Character.HumanoidRootPart, button.Head, 0)
                wait(0.1)
                firetouchinterest(player.Character.HumanoidRootPart, button.Head, 1)
            end
        end
    end
end

-- Hauptausführung
findTycoon()

if tycoon then
    print("Tycoon gefunden: " .. tycoon.Name)
    while true do
        purchaseButtons()
        wait(5) -- Wartezeit zwischen den automatischen Käufen
    end
else
    print("Kein Tycoon gefunden!")
end
