/*=== === === ===
Created by Paradise1337
Design by Paradise
===	===	===	===*/

include("shared.lua")

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

surface.CreateFont("advmp5", {
		font = "Arial", 
		size = 50, 
		weight = 1000, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local class = self:Class()
	local eowner = self:Getowning_ent()
	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")
	eowner = IsValid(eowner) and eowner or nil
	local col = Color(0,0,0,255)
	Ang:RotateAroundAxis(Ang:Up(), 90)
	if _AdvancedMPConfig.Levels[class].color != "" then
		col = _AdvancedMPConfig.Levels[class].color or Color(0,0,0,255)
		
		if self:Color() then
			col = self:Color()
		end
	else
		col = Color(150-math.sin(CurTime())*50,100+math.sin(CurTime())*50,200+math.sin(CurTime())*50)
	end
	
	local t1 = self:NextPrint()
	local t2 = t1 - CurTime()
	local ply = LocalPlayer()
	local t3 = _AdvancedMPConfig.Levels[class].printtime
	local t4 = CurTime() - t1 + t3
	local procent = !IsValid(eowner) and 75 or eowner:IsSuperAdmin() and 60 or eowner:IsSuperVIP() and 40 or eowner:IsVIP() and 25 or 0
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
			self['C1'] = Lerp( 1 * FrameTime(), self['C1'] or 0, col.r)
			self['C2'] = Lerp( 1 * FrameTime(), self['C2'] or 0, col.g)
			self['C3'] = Lerp( 1 * FrameTime(), self['C3'] or 0, col.b)
			col = Color(self['C1'], self['C2'], self['C3'], self['h3'])
			draw.RoundedBox(0, -280, -280, 560, 560, Color(0, 0, 0, self['h2']));
			draw.RoundedBox(0, -280, -280, 560, 100, Color(0, 0, 0, self['h1']));
			draw.RoundedBox(0, -280+2, -280+2, 560-4, 100-4, col);
			draw.RoundedBox(0, 280-150-5, 280-50-5, 150, 50, Color(0, 0, 0, self['h1']));
			draw.RoundedBox(0, 280-150-5+2, 280-50-5+2, 150-4, 50-4, col);
			
			draw.RoundedBox(0, -280+1, -130+1, 560-2, 20-2, Color(0, 0, 0, self['h1']));
			draw.RoundedBox(0, -280+3, -130+3, (560-6)/_AdvancedMPConfig.Levels[class].maxHealth*math.Clamp(self:HP(),0,_AdvancedMPConfig.Levels[class].maxHealth), 20-6, Color(170, 50, 50, self['h1']));
			
			draw.RoundedBox(0, -280+1, -130+1+25, 560-2, 20-2, Color(0, 0, 0, self['h1']));
			draw.RoundedBox(0, -280+3, -130+3+25, (560-6)/100*math.Clamp(self:AR(),0,100), 20-6, Color(75, 150, 200, self['h1']));
			
			draw.RoundedBox(0, -280+5, 280-20-5, 395, 20, Color(0, 0, 0, self['h1']));
			draw.SimpleTextOutlined(self:Cash().."$", "advmp5", 280-150-5+150/2, 280-50-5+50/2, Color(255, 255, 255, self['h3']),1,1, 1, Color(0,0,0,self['h1']) )

			draw.SimpleTextOutlined("Следующая печать: "..math.Round(t2).." sec", "advmp1", -280+5, 280-55, Color(255, 255, 255, self['h3']),0,0, 1, Color(0,0,0,self['h1']) )
			draw.RoundedBox(0, -280+5+2, 280-20-5+2, (395-4)/t3*t4, 20-4, col);

			draw.SimpleTextOutlined("Принтер", "advmp4", 0, -280+100/2, Color(255, 255, 255, self['h3']),1,1, 1, Color(0,0,0,self['h1']) )
			draw.SimpleTextOutlined("Класс: ".._AdvancedMPConfig.Levels[class].name, "advmp2", 0, -280+110, Color(255, 255, 255, self['h3']),1,0, 1, Color(0,0,0,self['h1']) )
			draw.SimpleTextOutlined("Владелец: "..owner, "advmp2", -280+5, -280+210, Color(255, 255, 255, self['h3']),0,0, 1, Color(0,0,0,self['h1']) )
			draw.SimpleTextOutlined("Печатает: ".._AdvancedMPConfig.Levels[class].print.."$", "advmp2", -280+5, -280+210+35, Color(255, 255, 255, self['h3']),0,0, 1, Color(0,0,0,self['h1']) )
			if _AdvancedMPConfig.CanUpgrade(self) then
				draw.SimpleTextOutlined("Цена апгрейда: "..tostring(_AdvancedMPConfig.UpPrice(self)).."$", "advmp2", -280+5, -280+210+35*3, Color(255, 255, 255,self['h1']),0,0, 1, Color(0,0,0,self['h1']) )
				draw.SimpleTextOutlined("Максимум: ".._AdvancedMPConfig.Levels[class].maxCash, "advmp2", -280+5, -280+210+35*4, col,0,0, 1, Color(0,0,0,self['h1']) )
				draw.SimpleTextOutlined("Нажмите Е", "advmp2", -280+5, -280+210+35*5, col,0,0, 1, Color(0,0,0,self['h1']) )
			else
				draw.SimpleTextOutlined("Максимум: ".._AdvancedMPConfig.Levels[class].maxCash, "advmp2", -280+5, -280+210+35*3, col,0,0, 1, Color(0,0,0,self['h1']) )
				draw.SimpleTextOutlined("Нажмите Е", "advmp2", -280+5, -280+210+35*4, col,0,0, 1, Color(0,0,0,self['h1']) )
			end
			draw.SimpleTextOutlined("Процент к прибыли: "..procent.."%", "advmp2", -280+5, -280+210+70, Color(255, 255, 255, self['h3']),0,0, 1, Color(0,0,0,self['h1']) )
			
		end
	cam.End3D2D()
	
end


function ENT:Think()
end

/*---*---*/

local x, y, ply = ScrW(), ScrH(), LocalPlayer()
Printer_DERMA = {}

do
	Printer_DERMA.Switcher = {}
	
	function Printer_DERMA.Switcher:Init()
		self:SetSize(100, 25);
		self:SetText('');
		self.Status = false;
		self.Disabled = false;
		self["lerp"] = 0
	end
	
	function Printer_DERMA.Switcher:GetStatus()
		return self.Status;
	end
	
	function Printer_DERMA.Switcher:SetStatus(bool)
		self.Status = bool;
	end
	
	function Printer_DERMA.Switcher:SetDisabled(bool)
		self.Disabled = bool;
	end
	
	function Printer_DERMA.Switcher:GetDisabled()
		return self.Disabled;
	end
	
	function Printer_DERMA.Switcher:Switch()
		self.Status = !self:GetStatus();
	end
	
	function Printer_DERMA.Switcher:DoClick()
		if !self:GetDisabled() then 
			self:Switch(); 
			self:OnClick()
			surface.PlaySound("buttons/lever7.wav")
		end
	end
	
	function Printer_DERMA.Switcher:OnClick()
	end
	
	function Printer_DERMA.Switcher:Paint(w,h)
		self["lerp1"] = Lerp( 5 * FrameTime(), self["lerp1"] or 0, 25)
		if self:GetStatus() then
			self["lerp"] = Lerp( 5 * FrameTime(), self["lerp"] or 0, 0)
			draw.RoundedBox(4, 0, 2.5, w, h-5, Color(0,0,0,200));
			if !self:GetDisabled() then
				draw.RoundedBox(4, 1, 1+2.5, w-2, h-5-2, Color(45,170,70,255));
			else
				draw.RoundedBox(4, 1, 1+2.5, w-2, h-5-2, Color(75,75,75,255));
			end
			draw.RoundedBox(4, self["lerp"], 0, self["lerp1"], self["lerp1"], Color(0,0,0,255));
			draw.RoundedBox(4, self["lerp"]+1, 1, self["lerp1"]-2, self["lerp1"]-2, Color(75,75,75,255));
		else
			self["lerp"] = Lerp( 5 * FrameTime(), self["lerp"] or 0, w)
			draw.RoundedBox(4, 0, 2.5, w, h-5, Color(0,0,0,200));
			if !self:GetDisabled() then
				draw.RoundedBox(4, 1, 1+2.5, w-2, h-5-2, Color(180,60,60,255));
			else
				draw.RoundedBox(4, 1, 1+2.5, w-2, h-5-2, Color(75,75,75,255));
			end
			draw.RoundedBox(4, self["lerp"]-25, 0, self["lerp1"], self["lerp1"], Color(0,0,0,255));
			draw.RoundedBox(4, self["lerp"]-25+1, 1, self["lerp1"]-2, self["lerp1"]-2, Color(75,75,75,255));
		end
	end
	
	vgui.Register('PrinterSwitcher', Printer_DERMA.Switcher, 'DButton');
end

do
	surface.CreateFont("TTTRF1", {
			font = "Arial", 
			size = 14, 
			weight = 0, 
			blursize = 0, 
			scanlines = 0, 
			antialias = true, 
	});
	Printer_DERMA.Button = {}
	
	function Printer_DERMA.Button:Init()
		self:SetSize(150, 25);
		self:SetText('');
		self.Disabled = false;
		self.Slide = false;
		self.Clicked = false;
		self.Label = "";
	end
	
	function Printer_DERMA.Button:SetDisabled(bool)
		self.Disabled = bool;
	end
	
	function Printer_DERMA.Button:GetDisabled()
		return self.Disabled;
	end
	
	function Printer_DERMA.Button:DoClick()
		if !self:GetDisabled() then 
			self:OnClick();
			self.Clicked = true;
			timer.Simple(0.3, function() if IsValid(self) then self.Clicked = false end end)
			surface.PlaySound("buttons/lightswitch2.wav")
		end
	end
	
	function Printer_DERMA.Button:OnClick()
	end
	
	function Printer_DERMA.Button:SetLabel(text)
		self.Label = text
	end
	
	function Printer_DERMA.Button:OnCursorEntered()
		if self:GetDisabled() then return end
		surface.PlaySound("garrysmod/balloon_pop_cute.wav")
		self.Slide = true
	end
	
	function Printer_DERMA.Button:OnCursorExited()
		if self:GetDisabled() then return end
		self.Slide = false
	end
	
	function Printer_DERMA.Button:Paint(w,h)
		self["lerp1"] = Lerp( 3 * FrameTime(), self["lerp1"] or 0, w)
		self["lerp"] = Lerp( 5 * FrameTime(), self["lerp"] or 0, w)
		self["lerp4"] = Lerp( 2 * FrameTime(), self["lerp4"] or 0, 255)
		self["lerp5"] = Lerp( 2 * FrameTime(), self["lerp5"] or 0, 200)
		if self.Slide then
			self["lerp2"] = Lerp( 8 * FrameTime(), self["lerp2"] or 0, w)
			self["lerp3"] = Lerp( 8 * FrameTime(), self["lerp3"] or 0, 4)
		else
			self["lerp2"] = Lerp( 8 * FrameTime(), self["lerp2"] or 0, 0)
			self["lerp3"] = Lerp( 8 * FrameTime(), self["lerp3"] or 0, 0)
		end
		draw.RoundedBox(4, w/2-self["lerp"]/2, 0, self["lerp"], h, Color(0,0,0,200));
		draw.RoundedBox(4, w/2-self["lerp1"]/2+1, 1, self["lerp1"]-2, h-2, Color(60,170,185,200));
		draw.RoundedBox(math.Round(self["lerp3"]), w/2-self["lerp2"]/2+1, 1, self["lerp2"]-2, h-2, Color(60,185,60,200));
		if self.Clicked  then
			draw.RoundedBox(4, 1, 1, w-2, h-2, Color(180,60,60,255));
		end
		
		draw.SimpleTextOutlined( self.Label, "TTTRF1", w/2, h/2, Color(255,255,255,self["lerp4"]), 1, 1, 1, Color(0,0,0,self["lerp5"]) )
	end
	
	vgui.Register('PrinterButton', Printer_DERMA.Button, 'DButton');
end
surface.CreateFont("PrinterGUI", {
		font = "Arial", 
		size = 20, 
		weight = 1000, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

local function PrinterGui(ent)
	local ply = LocalPlayer()
	local main = vgui.Create("DFrame")
	main:SetSize(350,150)
	main:SetPos(x/2-352/2,y/2-150/2)
	main:MakePopup()
	main.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(75,75,75,255));
		draw.RoundedBox(4, 0, 0, w, 22, Color(35,35,35,200));
		draw.SimpleTextOutlined( 'Включить авто-сбор?', "PrinterGUI", 5, 25+(25+5)/2, Color(255,255,255,255), 0, 1, 1, Color(0,0,0,255) )
		draw.SimpleTextOutlined( 'Только для VIP!', "TTTRF1", 5, 25+5+(25)*2, Color(255,255,255,50), 0, 2, 1, Color(0,0,0,50) )
	end
	local Upgrade = vgui.Create("PrinterButton", main)
	Upgrade:SetLabel("Выполнить модернизацию")
	Upgrade:SetPos(5,185-30)
	Upgrade:SetSize(350-10,25)
	Upgrade.OnClick = function()
		netstream.Start("_mp_actions", {'upgrade', ent})
	end
	main.Think = function()
		if _AdvancedMPConfig.CanUpgrade(ent) then 
			main:SetSize(350,185)
		else
			main:SetSize(350,150)
		end
	end
	main:SetTitle("Money Printer")
	
	local HealthBTN = vgui.Create("PrinterButton", main)
	HealthBTN:SetLabel("Востоновить здоровье")
	HealthBTN:SetPos(350-150-5,25)
	HealthBTN.OnClick = function()
		netstream.Start("_mp_actions", {'mhp', ent})
	end
	
	local ArBTN = vgui.Create("PrinterButton", main)
	ArBTN:SetLabel("Востоновить броню")
	ArBTN:SetPos(350-150-5,25+25+5)
	ArBTN.OnClick = function()
		netstream.Start("_mp_actions", {'mar', ent})
	end
	
	local ClBTN = vgui.Create("PrinterButton", main)
	ClBTN:SetLabel("Изменить цвет")
	ClBTN:SetPos(350-150-5,25+(25+5)*2)
	ClBTN.OnClick = function()
		netstream.Start("_mp_actions", {'mrc', ent})
	end
	
	local AutoTake = vgui.Create("PrinterSwitcher", main)
	AutoTake:SetPos(5,25+(25+5))
	AutoTake:SetSize(175,25)
	if !ply:IsSuperAdmin() or !ply:IsVIP() then
		AutoTake:SetDisabled(true)
	end
	AutoTake:SetStatus(ent:HasAutoTake())
	AutoTake.OnClick = function()
		netstream.Start("_mp_actions", {'auto', ent, AutoTake:GetStatus()})
	end
	
	local Cash = vgui.Create("PrinterButton", main)
	Cash:SetLabel("Собрать прибыль")
	Cash:SetPos(5,150-30)
	Cash:SetSize(350-10,25)
	Cash.OnClick = function()
		netstream.Start("_mp_actions", {'takem', ent})
	end
end
netstream.Hook("PrinterGUI", function(data)
	PrinterGui(data)
end)

