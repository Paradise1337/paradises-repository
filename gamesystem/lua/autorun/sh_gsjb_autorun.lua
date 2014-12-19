include("gamesystem/sh_core.lua")
include("gamesystem/pon.lua")
include("gamesystem/von.lua")
include("gamesystem/netstream.lua")
AddCSLuaFile("gamesystem/sh_core.lua");
AddCSLuaFile("gamesystem/cl_derma.lua");
AddCSLuaFile("gamesystem/netstream.lua");
AddCSLuaFile("gamesystem/pon.lua");
AddCSLuaFile("gamesystem/von.lua");
if CLIENT then 
	include("gamesystem/cl_derma.lua")
end