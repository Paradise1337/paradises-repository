if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Кража денег"
	SWEP.Slot = 1
	SWEP.SlotPos = 9
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "OldRp"
SWEP.Instructions = "ЛКМ - украсть деньги"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "UP Shit"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end

if CLIENT then
	usermessage.Hook("moneythief_check", function(um)
		local wep = um:ReadEntity()
		local time = um:ReadLong()

		wep.IsMoneyThiefNow = true
		wep.StartCheck = CurTime()
		wep.MoneyThiefCheckTime = time
		wep.EndCheck = CurTime() + time

		wep.Dots = wep.Dots or ""
		timer.Create("MoneyThiefCheckDots", 0.5, 0, function()
			if not wep:IsValid() then timer.Destroy("MoneyThiefCheckDots") return end
			local len = string.len(wep.Dots)
			local dots = {[0]=".", [1]="..", [2]="...", [3]=""}
			wep.Dots = dots[len]
		end)
	end)
end

function SWEP:Deploy()
	return true
end

function SWEP:DrawWorldModel() end

function SWEP:PreDrawViewModel(vm)
	return true
end

function SWEP:PrimaryAttack()
	if CLIENT or self.IsMoneyThiefNow then return end
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)

	local trace = self.Owner:GetEyeTrace()

	if not IsValid(trace.Entity) or not trace.Entity:IsPlayer() or trace.Entity:GetPos():Distance(self.Owner:GetPos()) > 100 then
		return
	end

	if SERVER then
		self.IsMoneyThiefNow = true
		self.StartCheck = CurTime()
		self.MoneyThiefCheckTime = math.Rand(5, 10)
		umsg.Start("moneythief_check", self.Owner)
			umsg.Entity(self)
			umsg.Long(self.MoneyThiefCheckTime)
		umsg.End()
		self.EndCheck = CurTime() + self.MoneyThiefCheckTime
	end
end

function SWEP:Holster()
	self.IsMoneyThiefNow = false
	if SERVER then timer.Destroy("MoneyThiefCheckSounds") end
	if CLIENT then timer.Destroy("MoneyThiefCheckDots") end
	return true
end

function SWEP:Succeed()
	local time = CurTime() + 60
	if not IsValid(self.Owner) then return end
	self.IsMoneyThiefNow = false

	if CLIENT then return end
	local trace = self.Owner:GetEyeTrace()
	local victim = trace.Entity
	if not IsValid(victim) or not victim:IsPlayer() then return end
	local Money = math.random(0,200)
	if victim:getDarkRPVar("money") < Money then return end
	if CurTime() == time then
		self.Owner:addMoney(Money)
		victim:addMoney(-Money)
	end
	DarkRP.notify( self.Owner, 2, 4, "Вы украли: $"..Money )
end

function SWEP:Fail()
	self.IsMoneyThiefNow = false
	self:SetWeaponHoldType("normal")
	if SERVER then timer.Destroy("MoneyThiefCheckSounds") end
	if CLIENT then timer.Destroy("MoneyThiefCheckDots") end
end

function SWEP:Think()
	if self.IsMoneyThiefNow and self.EndCheck then
		local trace = self.Owner:GetEyeTrace()
		if not IsValid(trace.Entity) then
			self:Fail()
		end
		if trace.HitPos:Distance(self.Owner:GetShootPos()) > 100 or not trace.Entity:IsPlayer() then
			self:Fail()
		end
		if self.EndCheck <= CurTime() then
			self:Succeed()
		end
	end
end

function SWEP:DrawHUD()
	if self.IsMoneyThiefNow and self.EndCheck then
		self.Dots = self.Dots or ""
		local w = ScrW()
		local h = ScrH()
		local x,y,width,height = w/2-w/10, h/2, w/5, h/15
		draw.RoundedBox(8, x, y, width, height, Color(10,10,10,120))

		local time = self.EndCheck - self.StartCheck
		local curtime = CurTime() - self.StartCheck
		local status = math.Clamp(curtime/time, 0, 1)
		local BarWidth = status * (width - 16)
		local cornerRadius = math.Min(8, BarWidth/3*2 - BarWidth/3*2%2)
		draw.RoundedBox(cornerRadius, x+8, y+8, BarWidth, height-16, Color(0, 0+(status*255), 255-(status*255), 255))

		draw.DrawNonParsedSimpleText("Воруем"..self.Dots, "Trebuchet24", w/2, y + height/2, Color(255,255,255,255), 1, 1)
	end
end
