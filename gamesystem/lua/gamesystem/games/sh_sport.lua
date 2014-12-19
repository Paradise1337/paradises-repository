local gamesystem = gamesystem or {};
gmSP = gmSP or {}

local function Run(ply)
	if gamesystem.GameRun then return end
	gmSP.Run = true
	local num = 0
	
	for k, v in pairs(player.GetAll()) do
		if (team.GetName(v:Team()) ~= "Guards" and v:Alive()) then 
			num = num + 1
		end
	end
	
	num = num / 2
	
	for k, v in pairs(player.GetAll()) do
		if (team.GetName(v:Team()) ~= "Guards" and v:Alive()) then 
			if num > 0 then 
				v:SetPlayerColor(Vector(.5,.5,0))
				num = num - 1
			else
				v:SetPlayerColor(Vector(.2,0,.5))
			end
		end
	end
end

if SERVER then
	hook.Add("JailBreakRoundEnd", "gmSPEnd", function()
		if !gmSP.Run then return end
		gmSP.Run = false
		for k, v in pairs(player.GetAll()) do
			if (team.GetName(v:Team()) ~= "Prisoners") then
				v:SetPlayerColor(Vector(.9,.9,.9))
			end			
		end	
	end)
end

	
gamesystem:AddGame("Sport", Run, "gmSP", nil)