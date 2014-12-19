local gamesystem = gamesystem or {};
gmHS = gmHS or {}

local function Run(ply)
	if gmHS.Run or gamesystem.GameRun then return end

	gamesystem:MessageStartGame("Hidden simon")
	gmHS.Run = true
	
	umsg.Start( "gsSoundPlay" )
		umsg.String("games/protection.mp3")
	umsg.End()
	
	for k, v in pairs(player.GetAll()) do
		if (v:GetWarden()) then 
			v:StripWeapons()
			v:Give("weapon_jb_fists")
			gamesystem.vFreeze(v, 30)
			gamesystem.vGod(v, 30)
			v:DrawShadow( false )
			v:SetMaterial( "models/effects/vol_light001" )
			v:SetRenderMode( RENDERMODE_TRANSALPHA )
			v:Fire( "alpha", 0, 0 )
			v:SetRunSpeed( 400 )
			gmHS.ply = v
		end
	end
end

if SERVER then
	hook.Add("JailBreakRoundEnd", "gmHSEnd", function() 
		if !gmHS.Run then return end
		gmHS.Run = false
		gamesystem.GameRun = false
		netstream.Start(nil, "gsRuningGame", "")
		netstream.Start(nil, "gsGameRun", false)
		gamesystem:MessageStopGame("Hidden simon")
		gamesystem.RuningGame = ""
		gmHS.ply:DrawShadow( true )
		gmHS.ply:SetMaterial( "" )
		gmHS.ply:SetRenderMode( RENDERMODE_NORMAL )
		gmHS.ply:Fire( "alpha", 255, 0 )
		gmHS.ply:SetRunSpeed( gmHS.ply.originalRunSpeed )
	end)
	
	
	hook.Add("PlayerCanPickupWeapon", "gmHSCanPickup", function(ply, wep)
		if gmHS.Run and gamesystem.GameRun then
			if ply:GetWarden() then
				return false
			end
		end
	end)
end
	
gamesystem:AddGame("Hidden simon", Run, "gmHS", nil)