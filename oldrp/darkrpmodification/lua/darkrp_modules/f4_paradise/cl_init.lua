local f4Frame

function DarkRP.toggleF4Menu()
	if not ValidPanel(f4Frame) then
		f4Frame = vgui.Create("F4MenuFrame")
	else
		f4Frame:Close()
		f4Frame = vgui.Create("F4MenuFrame")
	end
end

GM.ShowSpare2 = DarkRP.toggleF4Menu

do
	local F4Button = {}
	surface.CreateFont("F4BTN", {
			font = "Tahoma", 
			size = 18, 
			weight = 1000, 
			blursize = 0, 
			scanlines = 0, 
			antialias = true, 
	});
	
	function F4Button:Init()
		self:SetSize(150, 50);
		self:SetText('');
		self.Disabled = false;
		self.Slide = false;
		self.Clicked = false;
		self.Label = "";
	end
	
	function F4Button:SetDisabled(bool)
		self.Disabled = bool;
	end
	
	function F4Button:setColor(color)
		self.color = color;
	end

	function F4Button:GetDisabled()
		return self.Disabled;
	end
	
	function F4Button:DoClick()
		if !self:GetDisabled() then 
			self:OnClick();
			self.Clicked = true;
			timer.Simple(0.3, function() if IsValid(self) then self.Clicked = false end end)
			surface.PlaySound("buttons/lightswitch2.wav")
		end
	end
	
	function F4Button:OnClick()
	end
	
	function F4Button:SetLabel(text)
		self.Label = text
	end
	
	function F4Button:OnCursorEntered()
		if self:GetDisabled() then return end
		surface.PlaySound("garrysmod/ui_return.wav")
		self.Slide = true
	end
	
	function F4Button:OnCursorExited()
		if self:GetDisabled() then return end
		self.Slide = false
	end
	
	function F4Button:Paint(w,h)
		self["lerp1"] = Lerp( 3 * FrameTime(), self["lerp1"] or 0, w)
		self["lerp"] = Lerp( 5 * FrameTime(), self["lerp"] or 0, w)
		self["lerp4"] = Lerp( 2 * FrameTime(), self["lerp4"] or 0, 255)
		self["lerp5"] = Lerp( 2 * FrameTime(), self["lerp5"] or 0, 200)
		if self.Slide then
			self["lerp2"] = Lerp( 8 * FrameTime(), self["lerp2"] or 0, w)
		else
			self["lerp2"] = Lerp( 8 * FrameTime(), self["lerp2"] or 0, 0)
		end
		draw.RoundedBox(0, w/2-self["lerp"]/2, 0, self["lerp"], h, Color(0,0,0,200));
		draw.RoundedBox(0, w/2-self["lerp1"]/2+1, 1, self["lerp1"]-2, h-2, Color(145,145,145,255));
		draw.RoundedBox(0, w/2-self["lerp2"]/2+1, 1, self["lerp2"]-2, h-2, self.color or Color(50,140,200,255));
		if self.Clicked  then
			draw.RoundedBox(0, 0, 0, w, h, Color(180,60,60,255));
		end
		
		draw.SimpleTextOutlined( self.Label, "F4BTN", w/2, h/2, Color(255,255,255,self["lerp4"]), 1, 1, 1, Color(0,0,0,self["lerp5"]) )
	end
	
	vgui.Register('F4MenuButton', F4Button, 'DButton');
end