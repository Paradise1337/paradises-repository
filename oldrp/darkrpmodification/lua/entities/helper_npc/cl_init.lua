include('shared.lua')

surface.CreateFont("npchelper", {
		font = "Arial", 
		size = 80, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

surface.CreateFont("npchelper1", {
		font = "Arial", 
		size = 140, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

surface.CreateFont("npchelper2", {
		font = "Arial", 
		size = 45, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

surface.CreateFont("npchelper3", {
		font = "Arial", 
		size = 15, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

surface.CreateFont("npchelper4", {
		font = "Arial", 
		size = 22, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

hook.Add("PostDrawOpaqueRenderables", "NPCHelper", function()
	for _, ent in pairs (ents.FindByClass("helper_npc")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 750 then
			local Ang = ent:GetAngles()

			Ang:RotateAroundAxis( Ang:Forward(), 90)
			Ang:RotateAroundAxis( Ang:Right(), -90)
		
			cam.Start3D2D(ent:GetPos()+ent:GetUp()*80, Ang, 0.05)
				draw.SimpleTextOutlined( 'Помощь', "npchelper1", -3, 0, Color( 95, 165, 80, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 200))
				draw.SimpleTextOutlined( 'игрокам', "npchelper", -3, 60, Color( 95, 165, 80, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 200))	
			cam.End3D2D()
		end
	end
end)

local function helpMenu()
	local ply, x, y = LocalPlayer(), ScrW(), ScrH()
	local btns = {
		{'Правила', '_npc_helps_laws', Color(200, 25, 25, 255)},
		{'Донат', '_npc_helps_donat', Color(75, 0, 150, 255)},
		--{'Steam Группа', '_npc_helps_goto-steam', Color(75, 200, 75, 255)},
		{'ВКонтакте', '_npc_helps_goto-vk', Color(0, 60, 255, 255)},
	}
	local main = vgui.Create('DFrame')
	main:SetSize(x, 500)
	main:SetPos(0, y / 2 - 250)
	main:MakePopup()
	main.startTime = SysTime()
	main:SetTitle('')
	main:ShowCloseButton(false)
	main:SetDraggable(false)
	main.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255));
		draw.RoundedBox(0, 0, 0, w, 75, Color(35, 35, 35, 255));
		draw.RoundedBox(0, w/2-400+1, 0, 800-2, 75-1, Color(0, 125, 255, 255));
		draw.SimpleTextOutlined( 'Выберите действие:', "npchelper2", w/2, 75/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 200))	
	end
	main['close'] = vgui.Create('DButton', main)
	main['close']:SetSize(30,15)
	main['close']:SetPos(x-80,0)
	main['close']:SetText("")
	main['close'].Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255));
		draw.SimpleTextOutlined( 'X', "npchelper3", w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 255))	
	end
	main['close'].DoClick = function()
		main:Close()
	end
	
	main['fake'] = vgui.Create('DButton', main)
	main['fake']:SetSize(30,15)
	main['fake']:SetPos(x-80-35,0)
	main['fake']:SetText("")
	main['fake']:SetDisabled(true)
	main['fake'].Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(225, 225, 225, 255));
		draw.SimpleTextOutlined( '_', "npchelper3", w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 255))	
	end
	
	for k, v in pairs(btns) do
		local name = 'btn'
		main[name..k] = vgui.Create('DButton', main)
		main[name..k]:SetSize(300,150)
		if (k > 4 and #btns > 4) then
			main[name..k]:SetPos(x/2-(#btns-4 == 1 and 150 or #btns-4 == 2 and -315 + 305*(k-4) or #btns-4 == 3 and -470 + 305*(k-4) or #btns-4 == 4 and -620 + 305*(k-4)),125+150+5)
		elseif (k < 5 and #btns > 4) then
			main[name..k]:SetPos(x/2-(-620 + 305*k),125)
		elseif (#btns < 5) then
			main[name..k]:SetPos(x/2-(#btns == 1 and 150 or #btns == 2 and -315 + 305*k or #btns == 3 and -470 + 305*k or #btns == 4 and -620 + 305*k),125)
		end
		main[name..k]:SetText('')
		main[name..k].Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200));
			draw.RoundedBox(0, 2, 2, w-4, h-4, v[3]);
			draw.RoundedBox(0, 2, 2, w-4, h-4, Color(255, 255, 255, 10));
			draw.SimpleTextOutlined( v[1], "npchelper2", w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 200))	
		end
		main[name..k].DoClick = function()
			ply:ConCommand(v[2])
			main:Close()
		end
	end
end
concommand.Add("heeelps", helpMenu)

local function vk()
	local ply, x, y = LocalPlayer(), ScrW(), ScrH()
	local main = vgui.Create('DFrame')
	main:SetSize(x, 500)
	main:SetPos(0, y / 2 - 250)
	main:MakePopup()
	main.startTime = SysTime()
	main:SetTitle('')
	main:ShowCloseButton(false)
	main:SetDraggable(false)
	main.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255));
		draw.RoundedBox(0, 0, 0, w, 75, Color(35, 35, 35, 255));
		draw.RoundedBox(0, w/2-400+1, 0, 800-2, 75-1, Color(0, 125, 255, 255));
		draw.SimpleTextOutlined( 'Группа ВКонтакте', "npchelper2", w/2, 75/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 200))	
	end
	main['close'] = vgui.Create('DButton', main)
	main['close']:SetSize(30,15)
	main['close']:SetPos(x-80,0)
	main['close']:SetText("")
	main['close'].Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255));
		draw.SimpleTextOutlined( 'X', "npchelper3", w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 255))	
	end
	main['close'].DoClick = function()
		main:Close()
	end
	
	main['fake'] = vgui.Create('DButton', main)
	main['fake']:SetSize(30,15)
	main['fake']:SetPos(x-80-35,0)
	main['fake']:SetText("")
	main['fake']:SetDisabled(true)
	main['fake'].Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(225, 225, 225, 255));
		draw.SimpleTextOutlined( '_', "npchelper3", w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 255))	
	end
	url = vgui.Create('HTML', main)
	url:SetSize(1000, 400)
	url:SetPos(x/2-500, 90)
	url:OpenURL('http://vk.com/expansiveworld')
end
concommand.Add("_npc_helps_goto-vk", vk)

local function st()
	local ply, x, y = LocalPlayer(), ScrW(), ScrH()
	local main = vgui.Create('DFrame')
	main:SetSize(x, 500)
	main:SetPos(0, y / 2 - 250)
	main:MakePopup()
	main.startTime = SysTime()
	main:SetTitle('')
	main:ShowCloseButton(false)
	main:SetDraggable(false)
	main.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255));
		draw.RoundedBox(0, 0, 0, w, 75, Color(35, 35, 35, 255));
		draw.RoundedBox(0, w/2-400+1, 0, 800-2, 75-1, Color(0, 125, 255, 255));
		draw.SimpleTextOutlined( 'Наша Steam группа', "npchelper2", w/2, 75/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 200))	
	end
	main['close'] = vgui.Create('DButton', main)
	main['close']:SetSize(30,15)
	main['close']:SetPos(x-80,0)
	main['close']:SetText("")
	main['close'].Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255));
		draw.SimpleTextOutlined( 'X', "npchelper3", w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 255))	
	end
	main['close'].DoClick = function()
		main:Close()
	end
	
	main['fake'] = vgui.Create('DButton', main)
	main['fake']:SetSize(30,15)
	main['fake']:SetPos(x-80-35,0)
	main['fake']:SetText("")
	main['fake']:SetDisabled(true)
	main['fake'].Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(225, 225, 225, 255));
		draw.SimpleTextOutlined( '_', "npchelper3", w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 255))	
	end
	url = vgui.Create('HTML', main)
	url:SetSize(1000, 400)
	url:SetPos(x/2-500, 90)
	url:OpenURL('http://steamcommunity.com/groups/OLDR-P')
end
concommand.Add("_npc_helps_goto-steam", st)

local function don()
	local ply, x, y = LocalPlayer(), ScrW(), ScrH()
	local main = vgui.Create('DFrame')
	main:SetSize(x, 500)
	main:SetPos(0, y / 2 - 250)
	main:MakePopup()
	main.startTime = SysTime()
	main:SetTitle('')
	main:ShowCloseButton(false)
	main:SetDraggable(false)
	main.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255));
		draw.RoundedBox(0, 0, 0, w, 75, Color(35, 35, 35, 255));
		draw.RoundedBox(0, w/2-400+1, 0, 800-2, 75-1, Color(0, 125, 255, 255));
		draw.SimpleTextOutlined( 'Донат', "npchelper2", w/2, 75/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 200))	
	end
	main['close'] = vgui.Create('DButton', main)
	main['close']:SetSize(30,15)
	main['close']:SetPos(x-80,0)
	main['close']:SetText("")
	main['close'].Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255));
		draw.SimpleTextOutlined( 'X', "npchelper3", w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 255))	
	end
	main['close'].DoClick = function()
		main:Close()
	end
	
	main['fake'] = vgui.Create('DButton', main)
	main['fake']:SetSize(30,15)
	main['fake']:SetPos(x-80-35,0)
	main['fake']:SetText("")
	main['fake']:SetDisabled(true)
	main['fake'].Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(225, 225, 225, 255));
		draw.SimpleTextOutlined( '_', "npchelper3", w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 255))	
	end
	url = vgui.Create('HTML', main)
	url:SetSize(1000, 400)
	url:SetPos(x/2-500, 90)
	url:OpenURL('http://vk.com/page-89839485_50901279')
end
concommand.Add("_npc_helps_donat", don)

local function laws()
	local ply, x, y = LocalPlayer(), ScrW(), ScrH()
	local main = vgui.Create('DFrame')
	main:SetSize(x, 500)
	main:SetPos(0, y / 2 - 250)
	main:MakePopup()
	main.startTime = SysTime()
	main:SetTitle('')
	main:ShowCloseButton(false)
	main:SetDraggable(false)
	main.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255));
		draw.RoundedBox(0, 0, 0, w, 75, Color(35, 35, 35, 255));
		draw.RoundedBox(0, w/2-400+1, 0, 800-2, 75-1, Color(0, 125, 255, 255));
		draw.SimpleTextOutlined( 'Правила', "npchelper2", w/2, 75/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 200))	
	end
	main['close'] = vgui.Create('DButton', main)
	main['close']:SetSize(30,15)
	main['close']:SetPos(x-80,0)
	main['close']:SetText("")
	main['close'].Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255));
		draw.SimpleTextOutlined( 'X', "npchelper3", w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 255))	
	end
	main['close'].DoClick = function()
		main:Close()
	end
	
	main['fake'] = vgui.Create('DButton', main)
	main['fake']:SetSize(30,15)
	main['fake']:SetPos(x-80-35,0)
	main['fake']:SetText("")
	main['fake']:SetDisabled(true)
	main['fake'].Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(225, 225, 225, 255));
		draw.SimpleTextOutlined( '_', "npchelper3", w/2, h/2, Color( 255, 255, 255, 255 ), 1, 1, 1, Color(0, 0, 0, 255))	
	end
	url = vgui.Create('HTML', main)
	url:SetSize(1000, 400)
	url:SetPos(x/2-500, 90)
	url:OpenURL('http://vk.com/page-89839485_50894646')

end
concommand.Add("_npc_helps_laws", laws)