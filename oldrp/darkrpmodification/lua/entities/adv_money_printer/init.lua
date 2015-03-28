/*=== === === ===
Created by Paradise1337
Design by Paradise
===	===	===	===*/

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/consolebox01a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	
	local t = CurTime() + _AdvancedMPConfig.Levels[_AdvancedMPConfig.StandartClass].printtime
	local data = {
		class = _AdvancedMPConfig.StandartClass,
		health = _AdvancedMPConfig.Levels[_AdvancedMPConfig.StandartClass].maxHealth,
		nextPrint = t,
		armor = 100,
		color = nil,
		cash = 0,
		autoTake = false,
	}
	local _data = pon.encode(data)
	self:SetData(_data)

	self.sound = CreateSound(self, Sound("ambient/machines/electrical_hum_2.wav"))
	self.sound:SetSoundLevel(52)
	self.sound:PlayEx(1, 100)
end

function ENT:Use(activator,caller)
	netstream.Start(activator, "PrinterGUI", self)
end

function ENT:OnTakeDamage(dmg)
	if self:AR() > 0 and dmg:GetDamage() < self:AR() then 
		self:SetPoints("armor", (self:AR() or 100) - dmg:GetDamage())
		return
	elseif self:AR() > 0 and dmg:GetDamage() > self:AR() then 
		dmg:SetDamage(dmg:GetDamage() - self:AR())
		self:SetPoints("armor", 0)
	elseif self:AR() > 0 and dmg:GetDamage() == self:AR() then 
		self:SetPoints("armor", 0)
		return
	end
	self:SetPoints("health", (self:HP() or 100) - dmg:GetDamage())
	if self:HP() <= 0 then
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

function ENT:PrintMoney()
	local owner = self:Getowning_ent()
	local procent = !IsValid(owner) and 75 or owner:IsSuperAdmin() and 60 or owner:IsSuperVIP() and 40 or owner:IsVIP() and 25 or 0
	local cash = _AdvancedMPConfig.Levels[self:Class()].print + _AdvancedMPConfig.Levels[self:Class()].print / 100 * procent
	if self:HasAutoTake() and IsValid(owner) then
		owner:addMoney(cash)
	else
		self:SetCash(cash)
	end
end 

function ENT:Think()
	local owner = self:Getowning_ent()
	
	if self:NextPrint() <= CurTime() then
		self:PrintMoney()
		self:SetNextPrint(_AdvancedMPConfig.Levels[self:Class()].printtime)
	end

	if self:WaterLevel() > 0 then
		self:Destruct()
		self:Remove()
		return
	end
end

netstream.Hook("_mp_actions", function(ply, data)
	local ent = data[2]
	if data[1] == "takem" then
		ent:TakeMoney(ply)
	end
	
	if (data[1] == "upgrade") then
		ent:Upgrade(ply)
	end
	
	if (data[1] == "auto") then
		ent:SetAutoTake(data[3])
	end
	for _,v in pairs(_AdvancedMPConfig.Upgrades) do
		if (data[1] == v.cmd) then
			if !ply:canAfford(v.price) then return end
			v.onBuy(ent)
			ply:addMoney(-v.price)
			DarkRP.notify( ply, 2, 4, "Вы заплатили: $"..v.price )
			ent:EmitSound("ambient/levels/labs/coinslot1.wav")
		end
	end
end)

function ENT:OnRemove()
	if self.sound then
		self.sound:Stop()
	end
end

function ENT:Upgrade(ply)
	if !_AdvancedMPConfig.CanUpgrade(self) then return end
	if !ply:canAfford(_AdvancedMPConfig.Levels[_AdvancedMPConfig.NextClass(self)].price) then return end

	self:ClassSet(_AdvancedMPConfig.NextClass(self))
	self:SetNextPrint(_AdvancedMPConfig.Levels[self:Class()].printtime)
	self:EmitSound("ambient/levels/labs/coinslot1.wav")
	if ply and IsValid(ply) then
		ply:addMoney(-_AdvancedMPConfig.Levels[self:Class()].price)
		DarkRP.notify( ply, 2, 4, "Вы заплатили: $".._AdvancedMPConfig.Levels[self:Class()].price )
	end
end

function ENT:ClassSet(class)
	local _data = self:GetData()
	local data = pon.decode(_data)
	data["class"] = class
	_data = pon.encode(data)
	self:SetData(_data)
end

function ENT:TakeMoney(ply)
	local _data = self:GetData()
	local data = pon.decode(_data)
	local money = data["cash"]
	data["cash"] = class
	_data = pon.encode(data)
	self:SetData(_data)
	ply:addMoney(money)
	ply:EmitSound("ambient/levels/labs/coinslot1.wav")
end

function ENT:SetNextPrint(addTime)
	local _data = self:GetData()
	local data = pon.decode(_data)
	data["nextPrint"] = CurTime() + addTime
	_data = pon.encode(data)
	self:SetData(_data)
end

function ENT:SetCash(addCash)
	local _data = self:GetData()
	local data = pon.decode(_data)
	data["cash"] = self:Cash() + addCash
	_data = pon.encode(data)
	self:SetData(_data)
end

function ENT:SetPoints(point, num)
	local _data = self:GetData()
	local data = pon.decode(_data)
	data[point] = num
	_data = pon.encode(data)
	self:SetData(_data)
end

function ENT:ColorSet(color)
	local _data = self:GetData()
	local data = pon.decode(_data)
	data['color'] = color
	_data = pon.encode(data)
	self:SetData(_data)
end

function ENT:SetAutoTake(bool)
	local eowner = self:Getowning_ent()
	eowner = IsValid(eowner) and eowner or nil
	if eowner and (!eowner:IsSuperAdmin() or !eowner:IsVIP()) then return end
	local _data = self:GetData()
	local data = pon.decode(_data)
	data['autoTake'] = bool
	_data = pon.encode(data)
	self:SetData(_data)
end