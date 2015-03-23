/*=== === === ===
Created by Paradise1337
Design by Paradise
===	===	===	===*/

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local PrintMore
function ENT:Initialize()
	self:SetModel("models/props_c17/consolebox01a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetNWString("class", _AdvancedMPConfig.StandartClass)
	self:SetNWInt("cash", 0)
	self:SetNWInt("dmg", _AdvancedMPConfig.Levels[self:GetNWString("class")].maxHealth)
	self:SetNWInt("arm", 100)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self.IsMoneyPrinter = true
	local t = CurTime() + _AdvancedMPConfig.Levels[self:GetNWString("class")].printtime
	self:SetNWInt("nextPrint", t)
	self.sound = CreateSound(self, Sound("ambient/levels/labs/equipment_printer_loop1.wav"))
	self.sound:SetSoundLevel(52)
	self.sound:PlayEx(1, 100)
end

function ENT:Use(activator,caller)
	activator:addMoney(self:GetNWInt("cash"))
	self:SetNWInt("cash", 0)
end

function ENT:OnTakeDamage(dmg)
	if self:GetNWInt("arm") > 0 and dmg:GetDamage() < self:GetNWInt("arm") then 
		self:SetNWInt("arm", (self:GetNWInt("arm") or 100) - dmg:GetDamage())
		return
	elseif self:GetNWInt("arm") > 0 and dmg:GetDamage() > self:GetNWInt("arm") then 
		dmg:SetDamage(dmg:GetDamage() - self:GetNWInt("arm"))
		self:SetNWInt("arm", 0)
	elseif self:GetNWInt("arm") > 0 and dmg:GetDamage() == self:GetNWInt("arm") then 
		self:SetNWInt("arm", 0)
		return
	end
	self:SetNWInt("dmg", (self:GetNWInt("dmg") or 100) - dmg:GetDamage())
	if self:GetNWInt("dmg") <= 0 then
		self:Destruct()
		self:Remove()
	end
end 

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
end

function ENT:Think()
	if tonumber(self:GetNWInt("nextPrint")) < CurTime() then
		local eowner = self:Getowning_ent()
		local procent = eowner == nil and 10 or eowner:IsSuperAdmin() and 10 or eowner:IsUserGroup("vip") and 10 
		local endprocent = _AdvancedMPConfig.Levels[self:GetNWString("class")].print / 100 * procent
		self:SetNWInt("cash", math.Clamp(self:GetNWInt("cash") + endprocent + _AdvancedMPConfig.Levels[self:GetNWString("class")].print, 0, _AdvancedMPConfig.Levels[self:GetNWString("class")].maxCash))
		self:SetNWInt("nextPrint", CurTime() + _AdvancedMPConfig.Levels[self:GetNWString("class")].printtime)
	end
	
	if self:WaterLevel() > 0 then
		self:Destruct()
		self:Remove()
		return
	end
end

function ENT:Upgrade()
	if !_AdvancedMPConfig.CanUpgrade(self) then return end
	self:SetNWString("class", _AdvancedMPConfig.NextClass(self))
	local t = CurTime() + _AdvancedMPConfig.Levels[self:GetNWString("class")].printtime
	self:SetNWInt("nextPrint", t)
	self:SetNWInt("dmg", _AdvancedMPConfig.Levels[self:GetNWString("class")].maxHealth)
end

function ENT:OnRemove()
	if self.sound then
		self.sound:Stop()
	end
end
hook.Add("PlayerSay", "cmdOfPrinter", function( ply, text, team )
	if ply:GetEyeTrace().Entity:GetClass() != "adv_money_printer" then return end
	if (text == "/upgrade") then
		if _AdvancedMPConfig.CanUpgrade(ply:GetEyeTrace().Entity) then
			if !ply:canAfford(_AdvancedMPConfig.Levels[_AdvancedMPConfig.NextClass(ply:GetEyeTrace().Entity)].price) then return end
			ply:addMoney(-_AdvancedMPConfig.Levels[_AdvancedMPConfig.NextClass(ply:GetEyeTrace().Entity)].price)
			DarkRP.notify( ply, 2, 4, "Вы заплатили: $".._AdvancedMPConfig.Levels[_AdvancedMPConfig.NextClass(ply:GetEyeTrace().Entity)].price )
			ply:GetEyeTrace().Entity:Upgrade()
			ply:GetEyeTrace().Entity:EmitSound("ambient/levels/labs/coinslot1.wav")
		end
	end
	for _,v in pairs(_AdvancedMPConfig.Upgrades) do
		if (text == "/"..v.cmd) then
			if !ply:canAfford(v.price) then return end
			v.onBuy(ply:GetEyeTrace().Entity)
			ply:addMoney(-v.price)
			DarkRP.notify( ply, 2, 4, "Вы заплатили: $"..v.price )
			ply:GetEyeTrace().Entity:EmitSound("ambient/levels/labs/coinslot1.wav")
		end
	end
end)