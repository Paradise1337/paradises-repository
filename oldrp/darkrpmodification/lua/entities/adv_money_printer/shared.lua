/*=== === === ===
Created by Paradise1337
Design by Paradise
===	===	===	===*/


ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Vending machine"
ENT.Author = "Paradise"
ENT.Spawnable = true
ENT.Category = "DarkRP"
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "price")
	self:NetworkVar("Entity", 0, "owning_ent")
end

_AdvancedMPConfig = {}
_AdvancedMPConfig.StandartClass = "Standart"
_AdvancedMPConfig.Levels = {
	Standart = { -- Standart
		name = "Стандартный",
		color = Color(60,170,80),
		print = 500,
		printtime = 240, -- sec
		maxHealth = 150,
		maxCash = 5000,
	},
	
	Gold = { -- Gold
		name = "Золотой",
		color = Color(255,187,0),
		print = 750,
		printtime = 180, -- sec
		maxHealth = 300,
		maxCash = 7500,
		price = 5000,
	},
	
	Dimond = { -- Dimond
		name = "Алмазный",
		color = Color(60,150,200),
		print = 1000,
		printtime = 120, -- sec
		maxHealth = 400,
		maxCash = 10000,
		price = 10000,
	},
	
	Premium = { -- Premium
		name = "Премиум",
		color = Color(100,30,180),
		print = 1500,
		printtime = 60, -- sec
		maxHealth = 500,
		maxCash = 15000,
		price = 15000,
		check = function(ply)
			return ply:IsSuperAdmin() or ply:IsUserGroup("vip")
		end
	},
}
_AdvancedMPConfig.Upgrades = {
	HP = { -- Very hight HP
		name = "Health",
		desc = "Repaire health of printer",
		cmd = "mhp",
		price = 500,
		onBuy = function(self)
			self:SetNWInt("dmg", math.Round(self:GetNWInt("dmg")+500, 0, _AdvancedMPConfig.Levels[self:GetNWString("class")].maxHealth))
		end
	},
	AR = { -- Set full ar
		name = "Armor",
		desc = "Repaire armor of printer",
		price = 200,
		cmd = "mar",
		onBuy = function(self)
			self:SetNWInt("arm", 100)
		end
	},
	RandColor = { -- Set random color
		name = "Random Color",
		desc = "Set random draw table color",
		price = 250,
		cmd = "mrc",
		onBuy = function(self)
			local r1 = math.Rand(25, 255)
			local r2 = math.Rand(25, 255)
			local r3 = math.Rand(25, 255)
			self:SetNWInt("_Color_r", r1)
			self:SetNWInt("_Color_g", r2)
			self:SetNWInt("_Color_b", r3)
		end
	}
}

local classes = {
	"Standart",
	"Gold",
	"Dimond",
	"Premium"
}

function _AdvancedMPConfig.UpPrice(self)
	if !_AdvancedMPConfig.CanUpgrade(self) then return end
	local class = _AdvancedMPConfig.NextClass(self)
	local price = _AdvancedMPConfig.Levels[class].price
	return price
end

function _AdvancedMPConfig.CanUpgrade(self)
	local id = 0
	local respond = false
	for k,v in pairs(_AdvancedMPConfig.Levels) do
		if _AdvancedMPConfig.Levels[self:GetNWString("class")].name == v.name then
			id = k
		end
	end
	local pid
	for k,v in pairs(classes) do
		if pid and pid != #classes+1 and pid == k then
			respond = true
		end
		if v == id then
			pid = k+1
		end
	end
	local class = _AdvancedMPConfig.NextClass(self)
	if respond and IsValid(self:Getowning_ent()) and _AdvancedMPConfig.Levels[class].check then
		respond = _AdvancedMPConfig.Levels[class].check(self:Getowning_ent())
	end
	return respond
end

function _AdvancedMPConfig.NextClass(self)
	--if !_AdvancedMPConfig.CanUpgrade(self) then return 0 end
	local id = 0
	local cl = 0
	for k,v in pairs(_AdvancedMPConfig.Levels) do
		if _AdvancedMPConfig.Levels[self:GetNWString("class")].name == v.name then
			id = k
		end
	end
	local pid
	for k,v in pairs(classes) do
		if pid and pid+1 != #classes+1 and pid+1 == k then
			cl = v
		end
		if v == id then
			pid = k
		end
	end
	
	return cl
end