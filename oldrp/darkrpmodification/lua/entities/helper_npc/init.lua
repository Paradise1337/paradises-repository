--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/Humans/Group02/male_09.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
 
	self:SetMaxYawSpeed( 180 )
end

function ENT:AcceptInput( Name, activator, Caller )
	if Name == "Use" and Caller:IsPlayer() then 
		activator:ConCommand("heeelps")
		self:EmitSound("vo/npc/male01/hi0"..tostring(math.random(1,2))..".wav", 100, 100, 1, CHAN_STATIC )
	end
end

/* -- Save\Load Entities -- */
local function SaveItems()
	local itemTable = {};
	local v = "helper_npc"
		for r, e in pairs(ents.FindByClass(tostring(v))) do
			local pos = e:GetPos()
			local ang = e:GetAngles()
			
			table.insert( itemTable, {pos, ang, v} )  
			if (r == #ents.FindByClass(tostring(v))) then
				compTable = pon.encode( itemTable )
				file.Write("npc_laws_"..tostring(game.GetMap())..".txt", compTable)
			end
		end
end 

local function LoadItems()
	if (!file.Exists("npc_laws_"..tostring(game.GetMap())..".txt", "DATA")) then return end
	local data = file.Read("npc_laws_"..tostring(game.GetMap())..".txt", "DATA")
	local decompData = pon.decode(data)
	local ent = {}

	for k, v in pairs(decompData) do
		ent[""..k] = ents.Create(v[3])
		if (ent[""..k]:IsValid()) then
			ent[""..k]:SetPos(v[1])
			ent[""..k]:SetAngles(v[2])
			ent[""..k]:Spawn()
			ent[""..k]:Activate()
		end
	end
end 

hook.Add("ShutDown", "npchShutDown", function()
	SaveItems()
end)

hook.Add("InitPostEntity", "npchInitialize", function()
	LoadItems()
end)

concommand.Add('SaveNPCH', function(ply)
	if (!ply:IsPlayer()) then
		SaveItems()
	end
end)

concommand.Add('LoadNPCH', function(ply)
	if (!ply:IsPlayer()) then
		LoadItems()
	end
end)