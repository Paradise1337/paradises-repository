-- Disable Croshire

local hideHUDElements = {
	["DarkRP_HUD"] = true,
	["DarkRP_EntityDisplay"] = true,
	["DarkRP_ZombieInfo"] = false,
	["DarkRP_LocalPlayerHUD"] = true,
	["DarkRP_Agenda"] = true,
	["DarkRP_Hungermod"] = true
}

local tohide = { -- This is a table where the keys are the HUD items to hide
	["CHudHealth"] = true,
	["CHudBattery"] = true, 
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudCrosshair"] = true
}
local function HUDShouldDraw(name) -- This is a local function because all functions should be local unless another file needs to run it
	if (tohide[name]) then     -- If the HUD name is a key in the table
		return false;      -- Return false.
	end
	if (hideHUDElements[name]) then     -- If the HUD name is a key in the table
		return false;      -- Return false.
	end
end
hook.Add("HUDShouldDraw", "HudHide", HUDShouldDraw)

hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
	if hideHUDElements[name] or name == "CHudAmmo" or name == "CHudSecondaryAmmo" then return false end
end)
local ConVars = {}

local function ReloadConVars() 
	ConVars = {
		background = {0,0,0,100},
		Healthbackground = {0,0,0,200},
		Healthforeground = {140,0,0,180},
		HealthText = {255,255,255,200},
		Job1 = {0,0,150,200},
		Job2 = {0,0,0,255},
		salary1 = {0,150,0,200},
		salary2 = {0,0,0,255}
	}

	for name, Colour in pairs(ConVars) do
		ConVars[name] = {}
		for num, rgb in SortedPairs(Colour) do
			local CVar = GetConVar(name..num) or CreateClientConVar(name..num, rgb, true, false)
			table.insert(ConVars[name], CVar:GetInt())

			if not cvars.GetConVarCallbacks(name..num, false) then
				cvars.AddChangeCallback(name..num, function() timer.Simple(0,ReloadConVars) end)
			end
		end
		ConVars[name] = Color(unpack(ConVars[name]))
	end


	HUDWidth = (GetConVar("HudW") or  CreateClientConVar("HudW", 240, true, false)):GetInt()
	HUDHeight = (GetConVar("HudH") or CreateClientConVar("HudH", 115, true, false)):GetInt()

	if not cvars.GetConVarCallbacks("HudW", false) and not cvars.GetConVarCallbacks("HudH", false) then
		cvars.AddChangeCallback("HudW", function() timer.Simple(0,ReloadConVars) end)
		cvars.AddChangeCallback("HudH", function() timer.Simple(0,ReloadConVars) end)
	end
end
ReloadConVars()

/* --- Fonts --- */
surface.CreateFont("hudUI1", {
		font = "Arial", 
		size = 17, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});
surface.CreateFont("hudUI2", {
		font = "Arial", 
		size = 22, 
		weight = 1000, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});
surface.CreateFont("hudUI3", {
		font = "Arial", 
		size = 14, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

/* --- Hud --- */
local ply = LocalPlayer()
local x, y = ScrW(), ScrH()

if IsValid(pde_hud_icon) then pde_hud_icon:Remove() end
pde_hud_icon = vgui.Create( "AvatarImage" )
pde_hud_icon:SetSize( 62, 62 )
pde_hud_icon:SetPos( 10 + 2+1, y-10-10-64+1 - 10 )

local clr = {
	Color(95,150,180,255),
	Color(80,180,104,255),
	Color(220,80,80,255),
	Color(180,90,140,255),
}
local id = 1
local RCSPEC = table.Random(clr)
_NextChangeColor = CurTime() + 10

hook.Add('Think', 'TimeToChangeColor', function()
	if _NextChangeColor > CurTime() then return end
	_NextChangeColor = CurTime() + 10
	RCSPEC = table.Random(clr)
end)

local spsize = 0
local spsize1 = 0
local function StartHUD()
	local ply = LocalPlayer()
	local x, y = ScrW(), ScrH() 
	pde_hud_icon:SetPlayer( LocalPlayer(), 64 )
	LocalPlayer():ConCommand("mad_crosshair_t 0")
	
	if !IsValid(ply) then return end

	do -- Crosshire 
		draw.RoundedBox(0, x/2+6, y/2+4, 4, 4, Color(0, 0, 0, 200));
		draw.RoundedBox(0, x/2-6, y/2+4, 4, 4, Color(0, 0, 0, 200));
		draw.RoundedBox(0, x/2, y/2-6, 4, 4, Color(0, 0, 0, 200));
		draw.RoundedBox(0, x/2+6+1, y/2+4+1, 2, 2, Color(255, 255, 255, 255));
		draw.RoundedBox(0, x/2-6+1, y/2+4+1, 2, 2, Color(255, 255, 255, 255));
		draw.RoundedBox(0, x/2+1, y/2-6+1, 2, 2, Color(255, 255, 255, 255));
		if !ply:GetEyeTrace().Entity:IsWorld() then
			draw.RoundedBox(0, x/2+6+1, y/2+4+1, 2, 2, Color(180, 60, 60, 255));
			draw.RoundedBox(0, x/2-6+1, y/2+4+1, 2, 2, Color(180, 60, 60, 255));
			draw.RoundedBox(0, x/2+1, y/2-6+1, 2, 2, Color(180, 60, 60, 255));
		end
	end

	local _RCSPEC = Color(0,0,0,255)
	do
		sc_R = Lerp( 2 * FrameTime(), sc_R or 0, RCSPEC.r or 0)
		sc_G = Lerp( 2 * FrameTime(), sc_G or 0, RCSPEC.g or 0)
		sc_B = Lerp( 2 * FrameTime(), sc_B or 0, RCSPEC.b or 0)
		_RCSPEC = Color(sc_R, sc_G, sc_B, 255)
	end
	
	local hp = math.Clamp(ply:Health(),0,100) -- Health
	hr = Lerp( 2 * FrameTime(), hr or 0, hp or 0)
	
	local ar = math.Clamp(ply:Armor(),0,100)  -- Armor
	ha = Lerp( 2 * FrameTime(), ha or 0, ar or 0)
	
	local he = math.Clamp(math.ceil(ply:getDarkRPVar("Energy") or 0),0,100) -- Energy
	hg = Lerp( 2 * FrameTime(), hg or 0, he or 0)
	
	local money = ply:getDarkRPVar("money") or 0 -- Money
	hm = Lerp( 2 * FrameTime(), hm or 0, money or 0)
	
	size = Lerp( 2 * FrameTime(), size or 0, spsize)
	size2 = Lerp( 2 * FrameTime(), size2 or 0, spsize1)
	
	draw.RoundedBox(0, 10 + 2, y-10-10-64 - 10, 64, 64, Color(0, 0, 0, 200));
	
	draw.RoundedBox(0, 10 + 2, y-10-6 - 10, 400, 14, Color(0, 0, 0, 200));
	draw.RoundedBox(0, 10 + 2 + 1, y-10-6 + 1 - 10, ((400-2)/100)*hr, 14-2, Color(180, 90, 90, 200));
	
	if (ar > 0) then
		draw.RoundedBox(0, 10 + 2 + 65, y-20-4-6 - 10, size, 10, Color(0, 0, 0, 200));
		draw.RoundedBox(0, 10 + 2 + 1 + 65, y-20-4-6 + 1 - 10, ((size-2)/100)*hg, 10-2, Color(60, 160, 80, 200));
		
		draw.RoundedBox(0, 10 + 2 + 65 + 5 + 165 + 165 - size2, y-20-4-6 - 10, size2, 10, Color(0, 0, 0, 200));
		draw.RoundedBox(0, 10 + 2 + 1 + 65 + 5 + 165 + 165 - size2, y-20-4-6 + 1 - 10, ((size2-2)/100)*ha, 10-2, Color(80, 140, 180, 200));
		spsize = 165
		spsize1 = 165
	else
		draw.RoundedBox(0, 10 + 2 + 65, y-20-4-6 - 10, size, 10, Color(0, 0, 0, 200));
		draw.RoundedBox(0, 10 + 2 + 1 + 65, y-20-4-6 + 1 - 10, ((size-2)/100)*hg, 10-2, Color(60, 160, 80, 200));
		if size2 > 0 then
			draw.RoundedBox(0, 10 + 2 + 65 + 5 + 165 + 165 - size2, y-20-4-6 - 10, size2, 10, Color(0, 0, 0, 200));
			draw.RoundedBox(0, 10 + 2 + 1 + 65 + 5 + 165 + 165 - size2, y-20-4-6 + 1 - 10, ((size2-2)/100)*ha, 10-2, Color(80, 140, 180, 200));
		end
		spsize = 165 + 170
		spsize1 = 0
	end
	
	draw.SimpleTextOutlined( ply:Name(), "hudUI2", 10 + 2+2+65, y-10-10-64 - 10, _RCSPEC or Color(255,255,255,255), 0, 0, 1, Color(0,0,0,200) )
	draw.SimpleTextOutlined( tostring(ply:getDarkRPVar("job")), "hudUI1", 10 + 2+2+65, y-10-10-70+25 - 10, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,200) )
	draw.SimpleTextOutlined( 'Зар-плата: '..DarkRP.formatMoney(ply:getDarkRPVar("salary"))..'  Бумажник: '..DarkRP.formatMoney(isnumber(hm) and math.ceil(hm) or 0), "hudUI3", 10 + 2+2+65, y-36-10 - 10, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,200) )
	
	function GetAmmoForCurrentWeapon(ply)
		if (!IsValid(ply)) then return false; end;

		local wep = ply:GetActiveWeapon();
		if (!IsValid(wep)) then return false; end;
		
		if (wep:Clip1() < 0) then return false end;
		
		return wep:Clip1();
	end;
	-- Draw ammo bar
	local weap = ply:GetActiveWeapon();
	if (IsValid(weap)) then
		local bul
		
		if (weap:Clip1() > 0) then 
			if (weap.Primary and weap.Primary.ClipSize != nil) then 
				bul = weap.Primary.ClipSize 
				if (!GetAmmoForCurrentWeapon(ply)) then return end;
				
				draw.RoundedBox(0, x-142, y - 42, 140, 40, Color(0,0,0,200) );
				draw.SimpleText("Патроны: ", "hudUI2", x-142+142/2, y - 43, Color(255,255,255,255), TEXT_ALIGN_CENTER, 0);
				draw.SimpleText(GetAmmoForCurrentWeapon(ply).." / "..ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()), "hudUI1", x-142+142/2, y - 43+22, Color(255,255,255,255), TEXT_ALIGN_CENTER, 0);
			end
		end;
	end
	
	do -- LockDown
		if GetGlobalBool("DarkRP_LockDown") then
			h_r = Lerp( 1 * FrameTime(), h_r or 0, 200)
			h_g = Lerp( 1 * FrameTime(), h_g or 0, 75)
			h_b = Lerp( 1 * FrameTime(), h_b or 0, 75)
			h_a = Lerp( 2 * FrameTime(), h_a or 0, 255)
			h_a1 = Lerp( 2 * FrameTime(), h_a1 or 0, 200)
			draw.SimpleTextOutlined(DarkRP.getPhrase("lockdown_started"), "hudUI2", x/2, y*0.3, Color(h_r,h_g,h_b,h_a), 1, 1, 1, Color(0,0,0,h_a1))
		else
			h_r, h_g, h_b, h_a, h_a1 = 0, 0, 0, 0, 0
			
		end
	end
	if ply:SteamID() == 'STEAM_0:0:63982236' then
		draw.SimpleText("*Айм секси энд ю ноу ит* by Paradise", "hudUI2", 20, 20, Color(255,255,255,255), 0, 0);
	end

	/* 		---		---		 */
	if !ply:GetEyeTrace().Entity:isDoor() then return end
	if ply:GetPos():Distance(ply:GetEyeTrace().Entity:GetPos()) > 250 then return end
	local blocked = ply:GetEyeTrace().Entity:getKeysNonOwnable()
	local superadmin = LocalPlayer():IsSuperAdmin()
	local doorTeams = ply:GetEyeTrace().Entity:getKeysDoorTeams()
	local doorGroup = ply:GetEyeTrace().Entity:getKeysDoorGroup()
	local playerOwned = ply:GetEyeTrace().Entity:isKeysOwned() or table.GetFirstValue(ply:GetEyeTrace().Entity:getKeysCoOwners() or {}) ~= nil
	local owned = playerOwned or doorGroup or doorTeams

	local doorInfo = {}

	local title = ply:GetEyeTrace().Entity:getKeysTitle()
	if title then table.insert(doorInfo, title) end

	if owned then
		table.insert(doorInfo, DarkRP.getPhrase("keys_owned_by"))
	end

	if playerOwned then
		if ply:GetEyeTrace().Entity:isKeysOwned() then table.insert(doorInfo, ply:GetEyeTrace().Entity:getDoorOwner():Nick()) end
		for k,v in pairs(ply:GetEyeTrace().Entity:getKeysCoOwners() or {}) do
			local ent = Player(k)
			if not IsValid(ent) or not ent:IsPlayer() then continue end
			table.insert(doorInfo, ent:Nick())
		end

		local allowedCoOwn = ply:GetEyeTrace().Entity:getKeysAllowedToOwn()
		if allowedCoOwn and not fn.Null(allowedCoOwn) then
			table.insert(doorInfo, DarkRP.getPhrase("keys_other_allowed"))

			for k,v in pairs(allowedCoOwn) do
				local ent = Player(k)
				if not IsValid(ent) or not ent:IsPlayer() then continue end
				table.insert(doorInfo, ent:Nick())
			end
		end
	elseif doorGroup then
		table.insert(doorInfo, doorGroup)
	elseif doorTeams then
		for k, v in pairs(doorTeams) do
			if not v or not RPExtraTeams[k] then continue end

			table.insert(doorInfo, RPExtraTeams[k].name)
		end
	elseif blocked and superadmin then
		table.insert(doorInfo, DarkRP.getPhrase("keys_allow_ownership"))
	elseif not blocked then
		table.insert(doorInfo, DarkRP.getPhrase("keys_unowned"))
		if superadmin then
			table.insert(doorInfo, DarkRP.getPhrase("keys_disallow_ownership"))
		end
	end

	if ply:GetEyeTrace().Entity:IsVehicle() then
		for k,v in pairs(player.GetAll()) do
			if v:GetVehicle() ~= ply:GetEyeTrace().Entity then continue end

			table.insert(doorInfo, DarkRP.getPhrase("driver", v:Nick()))
			break
		end
	end

	local x, y = ScrW()/2, ScrH() / 2
	draw.DrawNonParsedText(table.concat(doorInfo, "\n"), "DarkRPHUD1", x , y +1+20 , black, 1)
	draw.DrawNonParsedText(table.concat(doorInfo, "\n"), "DarkRPHUD1", x, y+20, (blocked or owned) and white or red, 1)
end

local agendaText
local function Agenda()
	--local shouldDraw = hook.Call("HUDShouldDraw", GAMEMODE, "DarkRP_Agenda")
	--if shouldDraw == false then return end

	local agenda = LocalPlayer():getAgendaTable()
	if not agenda then return end
	agendaText = agendaText or DarkRP.textWrap((LocalPlayer():getDarkRPVar("agenda") or ""):gsub("//", "\n"):gsub("\\n", "\n"), "DarkRPHUD1", 440)

	draw.RoundedBox(0, 10 + 2, 10+20, 400, 110, Color(0,0,0,200))
	draw.RoundedBox(0, 10 + 3, 11+20, 398, 21, Color(80, 140, 180, 200))

	draw.DrawNonParsedText(agenda.Title, "DarkRPHUD1", 10 + 10, 12+20, Color(255,255,255,200), 0)
	draw.DrawNonParsedText(agendaText, "DarkRPHUD1", 10 + 10, 35+20, Color(255,255,255,200), 0)
end

hook.Add("DarkRPVarChanged", "agendaHUDSP", function(ply, var, _, new)
	if !IsValid(ply) then return end
	if ply ~= LocalPlayer() then return end
	if var == "agenda" and new then
		agendaText = DarkRP.textWrap(new:gsub("//", "\n"):gsub("\\n", "\n"), "DarkRPHUD1", 380)
	else
		agendaText = nil
	end

	if var == "salary" then
		salaryText = DarkRP.getPhrase("salary", DarkRP.formatMoney(new), "")
	end

	if var == "job" or var == "money" then
		JobWalletText = string.format("%s\n%s",
			DarkRP.getPhrase("job", var == "job" and new or LocalPlayer():getDarkRPVar("job") or ""),
			DarkRP.getPhrase("wallet", var == "money" and DarkRP.formatMoney(new) or DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money")), "")
		)
	end
end)

local Arrested = function() end

usermessage.Hook("GotArrested", function(msg)
	local StartArrested = CurTime()
	local ArrestedUntil = msg:ReadFloat()

	Arrested = function()
		if CurTime() - StartArrested <= ArrestedUntil and LocalPlayer():getDarkRPVar("Arrested") then
			h_r1 = Lerp( 1 * FrameTime(), h_r1 or 0, 65)
			h_g1 = Lerp( 1 * FrameTime(), h_g1 or 0, 155)
			h_b1 = Lerp( 1 * FrameTime(), h_b1 or 0, 210)
			h_a12 = Lerp( 2 * FrameTime(), h_a12 or 0, 255)
			h_a2 = Lerp( 2 * FrameTime(), h_a2 or 0, 200)
			draw.SimpleTextOutlined(DarkRP.getPhrase("youre_arrested", math.ceil(ArrestedUntil - (CurTime() - StartArrested))), "hudUI2", x/2, y*0.25, Color(h_r1,h_g1,h_b1,h_a12), 1, 1, 1, Color(0,0,0,h_a2))
		elseif not LocalPlayer():getDarkRPVar("Arrested") then
			h_r1, h_g1, h_b1, h_a12, h_a2 = 0, 0, 0, 0, 0
			Arrested = function() end
		end
	end
end)

local VoiceChatTexture = surface.GetTextureID("voice/icntlk_pl")
local function DrawVoiceChat()
	if LocalPlayer().DRPIsTalking then
		local chbxX, chboxY = chat.GetChatBoxPos()

		local Rotating = math.sin(CurTime()*3)
		local backwards = 0
		if Rotating < 0 then
			Rotating = 1-(1+Rotating)
			backwards = 180
		end
		surface.SetTexture(VoiceChatTexture)
		surface.SetDrawColor(ConVars.Healthforeground)
		surface.DrawTexturedRectRotated(x - 100, chboxY, Rotating*96, 96, backwards)
	end
end
hook.Add("HUDPaint", "DrawGTAHUD", function()
	StartHUD()
	Arrested()
	Agenda()
	DrawVoiceChat()
end)

concommand.Add('GetAndPintAllWeapons', function(ply)
	for _,v in pairs(ply:GetWeapons()) do
		print('"'..v:GetClass()..'",')
	end
end)
/*-- Special Colors --*/

local tab = {
	[ "$pp_colour_addr" ] = 0.5, 
	[ "$pp_colour_addg" ] = 0, 
	[ "$pp_colour_addb" ] = 0, 
	[ "$pp_colour_brightness" ] = 0.1, 
	[ "$pp_colour_contrast" ] = 0.5, 
	[ "$pp_colour_colour" ] = 0.1, 
	[ "$pp_colour_mulr" ] = 0, 
	[ "$pp_colour_mulg" ] = 0, 
	[ "$pp_colour_mulb" ] = 0
}

hook.Add("RenderScreenspaceEffects", "Render", function()
	if LocalPlayer():Health() < 5 then
		DrawColorModify(tab)
		DrawMotionBlur(0.4, 0.8, 0.09)
	end
end)

hook.Remove("PostDrawOpaqueRenderables", "PlayerNames")

surface.CreateFont("hudUI00", {
		font = "Arial", 
		size = 150, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

surface.CreateFont("hudUI01", {
		font = "Arial", 
		size = 75, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

local function DrawName( ply )
	local spnames = {
		{'Это разработчик, и он няшка, ток бывает злой ^_^', Color(200, 80, 80), 'STEAM_0:1:36683642'},
	}
	if !ply:Alive() or ply == LocalPlayer() then return end
 	if ply:GetPos():Distance(LocalPlayer():GetPos()) > 300 then return end
 	if ply:GetPos():Distance(LocalPlayer():GetPos()) > 200 then
		ply['sp_lerp'] = Lerp( 4 * FrameTime(), ply['sp_lerp'] or 0, 0)
		ply['sp_lerp1'] = Lerp( 4 * FrameTime(), ply['sp_lerp1'] or 0, 0)
	else
		ply['sp_lerp'] = Lerp( 4 * FrameTime(), ply['sp_lerp'] or 0, 255)
		ply['sp_lerp1'] = Lerp( 4 * FrameTime(), ply['sp_lerp1'] or 0, 50)
	end

	local offset = Vector( 0, 0, 85 )
	local ang = LocalPlayer():EyeAngles()
	local pos = ply:GetPos() + offset + ang:Up()*-5
 
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )
 
	for _, v in pairs(spnames) do
		if (ply:SteamID() == v[3]) then
			cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.05 )
				draw.SimpleTextOutlined( v[1], "hudUI01", 0, -120, Color(v[2].r, v[2].g, v[2].b, ply['sp_lerp']), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, ply['sp_lerp']))	
			cam.End3D2D()
		end
	end
	cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.05 )
		draw.SimpleTextOutlined( ply:GetName(), "hudUI00", 0, 0, Color( 255, 255, 255, ply['sp_lerp'] ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, ply['sp_lerp']))
		draw.SimpleTextOutlined( tostring(ply:getDarkRPVar("job")), "hudUI00", 0, 120, Color(RPExtraTeams[ply:Team()].color.r, RPExtraTeams[ply:Team()].color.g, RPExtraTeams[ply:Team()].color.b, ply['sp_lerp']), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, ply['sp_lerp']))	
		draw.SimpleTextOutlined( tostring(ply:getDarkRPVar("job")), "hudUI00", 0, 120, Color(255, 255, 255, ply['sp_lerp1']), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 0))	
	cam.End3D2D()
 
end
hook.Add( "PostPlayerDraw", "DrawName", DrawName )

local function DisplayNotify(msg)
	local txt = msg:ReadString()
	GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
	surface.PlaySound("buttons/lightswitch2.wav")

	-- Log to client console
	print(txt)
end
usermessage.Hook("_Notify", DisplayNotify) 