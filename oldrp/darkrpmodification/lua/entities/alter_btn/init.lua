/*=== === === ===
Created by Paradise1337
Design by Paradise
===	===	===	===*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
local links = {
	steam = 'steamcommunity.com/groups/OLDR-P',
	vk = 'vk.com/oldr_p',
	owner = 'http://vk.com/m_e_t_r_o_2_0_3_3',
	par = 'http://vk.com/Paradise-1337',
	don = 'http://vk.com/page-89839485_50901279',
}
function ENT:Initialize()
	self:SetModel("models/hunter/plates/plate075x075.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self:SetNWString('data', '')
end

function ENT:Use(activator,caller)
	activator:ChatPrint(links[self:GetNWString('data')])
	activator:SendLua("gui.OpenURL('"..self:GetNWString('data').."')")
end

function ENT:Think()
end

function ENT:OnRemove()
end


/* -- Save\Load Entities -- */
local function SaveItems()
	local itemTable = {};
	local v = "alter_btn"
		for r, e in pairs(ents.FindByClass(tostring(v))) do
			local pos = e:GetPos()
			local ang = e:GetAngles()
			local data = e:GetNWString('data')
			table.insert( itemTable, {pos, ang, v, data} )  
			if (r == #ents.FindByClass(tostring(v))) then
				compTable = pon.encode( itemTable )
				file.Write("mbut_"..tostring(game.GetMap())..".txt", compTable)
			end
		end
end 

local function LoadItems()
	if (!file.Exists("mbut_"..tostring(game.GetMap())..".txt", "DATA")) then return end
	local data = file.Read("mbut_"..tostring(game.GetMap())..".txt", "DATA")
	local decompData = pon.decode(data)
	local ent = {}

	for k, v in pairs(decompData) do
		ent[""..k] = ents.Create(v[3])
		if (ent[""..k]:IsValid()) then
			ent[""..k]:SetPos(v[1])
			ent[""..k]:SetAngles(v[2])
			ent[""..k]:Spawn()
			ent[""..k]:Activate()
			ent[""..k]:SetNWString('data', v[4])
			local phys = ent[""..k]:GetPhysicsObject()
			phys:EnableMotion(false) 
		end
	end
end 

hook.Add("ShutDown", "mbShutDown", function()
	SaveItems()
end)

hook.Add("InitPostEntity", "mbInitialize", function()
	LoadItems()
end)

concommand.Add('SaveMB', function(ply)
	if (!ply:IsPlayer()) then
		SaveItems()
	end
end)

concommand.Add('LoadMB', function(ply)
	if (!ply:IsPlayer()) then
		LoadItems()
	end
end)

concommand.Add('MB__Set', function(ply, _, args)
	if ply:IsSuperAdmin() and ply:GetEyeTrace().Entity:GetClass() == 'alter_btn' then
		ply:GetEyeTrace().Entity:SetNWString('data', args[1])
	end
end)