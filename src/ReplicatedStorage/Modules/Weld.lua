-- Weld Object
--[[
]]

local Players = game:GetService("Players")
local Storage = game:GetService("ReplicatedStorage")

local Modules = Storage:WaitForChild("Modules")

local Morphs = Storage:WaitForChild("Morphs")

local module = {};

function module:Weld(target, morph)
	if Morphs:FindFirstChild(morph) then
		-- weld things here
		local Player = Players:GetPlayerFromCharacter(target)
		if Player then
			
			if Player.Character:FindFirstChild(morph) then
				warn("[WELD SYSTEM] ".. Player.Name.." already has the morph: ".. morph.." welded to him/her.")
				return "Error"
			end
			
			local Morph = Morphs[morph]
			local Clone = Morph:Clone()
			
			Clone.Parent = Player.Character
			
			for _,v in pairs(Clone:GetChildren()) do
				if Player.Character:FindFirstChild(v.Name) then
					local inst = Instance.new("Motor6D", v)
					inst.Name = "Weld"
					inst.Part0 = v.PrimaryPart
					inst.Part1 = Player.Character[v.Name]
				end
			end
			warn("[WELD SYSTEM] Successfully welded ".. morph.. " to ".. Player.Name..'.')
		else
			return "Error"
		end
		
	else
		return "Error"
	end
end



return module