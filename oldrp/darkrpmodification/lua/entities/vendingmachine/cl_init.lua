/*=== === === ===
Created by Paradise1337
Design by Paradise
===	===	===	===*/

include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	surface.SetFont("HUDNumber5")
	local text = 'Вода'
	local text2 = "10 $"
	local text3 = self:Getbom() and "Сломан" or "Работает"
	local TextWidth = surface.GetTextSize(text)
	local TextWidth2 = surface.GetTextSize(text2)
	local TextWidth3 = surface.GetTextSize(text3)

	Ang:RotateAroundAxis(Ang:Forward(), 90)
	local TextAng = Ang

	TextAng:RotateAroundAxis(TextAng:Right(), 0)
	local MaxWidth = TextWidth
	if MaxWidth < TextWidth2 then MaxWidth = TextWidth2 end 
	if MaxWidth < TextWidth3 then MaxWidth = TextWidth3 end 
	cam.Start3D2D(Pos + Ang:Right() * -60 + Ang:Up()*19 + Ang:Forward()*20, TextAng, 0.05)
		if LocalPlayer():GetPos():Distance(Pos) < 500 then
			if Pos:Distance(LocalPlayer():GetPos()) > 150 then
				self.lrp = Lerp( 3 * FrameTime(), self.lrp or 0, 0)
				self.lrp1 = Lerp( 5 * FrameTime(), self.lrp1 or 0, 0)

				draw.RoundedBox(0, -(self.lrp)/2, -40, self.lrp, 120, Color(0, 0, 0, 200));
				draw.RoundedBox(0, -(self.lrp)/2+1, -40+1, self.lrp, 80-2, Color(50, 140, 70, 255));
				draw.RoundedBox(0, -(self.lrp)/2+1, 40+1, self.lrp, 40-2, Color(65, 135, 185, 255));
				
				draw.SimpleText(text, "HUDNumber5", 0, -30, Color(255, 255, 255, self.lrp1),1)
				draw.SimpleText(text2, "HUDNumber5", 0, -2, Color(255, 255, 255, self.lrp1),1)
				if self:Getbom() then
					draw.SimpleText(text3, "HUDNumber5", 0, -2+48, Color(255, 255, 255, self.lrp1),1)
				else
					draw.SimpleText(text3, "HUDNumber5", 0, -2+48, Color(255, 255, 255, self.lrp1),1)
				end
			else
				self.lrp = Lerp( 3 * FrameTime(), self.lrp or 0, MaxWidth+20 or 0)
				self.lrp1 = Lerp( 1 * FrameTime(), self.lrp1 or 0, 255)

				draw.RoundedBox(0, -(self.lrp)/2, -40, self.lrp, 120, Color(0, 0, 0, 200));
				draw.RoundedBox(0, -(self.lrp)/2+1, -40+1, self.lrp-2, 80-2, Color(50, 140, 70, 255));
				draw.RoundedBox(0, -(self.lrp)/2+1, 40+1, self.lrp-2, 40-2, Color(65, 135, 185, 255));

				draw.SimpleText(text, "HUDNumber5", 0, -30, Color(255, 255, 255, self.lrp1),1)
				draw.SimpleText(text2, "HUDNumber5", 0, -2, Color(255, 255, 255, self.lrp1),1)
				if self:Getbom() then
					draw.SimpleText(text3, "HUDNumber5", 0, -2+48, Color(255, 255, 255, self.lrp1),1)
				else
					draw.SimpleText(text3, "HUDNumber5", 0, -2+48, Color(255, 255, 255, self.lrp1),1)
				end
			end
		end
	cam.End3D2D()
end