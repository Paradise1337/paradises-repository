gamesystem = gamesystem or {};
gamesystem.store = gamesystem.store or {};

function gamesystem:AddGame(sName, fCallBack, concmd, modifyColor, team)
	modifyColor = modifyColor or nil;
		
	gamesystem.store[sName] = {}
	
	local data = gamesystem.store[sName]
	data.name = sName or "unknown"
	data.callback = fCallBack
	data.concmd = concmd or sName
	data.modCol = modifyColor
	
	MsgC(Color(0,0,255), "Game "..sName.." has loaded!\n") 
	if SERVER then
		concommand.Add(concmd, function(ply)
			--if !ply:GetWarden() then return end
			data.callback(ply)
			netstream.Start(nil, "gsRuningGame", data.name)
			netstream.Start(nil, "gsGameRun", true)
			gamesystem.RuningGame = data.name
			gamesystem.GameRun = true
		end)
	end
end

local colorRm = 0;
local approachOne = 1;
local lastHealth = 0;
local ft;
hook.Add( "RenderScreenspaceEffects", "JB.RenderScreenspaceEffects.ProcessHealthEffects", function()
	if gamesystem.GameRun and gamesystem.store[gamesystem.RuningGame].modCol then  
			DrawColorModify(gamesystem.store[gamesystem.RuningGame].modCol);
	elseif LocalPlayer():GetObserverMode() == OBS_MODE_NONE then
		local ft = FrameTime();

		if lastHealth != LocalPlayer():Health() then
			approachOne = 0;
		end
		lastHealth = LocalPlayer():Health();

		approachOne = Lerp(ft*5,approachOne,1);

		colorRm = Lerp(ft/4 * 3,colorRm,(math.Clamp(LocalPlayer():Health(),0,40)/40)*0.8);

		local tab = {}
		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = -.05 + approachOne*.05
		tab[ "$pp_colour_contrast" ] = 1.1 - approachOne*.1
		tab[ "$pp_colour_colour" ] = 1 - (.8 - colorRm)
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0
		
		DrawColorModify( tab )
		
	end
end)

function gamesystem:MessageStartGame(game)
	if SERVER then 
		umsg.Start( "MessageOfStartGame" )
			umsg.String(game)
		umsg.End()
	end
end

function gamesystem:MessageStopGame(game)
	if SERVER then 
		umsg.Start( "MessageOfStopGame" )
			umsg.String(game)
		umsg.End()
	end
end

usermessage.Hook("MessageOfStartGame", function( um, ply )
	local name = um:ReadString()
	chat.AddText(Color(0, 150, 255, 255), "Надзиратель", Color(255, 255, 255, 255), " Запустил игру - ", Color(0, 150, 255, 255), name)
end)
		
usermessage.Hook("MessageOfStopGame", function( um, ply )
	local name = um:ReadString()
	chat.AddText(Color(0, 150, 255, 255), name, Color(255,255,255), " была остановлена!")
end)

function gamesystem.vFreeze(ply, time)
	ply:Freeze( true )
	timer.Simple(time, function() 
		if ply:IsValid() then 
			ply:Freeze( false )
		end
	end)
end

function gamesystem.vGod(ply, time)
	ply:GodEnable( )
	timer.Simple(time, function() 
		if ply:IsValid() then 
			ply:GodDisable()
		end
	end)
end

function gmjbInclude(name)
	local isShared = (string.find(name, "sh_") or string.find(name, "shared.lua"));
	local isClient = (string.find(name, "cl_") or string.find(name, "cl_init.lua"));
	local isServer = string.find(name, "sv_");
	
	if (isServer and !SERVER) then return end;
	
	if (isShared and SERVER) then
		AddCSLuaFile(name);
	elseif (isClient and SERVER) then
		AddCSLuaFile(name);
		return;
	end;
	
	include(name);
end;

function gmjbIncludeDirectory(directory)
	directory = "gamesystem/"..directory;
	
	if (string.sub(directory, -1) != "/") then
		directory = directory.."/";
	end;
	
	for k, v in pairs(file.Find(directory.."*.lua", "LUA")) do
		gmjbInclude(directory..v);
	end;
end;

gmjbIncludeDirectory("games")