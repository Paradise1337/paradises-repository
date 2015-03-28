local FRAME = {}

F4 = {}
F4.elements = {
	{
		name = "Выход",
		callBack = function(self)
			self:Close()
		end
	}
}
function F4:RegisterButton(data)
	table.insert(F4.elements, 1, data)
end

function FRAME:Init()
	local x, y, ply = ScrW(), ScrH(), LocalPlayer()

	self:SetSize(x, y)
	self:SetPos(0, 0)
	self:MakePopup()
	self.startTime = SysTime()
	self:SetTitle("")
	self:SetDraggable(false)
	self:ShowCloseButton(false)

	self.menu = vgui.Create("DPanel", self)
	self.menu:SetSize(x, 60)
	self.menu:SetPos(0,y-60)
	self.menu.Paint = function(self,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200));
		draw.RoundedBox(0, 0, 4, w, h-8, Color(0, 0, 0, 50));
	end

	self.submenu = vgui.Create("DPanel", self.menu)
	self.submenu:SetSize(#F4.elements*155, 60)
	self.submenu:SetPos(x/2-(#F4.elements*155)/2,0)
	self.submenu.Paint = function(self,w,h)
	end

	for k,v in pairs(F4.elements) do
		self['mbtn'..k] = vgui.Create("F4MenuButton", self.submenu)
		self['mbtn'..k]:SetPos(155*(k-1),5)
		self['mbtn'..k]:SetLabel(v["name"])
		self['mbtn'..k].OnClick = function()
			 v["callBack"](self)
		end
	end
end


function FRAME:Paint(w, h)
	Derma_DrawBackgroundBlur(self, self.startTime)
end

vgui.Register('F4MenuFrame', FRAME, 'DFrame')