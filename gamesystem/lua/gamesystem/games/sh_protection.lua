local gamesystem = gamesystem or {};
gmPD = gmPD or {}

local function Run(ply)
	if gmPD.Run or gamesystem.GameRun then return end

	gamesystem:MessageStartGame("Protection day")
	gmPD.Run = true
	
	umsg.Start( "gsSoundPlay" )
		umsg.String("games/protection.mp3")
	umsg.End()
	
	for k, v in pairs(player.GetAll()) do
		if (team.GetName(v:Team()) == "Guards") then 
			v:StripWeapons()
			v:Give("weapon_jb_fists")
			v:Give("weapon_jb_knife")
			v:Give("weapon_jb_ak47")
			v:Give("weapon_jb_deagle")
			v:EmitSound("items/ammopickup.wav")
			v:SetArmor(500)
			v:SetHealth(350)
		else 
			for _, r in pairs(ents.FindInSphere( v:GetPos(), 450 )) do
				if r:GetClass() == "func_door" then r:Fire("open") end
			end
			v:SetArmor(0)
			v:SetHealth(150)
			v:Give("weapon_jb_ak47")
			v:Give("weapon_jb_deagle")
			v:EmitSound("items/ammopickup.wav")
			gamesystem.vFreeze(v, 30)
			gamesystem.vGod(v, 30)
		end
	end
end

if SERVER then
	hook.Add("JailBreakRoundEnd", "gmPDEnd", function() 
		if !gmPD.Run then return end
		gmPD.Run = false
		gamesystem.GameRun = false
		netstream.Start(nil, "gsRuningGame", "")
		netstream.Start(nil, "gsGameRun", false)
		gamesystem:MessageStopGame("Protection day")
		gamesystem.RuningGame = ""
		for k, v in pairs(player.GetAll()) do
			v:Freeze(false)
			v:GodDisable()		
		end	
	end)
end
	
gamesystem:AddGame("Protection day", Run, "gmPD", nil)