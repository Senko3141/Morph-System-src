-- Morph Server
-- Senko
-- 3/18/2021

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Modules = ReplicatedStorage:WaitForChild("Modules")

local Weld_Service = require(Modules.Weld)

local function join(plr)
    local morph_folder = Instance.new("Folder")
    morph_folder.Name = "Morph"
    morph_folder.Parent = plr

    local current_morph = Instance.new("StringValue")
    current_morph.Name = "Current"
    current_morph.Value = "None"
    current_morph.Parent = morph_folder

    local save = Instance.new("BoolValue")
    save.Name = "Save"
    save.Value = false
    save.Parent = morph_folder

    plr.CharacterAppearanceLoaded:Connect(
        function(char)
            -- Checking if saved morph.

            if (save.Value == true) then
                -- Apply saved morph.
                print("Give saved morph: " .. current_morph.Value .. " to " .. plr.Name .. ".")
            end
        end
    )
end
local function left(plr)
    print(plr.Name .. " has left.")
end

Remotes._Morph.OnServerEvent:Connect(
    function(plr, data)
        if (data == nil) then
            return
        end
        local action = data.Action
        local chosen = data.Morph

        if (action == "Morph") then
            plr.Character.Humanoid:RemoveAccessories()
            Weld_Service:Weld(plr.Character, chosen.Name)
        end
    end
)

Players.PlayerAdded:Connect(join)
Players.PlayerRemoving:Connect(left)