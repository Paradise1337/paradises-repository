/*=== === === ===
Created by Paradise1337
Design by Paradise
===	===	===	===*/

include("shared.lua")
function ENT:Initialize()
end

surface.CreateFont("SPECIAL_BIG_FONT", {
		font = "Arial", 
		size = 400, 
		weight = 1000, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

function ENT:Draw()
	self:DrawModel()
	self:SetColor(Color(0,0,0,255))

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	surface.SetFont("HUDNumber5")

	Ang:RotateAroundAxis(Ang:Up(), 90)
	local TextAng = Ang

	TextAng:RotateAroundAxis(TextAng:Right(), 0)
	cam.Start3D2D(Pos + Ang:Right() * -0 + Ang:Up()*2 + Ang:Forward()*0, TextAng, 0.05)

		if LocalPlayer():GetPos():Distance(Pos) < 500 then
			if Pos:Distance(LocalPlayer():GetPos()) > 300 then
				self.lrpa = Lerp( 2 * FrameTime(), self.lrpa or 0, 0)
				self.lrpa12 = Lerp( 2 * FrameTime(), self.lrpa12 or 0, 0)
			else
				self.lrpa = Lerp( 6 * FrameTime(), self.lrpa or 0, 255)
				self.lrpa12 = Lerp( 6 * FrameTime(), self.lrpa12 or 0, 255)
			end
			
			if (self:GetData() == 'steam') then
				draw.RoundedBox(24, -470, -470, 700, 700, Color(0, 0, 0, self.lrpa12));
				draw.RoundedBox(24, -470+25, -470+25, 700-50, 700-50, Color(255, 255, 255, self.lrpa));
				draw.RoundedBox(24, -470+50, -470+50, 700-100, 700-100, Color(0, 0, 0, self.lrpa12));
				draw.SimpleText('Наша группа в Steam (Нажми "E")', "HUDNumber5", -400, 150, Color(255, 255, 255, self.lrpa),0,1)
			end
			if (self:GetData() == 'vk') then
				draw.RoundedBox(24, -470, -470, 700, 700, Color(100, 155, 200, self.lrpa12));
				draw.RoundedBox(24, -470+25, -470+25, 700-50, 700-50, Color(255, 255, 255, self.lrpa));
				draw.RoundedBox(24, -470+50, -470+50, 700-100, 700-100, Color(100, 155, 200, self.lrpa12));
				draw.SimpleText('Наша группа в ВКонтакте (Нажми "E")', "HUDNumber5", -400, 150, Color(255, 255, 255, self.lrpa),0,1)
			end
			if (self:GetData() == 'owner') then
				draw.RoundedBox(24, -470, -470, 700, 700, Color(180, 100, 100, self.lrpa12));
				draw.RoundedBox(24, -470+25, -470+25, 700-50, 700-50, Color(255, 255, 255, self.lrpa));
				draw.RoundedBox(24, -470+50, -470+50, 700-100, 700-100, Color(180, 100, 100, self.lrpa12));
				draw.SimpleText('Создатель сервера в ВКонтакте (Нажми "E")', "HUDNumber5", -400, 150, Color(255, 255, 255, self.lrpa),0,1)
			end
			if (self:GetData() == 'par') then
				draw.RoundedBox(24, -470, -470, 700, 700, Color(50, 180, 80, self.lrpa12));
				draw.RoundedBox(24, -470+25, -470+25, 700-50, 700-50, Color(255, 255, 255, self.lrpa));
				draw.RoundedBox(24, -470+50, -470+50, 700-100, 700-100, Color(50, 180, 80, self.lrpa12));
				draw.SimpleText('Разработчик сервера (Нажми "E")', "HUDNumber5", -400, 150, Color(255, 255, 255, self.lrpa),0,1)
			end
			if (self:GetData() == 'don') then
				draw.RoundedBox(24, -470, -470, 700, 700, Color(220, 190, 100, self.lrpa12));
				draw.RoundedBox(24, -470+25, -470+25, 700-50, 700-50, Color(255, 255, 255, self.lrpa));
				draw.RoundedBox(24, -470+50, -470+50, 700-100, 700-100, Color(220, 190, 100, self.lrpa12));
				draw.SimpleText('Donate сервера (Нажми "E")', "HUDNumber5", -400, 150, Color(255, 255, 255, self.lrpa),0,1)
			end
		end
	cam.End3D2D()
	
	cam.Start3D2D(Pos + Ang:Right() * -0 + Ang:Up()*2 + Ang:Forward()*0, TextAng, 0.2)
		if LocalPlayer():GetPos():Distance(Pos) < 500 then
			if Pos:Distance(LocalPlayer():GetPos()) > 150 then
				self.lrpa1 = Lerp( 2 * FrameTime(), self.lrpa1 or 0, 0)
			else
				self.lrpa1 = Lerp( 2 * FrameTime(), self.lrpa1 or 0, 255)
			end
			if (self:GetData() == 'steam') then
				draw.SimpleText('S', "SPECIAL_BIG_FONT", -27, -27, Color(255, 255, 255, self.lrpa1),1,1)
			end
			if (self:GetData() == 'vk') then
				draw.SimpleText('B', "SPECIAL_BIG_FONT", -27, -27, Color(255, 255, 255, self.lrpa1),1,1)
			end
			if (self:GetData() == 'owner') then
				draw.SimpleText('C', "SPECIAL_BIG_FONT", -27, -27, Color(255, 255, 255, self.lrpa1),1,1)
			end
			if (self:GetData() == 'par') then
				draw.SimpleText('P', "SPECIAL_BIG_FONT", -27, -27, Color(255, 255, 255, self.lrpa1),1,1)
			end
			if (self:GetData() == 'don') then
				draw.SimpleText('D', "SPECIAL_BIG_FONT", -27, -27, Color(255, 255, 255, self.lrpa1),1,1)
			end
		end
	cam.End3D2D()
end