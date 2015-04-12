/*---------------------------------------------------------------------------
Основной елемент
---------------------------------------------------------------------------*/
F4 = {}
F4.elements = { -- Таблица елементов
	{	-- Не трогать! Стандартная кнопка для закрытия меню
		name = "Выход",
		callBack = function(self)
			self:Close()
		end
	}
}

function F4:RegisterButton(data) -- Регистрация кнопок
	table.insert(F4.elements, 1, data)
end

include("cl_example.lua") -- Подключение вкладки

function F4.BaseElement(self, name, color) -- Базовый елемент в виде окна
	local x, y, ply = ScrW(), ScrH(), LocalPlayer()
	if IsValid(self["run"]) then self["run"]:Remove() end
	self["run"] = vgui.Create("DFrame", self)
	if !color then color = Color(0,0,0) end
	local s = self["run"]
	s:SetSize(900, 500)
	s:SetPos(x/2-900/2, y/2-500/2)
	s.color = color
	s.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(35, 35, 35, 200));
		draw.RoundedBox(0, 0, 0, w, 25, color);
	end
	s:SetTitle(name)
	s:SetDraggable(false)
	s:ShowCloseButton(false)
	return s
end

/*---------------------------------------------------------------------------
Начало фрейма
---------------------------------------------------------------------------*/

local FRAME = {}
function FRAME:Init()  -- Главный фрейм
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
		draw.RoundedBox(0, 0, 0, w, h, Color(45, 45, 45, 255));
	end

	self.submenu = vgui.Create("DPanel", self.menu)
	self.submenu:SetSize(#F4.elements*155, 60)
	self.submenu:SetPos(x/2-(#F4.elements*155)/2,0)
	self.submenu.Paint = function(self,w,h)
	end

	for k,v in pairs(F4.elements) do
		self['mbtn'..k] = vgui.Create("DButton", self.submenu)
		self['mbtn'..k]:SetSize(150,50)
		self['mbtn'..k]:SetPos(155*(k-1),5)
		self['mbtn'..k]:SetText(v["name"])
		self['mbtn'..k].DoClick = function()
			 v["callBack"](self)
		end
	end
end


function FRAME:Paint(w, h)
	Derma_DrawBackgroundBlur(self, self.startTime)
end

vgui.Register('F4MenuFrame', FRAME, 'DFrame')