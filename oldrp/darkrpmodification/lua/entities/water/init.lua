AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_junk/PopCan01a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
end


ENT.Once = false
function ENT:Use(activator,caller)
	if (activator:IsSuperAdmin()) then activator:setSelfDarkRPVar("Energy", 100) end
	activator:setSelfDarkRPVar("Energy", math.Clamp(activator:getDarkRPVar("Energy")+2, 0, 100))
	self:Remove()
end

function ENT:OnRemove()
	self:EmitSound("physics/flesh/flesh_bloody_impact_hard1.wav")
end
