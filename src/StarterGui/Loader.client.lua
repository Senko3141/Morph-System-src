-- Loader
-- Senko
-- 3/18/2021

if (not game:IsLoaded()) then
    game.Loaded:Wait()
end

local Storage = game:GetService("ReplicatedStorage")

local Modules = Storage:WaitForChild("Modules")
local UI_Assets = Storage:WaitForChild("UI_Assets")

local UI_Folder = script.Parent:WaitForChild("UI")

local function load()
    for _,asset in pairs(UI_Assets:GetChildren()) do
        if (asset:IsA("ScreenGui")) then
            local clone = asset:Clone()
            clone.Parent = UI_Folder

            if (Modules:FindFirstChild(clone.Name)) then
                require(Modules[clone.Name]).init(clone)
            end

        end
    end
end

load()