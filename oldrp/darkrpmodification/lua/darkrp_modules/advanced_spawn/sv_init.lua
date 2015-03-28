local pos = {
	Vector(-965, 1690, -355),
	Vector(-965, 1615, -355),
	Vector(-1055, 1690, -355),
	Vector(-1055, 1615, -355),
	Vector(-1140, 1690, -355),
	Vector(-1140, 1615, -355),
}
hook.Add("PlayerSpawn", "TeleportToRealSpawn", function(ply)
	--ply:SetPos(table.Random(pos))
end)

timer.Simple(1, function()
	function GAMEMODE:PlayerNoClip( ply )
		return ply:IsAdmin()
	end
	function GAMEMODE:PlayerCanHearPlayersVoice(listener, talker)
		return false, false
	end
end)