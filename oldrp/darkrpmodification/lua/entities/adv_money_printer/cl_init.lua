/*=== === === ===
Created by Paradise1337
Design by Paradise
===	===	===	===*/

include("shared.lua")

function ENT:Initialize()
	self:SetNWString("class", _AdvancedMPConfig.StandartClass)
end

surface.CreateFont("advmp1", {
		font = "Arial", 
		size = 30, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

surface.CreateFont("advmp2", {
		font = "Arial", 
		size = 35, 
		weight = 1000, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

surface.CreateFont("advmp3", {
		font = "Arial", 
		size = 20, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

surface.CreateFont("advmp4", {
		font = "Arial", 
		size = 80, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	local eowner = self:Getowning_ent()
	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")
	eowner = IsValid(eowner) and eowner or nil

	Ang:RotateAroundAxis(Ang:Up(), 90)
	local col = _AdvancedMPConfig.Levels[self:GetNWString("class")].color or Color(0,0,0,255)
	
	if self:GetNWInt("_Color_r") != 0 and self:GetNWInt("_Color_g") != 0 and self:GetNWInt("_Color_b") != 0 then
		col = Color(self:GetNWInt("_Color_r"), self:GetNWInt("_Color_g"), self:GetNWInt("_Color_b"))
	end
	
	local t1 = self:GetNWInt("nextPrint")
	local t2 = t1 - CurTime()
	local t3 = _AdvancedMPConfig.Levels[self:GetNWString("class")].printtime
	local t4 = CurTime() - t1 + t3
	local procent = eowner == nil and 10 or eowner:IsSuperAdmin() and 10 or eowner:IsUserGroup("vip") and 10 
	cam.Start3D2D(Pos + Ang:Up() * 11.5, Ang, 0.05)
		if Pos:Distance(LocalPlayer():GetPos()) < 400 then
			if Pos:Distance(LocalPlayer():GetPos()) < 250 then
				self['h1'] = Lerp( 2 * FrameTime(), self['h1'] or 0, 200)
				self['h2'] = Lerp( 2 * FrameTime(), self['h2'] or 0, 150)
				self['h3'] = Lerp( 2 * FrameTime(), self['h3'] or 0, 255)
			else
				self['h1'] = Lerp( 2 * FrameTime(), self['h1'] or 0, 0)
				self['h2'] = Lerp( 2 * FrameTime(), self['h2'] or 0, 0)
				self['h3'] = Lerp( 2 * FrameTime(), self['h3'] or 0, 0)
			end
			col = Color(col.r, col.g, col.b, self['h3'])
			draw.RoundedBox(0, -280, -280, 560, 560, Color(0, 0, 0, self['h2']));
			draw.RoundedBox(0, -280, -280, 560, 100, Color(0, 0, 0, self['h1']));
			draw.RoundedBox(0, -280+2, -280+2, 560-4, 100-4, col);
			draw.RoundedBox(0, 280-150-5, 280-50-5, 150, 50, Color(0, 0, 0, self['h1']));
			draw.RoundedBox(0, 280-150-5+2, 280-50-5+2, 150-4, 50-4, col);
			
			draw.RoundedBox(0, -280+1, -130+1, 560-2, 20-2, Color(0, 0, 0, self['h1']));
			draw.RoundedBox(0, -280+3, -130+3, (560-6)/_AdvancedMPConfig.Levels[self:GetNWString("class")].maxHealth*math.Clamp(self:GetNWInt("dmg"),0,_AdvancedMPConfig.Levels[self:GetNWString("class")].maxHealth), 20-6, Color(170, 50, 50, self['h1']));
			
			draw.RoundedBox(0, -280+1, -130+1+25, 560-2, 20-2, Color(0, 0, 0, self['h1']));
			draw.RoundedBox(0, -280+3, -130+3+25, (560-6)/100*math.Clamp(self:GetNWInt("arm"),0,100), 20-6, Color(75, 150, 200, self['h1']));
			
			draw.RoundedBox(0, -280+5, 280-20-5, 395, 20, Color(0, 0, 0, self['h1']));
			draw.RoundedBox(0, -280+5+2, 280-20-5+2, (395-4)/t3*t4, 20-4, col);
			draw.SimpleTextOutlined(self:GetNWInt("cash").."$", "advmp2", 280-150-5+150/2, 280-50-5+50/3, Color(255, 255, 255, self['h3']),1,1, 1, Color(0,0,0,self['h1']) )
			draw.SimpleTextOutlined("Следующая печать: "..math.Round(t2).." sec", "advmp1", -280+5, 280-55, Color(255, 255, 255, self['h3']),0,0, 1, Color(0,0,0,self['h1']) )
			draw.SimpleTextOutlined("Max: ".._AdvancedMPConfig.Levels[self:GetNWString("class")].maxCash, "advmp3", 280-150-5+150/2, 280-50-5+40, Color(255, 255, 255, self['h3']),1,1, 1, Color(0,0,0,self['h1']) )
			draw.SimpleTextOutlined("Принтер", "advmp4", 0, -280+100/2, Color(255, 255, 255, self['h3']),1,1, 1, Color(0,0,0,self['h1']) )
			draw.SimpleTextOutlined("Класс: ".._AdvancedMPConfig.Levels[self:GetNWString("class")].name, "advmp2", 0, -280+110, Color(255, 255, 255, self['h3']),1,0, 1, Color(0,0,0,self['h1']) )
			draw.SimpleTextOutlined("Владелец: "..owner, "advmp2", -280+5, -280+210, Color(255, 255, 255, self['h3']),0,0, 1, Color(0,0,0,self['h1']) )
			draw.SimpleTextOutlined("Печатает: ".._AdvancedMPConfig.Levels[self:GetNWString("class")].print.."$", "advmp2", -280+5, -280+210+35, Color(255, 255, 255, self['h3']),0,0, 1, Color(0,0,0,self['h1']) )
			if _AdvancedMPConfig.CanUpgrade(self) then
				draw.SimpleTextOutlined("Цена апгрейда: "..tostring(_AdvancedMPConfig.UpPrice(self)).."$", "advmp2", -280+5, -280+210+35*3, Color(255, 255, 255),0,0, 1, Color(0,0,0,self['h1']) )
				draw.SimpleTextOutlined("/upgrade - Усовершенствовать", "advmp2", -280+5, -280+210+35*4, col,0,0, 1, Color(0,0,0,self['h1']) )
				draw.SimpleTextOutlined("/mhp - Пополнить Здоровье", "advmp2", -280+5, -280+210+35*5, col,0,0, 1, Color(0,0,0,self['h1']) )
				draw.SimpleTextOutlined("/mar - Пополнить Броню", "advmp2", -280+5, -280+210+35*6, col,0,0, 1, Color(0,0,0,self['h1']) )
				draw.SimpleTextOutlined("/mrc - Поменять основной цвет", "advmp2", -280+5, -280+210+35*7, col,0,0, 1, Color(0,0,0,self['h1']) )
			else
				draw.SimpleTextOutlined("/mhp - Пополнить Здоровье", "advmp2", -280+5, -280+210+35*3, col,0,0, 1, Color(0,0,0,self['h1']) )
				draw.SimpleTextOutlined("/mar - Пополнить Броню", "advmp2", -280+5, -280+210+35*4, col,0,0, 1, Color(0,0,0,self['h1']) )
				draw.SimpleTextOutlined("/mrc - Поменять основной цвет", "advmp2", -280+5, -280+210+35*5, col,0,0, 1, Color(0,0,0,self['h1']) )
			end
			draw.SimpleTextOutlined("Процент к прибыли: "..procent.."%", "advmp2", -280+5, -280+210+70, Color(255, 255, 255, self['h3']),0,0, 1, Color(0,0,0,self['h1']) )
		end
	cam.End3D2D()
end

function ENT:Think()
end
