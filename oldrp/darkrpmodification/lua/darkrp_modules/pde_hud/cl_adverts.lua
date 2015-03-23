local adverts = {
	{'Уважаемые участники нашего проекта, серверу очень нужна ваша помощь! Нам требуется администрация, и если вы достаточно квалифицированы и готовы работать, а так-же адекватны, то приглашаем вас занять этот пост!', Color(90,155,195)},
	{'Внимание! Требуются модераторы в группу ВК, обращатся к Paradise1337!', Color(185,85,85)},
	{'Уважаемые участники нашего проекта, мы рады вас видеть! Желаем вам приятной игры и хорошего время провождения на нашем сервере!', Color(95,185,115)},
	{'Уважаемые игроки, просим вас соблюдать правила и вести себя адекватно на сервере, удачной игры! С ув. Администраций OLD.RP', Color(115,170,105)},
	{'Рекламное место в этой строке - 150 рублей в мес, подробности у гл админа в скайпе!', Color(185,85,85)},
}
local time = 280 -- Таймер на время вывода сообщения 
local timeshow = 60 -- Время показа 1 сообщения минимум 20

/////////////////////
//-----------------//
//---DON'T TOUCH---//
//-----------------//
/////////////////////


/*---	====	---*/
local _starttime = CurTime() + time
local ply = LocalPlayer()
local x, y = ScrW(), ScrH()
local index = 1
/*---	====	---*/

surface.CreateFont("hudUI_1", {
		font = "Tahoma", 
		size = 18, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

hook.Add('Think', 'ShowMessage', function()
	if (_starttime <= CurTime()) then
		_starttime = CurTime() + time
		if (index > #adverts) then index = 1 end
		if IsValid(_messageShowPanel) then _messageShowPanel:Remove() end  
		_messageShowPanel = vgui.Create("DPanel")
		_messageShowPanel:SetSize(x, 20)
		_messageShowPanel:SetPos(0,0)
		--_messageShowPanel:MoveTo(0, 0, 5, 0, 1)
		_messageShowPanel.Color = adverts[index][2]
		_messageShowPanel.dv = 0
		_messageShowPanel.dv1 = 0
		_messageShowPanel.opening = true
		--_messageShowPanel:MoveTo(-x, 0, 5, timeshow-5, 1) 
		_messageShowPanel.Paint = function(self, w, h)
			if self.opening then
				self.dv = Lerp( 3 * FrameTime(), self.dv or 0, w or 0)
				self.dv1 = Lerp( 1.5 * FrameTime(), self.dv1 or 0, w or 0)
			else
				self.dv = Lerp( 2 * FrameTime(), self.dv, 0)
				self.dv1 = Lerp( 3.5 * FrameTime(), self.dv1, 0)
			end
			draw.RoundedBox(0, w/2-self.dv/2, 0, self.dv, h, Color(0, 0, 0, 200));
			draw.RoundedBox(0, w/2-self.dv1/2, 1, self.dv1, h-2, self.Color);
		end
		if timer.Exists('_hud_telePanel_M1') then timer.Remove('_hud_telePanel_M1') end
		timer.Create('_hud_telePanel_M1',timeshow+3, 1, function() if IsValid(_messageShowPanel) then _messageShowPanel.opening = false end end)

		surface.SetFont("hudUI_1")
		w,h = surface.GetTextSize( adverts[index][1] )
		
		if IsValid(_messageShowPanel_msg) then _messageShowPanel_msg:Remove() end 
		_messageShowPanel_msg = vgui.Create("DPanel")
		_messageShowPanel_msg:SetSize(w+2, 20)
		_messageShowPanel_msg:SetPos(x,0)
		_messageShowPanel_msg.Text = adverts[index][1]
		_messageShowPanel_msg.Color = adverts[index][2]
		_messageShowPanel_msg:MoveTo(-w, 0, timeshow, 3, 1)
		_messageShowPanel_msg.Paint = function(self, w1, h1)
			draw.SimpleTextOutlined( self.Text, "hudUI_1", 1, 0, Color(255, 255, 255, 255), 0, 0, 1, Color(0,0,0,200) )
		end
		if timer.Exists('_hud_telePanel') then timer.Remove('_hud_telePanel') end
		timer.Create('_hud_telePanel',timeshow+6, 1, function() if IsValid(_messageShowPanel_msg) then _messageShowPanel_msg:Remove() end if IsValid(_messageShowPanel) then _messageShowPanel:Remove() end end)
		
		index = index + 1
	end
end)