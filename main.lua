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