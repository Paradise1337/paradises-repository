local gamesystem = gamesystem or {};
gmHaS = gmHaS or {}

local function Run(ply)
	if timer.Check("Hide and seek") or gmHaS.Run or gamesystem.GameRun then return end

	gamesystem:MessageStartGame("Hide and seek")
	gmHaS.Run = true
	
	umsg.Start( "gsDarkenScreen" )
		umsg.Float(60)
		umsg.Bool(true)
	umsg.End()
	
	umsg.Start( "gsSoundPlay" )
		umsg.String("games/hideandseek.mp3")
	umsg.End()
	
	for k, v in pairs(player.GetAll()) do
		if not (team.GetName(v:Team()) == "Guards") then 
			v:Give("weapon_jb_knife")
			v:Give("weapon_jb_fiveseven")
			v:SetPlayerColor(Vector(0,0,0))
			
			for _, r in pairs(ents.FindInSphere( v:GetPos(), 450 )) do
				if r:GetClass() == "func_door" then r:Fire("open") end
			end
		else 
			v:SetArmor(250)
			v:SetHealth(1500)
			gamesystem.vFreeze(v, 60)
			gamesystem.vGod(v, 60)
		end
	end
end
if SERVER then
	hook.Add("JailBreakRoundEnd", "gmHaSEnd", function()
		if !gmHaS.Run then return end
		gmHaS.Run = false
		gamesystem.GameRun = false
		netstream.Start(nil, "gsRuningGame", "")
		netstream.Start(nil, "gsGameRun", false)
		gamesystem:MessageStopGame("Hide and seek")
		gamesystem.RuningGame = ""
		umsg.Start( "gsDarkenScreenClose" )
		umsg.End()
		for k, v in pairs(player.GetAll()) do
			v:Freeze(false)
			v:GodDisable()
			v:SetPlayerColor(Vector(.9,.9,.9))
			v:ConCommand("stopsound")
			v.sound = false
		end	
	end)
	
	hook.Add("PlayerCanPickupWeapon", "gmHaSCanPickup", function(ply, wep)
		if gmHaS.Run and gamesystem.GameRun then
			if team.GetName(ply:Team()) == "Prisoners" then
				return false
			end
		end
	end)
	
	hook.Add("Think", "gmHeartBeat",function()
		if !gmHaS.Run then return end
		for k, v in pairs(player.GetAll()) do
			if !v.sound and team.GetName(v:Team()) == "Prisoners" then
				v.sound = true
				v:EmitSound("player/heartbeat1.wav")
			end
		end
	end)
	
	hook.Add("EntityTakeDamage", "gmHaSDamage", function(target, dmginfo)
		if gmHaS.Run and gamesystem.GameRun then
			if target:IsPlayer() and team.GetName(target:Team()) == "Prisoners" and not target.Alert then
				target.Alert = true
				target:EmitSound("npc/stalker/go_alert2a.wav")
				timer.Simple(30, function()
					if target:IsValid() and target:Alive() then
						target.Alert = false
					end
				end)
			end
		end
	end)
end

local color = {};
color["$pp_colour_addr"] = 0.22;
color["$pp_colour_addg"] = 0.22;
color["$pp_colour_addb"] = 0;
color["$pp_colour_contrast"] = 1.5;
color["$pp_colour_brightness"] = -0.65;
color["$pp_colour_colour"] = 0.25;
color["$pp_colour_mulr"] = 0;
color["$pp_colour_mulg"] = 0;
color["$pp_colour_mulb"] = 0;
	
gamesystem:AddGame("Hide and seek", Run, "gmHaS", color, TEAM_GUARD)