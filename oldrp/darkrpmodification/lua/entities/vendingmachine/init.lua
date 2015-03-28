/*=== === === ===
Created by Paradise1337
Design by Paradise
===	===	===	===*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props/cs_office/Vending_machine.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self.damage = 250
	self.price = 10
	self.locked = false
	self:Setbom(false)
end

function ENT:OnTakeDamage(dmg)
	if dmg:GetAttacker():isCP() then 
		dmg:GetAttacker():addMoney(-50)
		dmg:GetAttacker():ChatPrint("За порчу имущества вам выписан штраф на 50$ (вы его уже оплатили)")
		return
	end
	if self.locked then return end
	self.damage = self.damage - dmg:GetDamage()
	if (self.damage <= 0) then
		self.locked = true
		local vPoint = self:GetPos()
		local effectdata = EffectData()
		effectdata:SetStart(vPoint)
		effectdata:SetOrigin(vPoint)
		effectdata:SetScale(1)
		self:Setbom(true)
		util.Effect("Explosion", effectdata)
		timer.Create(self:EntIndex().."water", 0.1,15, function()
			self:createWater()
		end)
		timer.Simple(180, function()
			local effectdata = EffectData()
			effectdata:SetStart(vPoint)
			effectdata:SetOrigin(vPoint)
			effectdata:SetScale(10)
			util.Effect("Sparks", effectdata)
			util.Effect("ElectricSpark", effectdata)
			util.Effect("Sparks", effectdata)
			self:EmitSound("ambient/energy/spark5.wav")
			self.locked = false
			self.damage = 250
			self:Setbom(false)
		end)
	end
end

function ENT:Use(activator,caller)
	if self.locked then return end
	if !activator:canAfford(self.price) then return end
	self.locked = true
	activator:addMoney(-self.price)
	self:EmitSound("ambient/levels/labs/coinslot1.wav")

	timer.Create(self:EntIndex().."water", 1, 1, function()
		self:createWater()
		self.locked = false
		self:EmitSound("buttons/button4.wav")
		if activator:IsSuperVIP() then
			self.locked = true
			timer.Create(self:EntIndex().."water", 1, 1, function()
				self:createWater()
				self.locked = false
				self:EmitSound("buttons/button4.wav")
			end)
		end
	end)
end

function ENT:createWater()
	self:EmitSound("items/nvg_off.wav")
	local Ang = self:GetAngles()
	local TextAng = Ang

	TextAng:RotateAroundAxis(TextAng:Right(), 90)

	local ent = ents.Create("water")
	ent:SetPos(self:GetPos()+ Ang:Right() * 20 + Ang:Forward() * 17)
	ent:SetAngles(TextAng)
	ent:Spawn()
	ent:Activate()

	timer.Simple( 30, function() if IsValid(ent) then ent:Remove() end end )
end

function ENT:Think()
end

function ENT:OnRemove()
	timer.Destroy(self:EntIndex().."water")
end


/* -- Save\Load Entities -- */
local function SaveItems()
	local itemTable = {};
	local v = "vendingmachine"
		for r, e in pairs(ents.FindByClass(tostring(v))) do
			local pos = e:GetPos()
			local ang = e:GetAngles()
			
			table.insert( itemTable, {pos, ang, v} )  
			if (r == #ents.FindByClass(tostring(v))) then
				compTable = pon.encode( itemTable )
				file.Write("vendmachine_"..tostring(game.GetMap())..".txt", compTable)
			end
		end
end 

local function LoadItems()
	if (!file.Exists("vendmachine_"..tostring(game.GetMap())..".txt", "DATA")) then return end
	local data = file.Read("vendmachine_"..tostring(game.GetMap())..".txt", "DATA")
	local decompData = pon.decode(data)
	local ent = {}

	for k, v in pairs(decompData) do
		ent[""..k] = ents.Create(v[3])
		if (ent[""..k]:IsValid()) then
			ent[""..k]:SetPos(v[1])
			ent[""..k]:SetAngles(v[2])
			ent[""..k]:Spawn()
			ent[""..k]:Activate()

			local phys = ent[""..k]:GetPhysicsObject()
			phys:EnableMotion(false) 
		end
	end
end 

hook.Add("ShutDown", "venmachShutDown", function()
	SaveItems()
end)

hook.Add("InitPostEntity", "venmachInitialize", function()
	LoadItems()
end)

concommand.Add("ClearWater", function(ply)
	if !ply:IsAdmin() then return end
	for _, v in pairs(ents.FindByClass("water")) do
		v:Remove()
	end
end)

hook.Add("Tick", "WaterProtect", function()
	for _, v in pairs(ents.FindByClass("water")) do
		if #ents.FindByClass("water") > 30 then
			v:Remove()
		end
	end
end)

concommand.Add('SaveVM', function(ply)
	if (!ply:IsPlayer()) then
		SaveItems()
	end
end)

concommand.Add('LoadVM', function(ply)
	if (!ply:IsPlayer()) then
		LoadItems()
	end
end)

concommand.Add('RemVM', function(ply)
	if (!ply:IsPlayer()) then
		local v = "up_vendingmachine"
		for r, e in pairs(ents.FindByClass(tostring(v))) do
			e:Remove()
		end
	end
end)