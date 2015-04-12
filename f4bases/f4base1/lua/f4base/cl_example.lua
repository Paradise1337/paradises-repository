if !F4 then return end
local example = {}
example.name = "Example name"
example.col = Color(255,36,0)
example.callBack = function(self) -- функция при нажимание на кнопку
	local x, y, ply = ScrW(), ScrH(), LocalPlayer() -- Объявление переменных
	local base = F4.BaseElement(self, example.name, example.col) -- Базовая основа окна
	/* --- BASE END --- */

	base["example"] = vgui.Create("DButton", base)
	base["example"]:SetText("Test")
	base["example"]:SetSize(150,25)
	base["example"]:SetPos(25,25)
	base["example"].DoClick = function()
		self:Close()
	end
end

F4:RegisterButton(example) -- Регистрация