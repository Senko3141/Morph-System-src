-- Morph UI Handler
-- Senko
-- 3/18/2021

local Handler = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local Sounds = ReplicatedStorage:WaitForChild("Sounds")
local UI_Assets = ReplicatedStorage:WaitForChild("UI_Assets")
local Morphs = ReplicatedStorage:WaitForChild("Morphs")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local Template = UI_Assets.Template

function Handler.init(ui)
    local _config = {
        Open = false,
    };

    local toggle = ui:FindFirstChild("Toggle")
    local sfx_folder = ui:FindFirstChild("SFX")

    local holder_Frame = ui:FindFirstChild("Holder")

    local functions = {
        play_sound = function(sound, parent)
            if (sound ~= nil and parent ~= nil) then
               local clone = sound:Clone()
               clone.Parent = parent
               clone:Play()
               Debris:AddItem(clone, clone.TimeLength)
            end
        end,

        update_info = function(_info)
            if (_info == nil) then
                return;
            end
            -- TODO: Add update list stuff.

        end,

        update_list = function(list)
            if (list == nil) then
                return;
            end

            for _,obj in pairs(list:GetChildren()) do
                if (obj:IsA("Frame")) then
                    obj:Destroy()
                end
            end

            -- loop through morph folder

            for _,morph in pairs(Morphs:GetChildren()) do
                local temp_clone = Template:Clone()
                temp_clone.Name = morph.Name
                temp_clone.Button.Text = "<b>"..morph.Name.."</b>"
                temp_clone.Parent = list

                temp_clone.Button.MouseButton1Click:Connect(function()
                    spawn(function()
                        temp_clone.Button.TextColor3 = Color3.fromRGB(235, 216, 110)
                        wait(.2)
                        temp_clone.Button.TextColor3 = Color3.fromRGB(255,255,255)
                    end)
                    local clone = Sounds.Click:Clone()
                    clone.Parent = sfx_folder
                    clone:Play()
                    Debris:AddItem(clone, clone.TimeLength)

                    Remotes._Morph:FireServer({
                        Action = "Morph",
                        ["Morph"] = morph,
                    })
                end)

            end
        end
    };

    toggle.MouseButton1Click:Connect(function()
        spawn(function()
            toggle.TextColor3 = Color3.fromRGB(235, 216, 110)
            wait(.2)
            toggle.TextColor3 = Color3.fromRGB(255,255,255)
        end)

        functions.play_sound(Sounds.Click, sfx_folder)

        _config.Open = (not _config.Open)

        if (_config.Open == true) then
            holder_Frame:TweenPosition(UDim2.new(0.499,0,0.452,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5, true)
            functions.update_list(holder_Frame.List.Scrolling)
        end
        if (_config.Open == false) then
            holder_Frame:TweenPosition(UDim2.new(0.499,0,-0.5,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5, true)
        end
    end)

    warn("Successfully initiated script(s) for Morph_UI...")
end


return Handler;