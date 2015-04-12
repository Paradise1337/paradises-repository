include("cl_frame.lua") -- Подключение главного файла

/*---------------------------------------------------------------------------
Функция открытия
---------------------------------------------------------------------------*/
local f4Frame

local function toggleF4Menu()
	if not ValidPanel(f4Frame) then
		f4Frame = vgui.Create("F4MenuFrame")
	else
		f4Frame:Close()
		f4Frame = vgui.Create("F4MenuFrame")
	end
end

GAMEMODE.ShowSpare2 = toggleF4Menu

concommand.Add("AttemptMenu", function() -- Команда аварийного закрытия меню в случае ошибки
	if IsValid(f4Frame) then f4Frame:Remove() end
end)