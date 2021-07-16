local DataStoreService = game:GetService("DataStoreService")
local myDataStore = DataStoreService:GetDataStore("myDataStore")

game.Players.PlayerAdded:Connect(function(player)
	
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local Buttons = Instance.new("IntValue")
	Buttons.Name = "Buttons"
	Buttons.Parent = leaderstats
	
	local playerUserId = "Player_"..player.UserId
	
	local data
	local success, errormessage = pcall(function()
		data = myDataStore:GetAsync(playerUserId)
	end)
	
	if success then
		Buttons.Value = data
		--[[
			-- This is for model loading via leaderstats
			for v = 1, Buttons.Value, 1 do
				if Buttons.Value ~= 0 then
					local part = game.Workspace["Part "..v]
					if v == data.Buttons then
						local spawnlocation = game.Workspace.SpawnLocation
						game.Workspace["Part 1"].Button1.Button.BillboardGui.Parent = part["Button"..v].Button
						spawnlocation.CFrame = CFrame.new(part["Button"..v].Button.Position)
						spawnlocation.Size = Vector3.new(part["Button"..v].Button.Size) 
						if v == 1 then
							game.Workspace.SpawnLocation.CanTouch = false
						end
					end
				else
					
					while wait() do
						if game.Workspace.Loading == false then
							game.Workspace.SpawnLocation.CanTouch = true
							break
						end
					end
					
				end
			end
			
			if Buttons.Value > 0 then
				for i, v in pairs(game.Players:GetPlayers()) do
					v.Character:BreakJoints()
				end
			end
		--]]
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	local playerUserId = "Player_"..player.UserId
	
	local data = player.leaderstats.Buttons.Value
	
	local success, errormessage = pcall(function()
		myDataStore:SetAsync(playerUserId, data)
	end)
	
	if success then
		print("Data Successfully saved!")
	else
		print("There was an error!")
		warn(errormessage)
	end
end) 
