local gamesystem = gamesystem or {};
gmDZ = gmDZ or {}

local function Run(ply)
	if gmDZ.Run or gamesystem.GameRun then return end

	gamesystem:MessageStartGame("DayZ")
	gmDZ.Run = true
	
	umsg.Start( "gsSoundPlay" )
		umsg.String("games/dayz.mp3")
	umsg.End()
	
	for k, v in pairs(player.GetAll()) do
		if (team.GetName(v:Team()) == "Guards") then 
			v:StripWeapons()
			v:Give("weapon_jb_fists")
			v:Give("weapon_jb_knife")
			v:Give("weapon_jb_ak47")
			v:Give("weapon_jb_deagle")
			v:EmitSound("items/ammopickup.wav")
			v:SetHealth(500)
		else 
			v:StripWeapons()
			v:Give("weapon_jb_fists")
			v:SetArmor(0)
			v:EmitSound("npc/zombie/zombie_voice_idle"..tostring(math.random(1,14))..".wav")
			v:SetHealth(2500)
			v:SetModel("models/player/zombie_classic.mdl")
			gamesystem.vFreeze(v, 30)
			gamesystem.vGod(v, 30)
			for _, r in pairs(ents.FindInSphere( v:GetPos(), 450 )) do
				if r:GetClass() == "func_door" then r:Fire("open") end
			end 
			timer.Simple(30, function()
				umsg.Start( "gsSoundPlay" )
					umsg.String("ambient/atmosphere/thunder3.wav")
				umsg.End()
			end)
		end
	end
end

if SERVER then
	hook.Add("JailBreakRoundEnd", "gmDZEnd", function()
		if !gmDZ.Run then return end
		gmDZ.Run = false
		gamesystem.GameRun = false
		netstream.Start(nil, "gsRuningGame", "")
		netstream.Start(nil, "gsGameRun", false)
		gamesystem:MessageStopGame("DayZ")
		gamesystem.RuningGame = ""
		for k, v in pairs(player.GetAll()) do
			v:Freeze(false)
			v:GodDisable()
		end	
	end)
	
	hook.Add("PlayerCanPickupWeapon", "gmDZCanPickup", function(ply, wep)
		if gmDZ.Run and gamesystem.GameRun then
			if team.GetName(ply:Team()) == "Prisoners" then
				return false
			end
		end
	end)
	
	hook.Add("EntityTakeDamage", "gmDZDamage", function(target, dmginfo)
		if gmDZ.Run and gamesystem.GameRun then
			if dmginfo:GetAttacker():IsPlayer() and team.GetName(dmginfo:GetAttacker():Team()) == "Prisoners" then
				dmginfo:SetDamageType( DMG_DISSOLVE )
				dmginfo:AddDamage( 125 )
			elseif dmginfo:GetAttacker():IsPlayer() and team.GetName(target:Team()) ~= "Guards" then
				target:Ignite(2)
				target:SetVelocity((dmginfo:GetAttacker():GetPos() - target:GetPos()) * -5)
			end
		end
	end)
end

local color = {};
color["$pp_colour_addr"] = 0.2; 
color["$pp_colour_addg"] = 0;
color["$pp_colour_addb"] = 0;
color["$pp_colour_contrast"] = 1.5;
color["$pp_colour_brightness"] = -0.35;
color["$pp_colour_colour"] = 0.9;
color["$pp_colour_mulr"] = 0.2;
color["$pp_colour_mulg"] = 0;
color["$pp_colour_mulb"] = 0;
	
gamesystem:AddGame("DayZ", Run, "gmDZ", color)