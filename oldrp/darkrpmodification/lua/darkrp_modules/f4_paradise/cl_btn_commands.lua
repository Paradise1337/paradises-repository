local comGroup = {
	{
		id = "civil",
		name = "Гражданские",
		color = Color(50,150,50),
		check = function(ply)
			return true
		end
	},
	{
		id = "cp",
		name = "Для полиции",
		color = Color(45,115,195),
		check = function(ply)
			return ply:isCP()
		end
	},
	{
		id = "mayor",
		name = "Для мэра",
		color = Color(155,45,45),
		check = function(ply)
			return ply:isMayor()
		end
	},
}

local cmds = {}
cmds["civil"] = {
	{
		name = "Выкинуть деньги",
		doClick = function(ply)
			Derma_StringRequest(
				"Выинуть деньги", 
				"Введите сумму которую вы хотели бы выинуть:", 
				"", 
				function(text) if !ply:canAfford(tonumber(text)) then return end ply:ConCommand("say /dropmoney "..text) end
			)
		end
	},
	{
		name = "Передать деньги",
		doClick = function(ply)
			Derma_StringRequest(
				"Передать деньги", 
				"Введите сумму которую вы хотели бы передать:", 
				"", 
				function(text) if !ply:canAfford(tonumber(text)) then return end ply:ConCommand("say /give "..text) end
			)
		end
	},
	{
		name = "Продать все двери",
		doClick = function(ply)
			ply:ConCommand("say /unownalldoors")
		end
	},
	{
		name = "Сменить RP имя",
		doClick = function(ply)
			Derma_StringRequest(
				"Смена имени", 
				"Введите новое имя:", 
				"", 
				function(text) ply:ConCommand("say /rpname "..text) end
			)
		end
	},
	{
		name = "Выбросить оружие",
		doClick = function(ply)
			ply:ConCommand("say /dropweapon")
		end
	},
	{
		name = "Уволить игрока",
		doClick = function(ply)
			local menu = DermaMenu() 
				for _,v in pairs (player.GetAll()) do
					menu:AddOption( v:Name(), function() 
						Derma_StringRequest("Уволить игрока", "Введите причину.", "", function(reason)
							ply:ConCommand("say /demote "..v:Name().." "..reason)
						end)
					end )
				end
			menu:Open()
		end
	},

}
cmds["cp"] = {
	{
		name = "Обьявить игрока в розыск",
		doClick = function(ply)
			local menu = DermaMenu() 
				for _,v in pairs (player.GetAll()) do
					menu:AddOption( v:Name(), function() 
						Derma_StringRequest("Wanted", "Enter the reason.", "", function(reason)
							ply:ConCommand("say /wanted "..v:Name().." "..reason.."")
						end)
					end )
				end
			menu:Open()
		end
	},
	{
		name = "Выписать ордер на обыск",
		doClick = function(ply)
			local menu = DermaMenu() 
				for _,v in pairs (player.GetAll()) do
					menu:AddOption( v:Name(), function() 
						Derma_StringRequest("Розыск", "Введите причину розыска.", "", function(reason)
							ply:ConCommand("say /warrant "..v:Name().." "..reason.."")
						end)
					end )
				end
			menu:Open()
		end
	},
	{
		name = "Выдать лицензию",
		doClick = function(ply)
			ply:ConCommand("say /givelicense")
		end
	},
}

cmds["mayor"] = {
	{
		name = "Установить доску законов",
		doClick = function(ply)
			ply:ConCommand("say /placelaws")
		end
	},
	{
		name = "Добавить закон",
		doClick = function(ply)
			Derma_StringRequest("Добавление закона", "Напишите новый закон:", "", function(law)
				ply:ConCommand("say /addlaw "..law)
			end)
		end
	},
	{
		name = "Удалить закон",
		doClick = function(ply)
			Derma_StringRequest("Удаление закона", "Введите номер закона:", "", function(number)
				ply:ConCommand("say /removelaw "..number)
			end)
		end
	},
	{
		name = "Установить ком. час в городе",
		doClick = function(ply)
			ply:ConCommand("say /lockdown")
		end
	},
	{
		name = "Остановить ком. час в городе",
		doClick = function(ply)
			ply:ConCommand("say /unlockdown")
		end
	},
	{
		name = "Начать лотерю",
		doClick = function(ply)
			Derma_StringRequest("Лотерея.", "Введите стоимость участия в латерее:", "", function(num)
				ply:ConCommand("say /lottery "..num)
			end)
		end
	},
}


/*---------------------------------------------------------------------------
START OF CODE
---------------------------------------------------------------------------*/
surface.CreateFont("F4BTN-cmd", {
		font = "Tahoma", 
		size = 14, 
		weight = 1000, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

local cmd = {
	name = "Команды",
	callBack = function(self)
		local x, y, ply = ScrW(), ScrH(), LocalPlayer()
		if IsValid(self["run"]) then self["run"]:Remove() end
		self["run"] = vgui.Create("DFrame", self)
		local s = self["run"]
		s:SetSize(800, 400)
		s:SetPos(x/2-800/2, y/2-400/2)
		s.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(35, 35, 35, 200));
			draw.RoundedBox(0, 0, 0, w, 25, Color(180, 85, 85, 255));
			draw.RoundedBox(0, w-128-10-1, 29, 128+2, 128+2, Color(180, 85, 85, 255));
			draw.RoundedBox(0, w-128-10, 30, 128, 128, Color(35, 35, 35, 255));
			draw.SimpleTextOutlined( "Это вы", "F4BTN", w-128/2-5, 29+128+2+10, Color(255,255,255,255), 1, 1, 1, Color(0,0,0,255) )
		end
		s:SetTitle("Команды")
		s:SetDraggable(false)
		s:ShowCloseButton(false)
		/* --- BASE END --- */

		s.icon = vgui.Create("DModelPanel", s)
		s.icon:SetSize(128, 128)
		s.icon:SetModel(ply:GetModel()) -- you can only change colors on playermodels
		function s.icon:LayoutEntity( Entity ) return end -- disables default rotation
		s.icon:SetPos(800-128-10,30)

		local eyepos = s.icon.Entity:GetBonePosition(s.icon.Entity:LookupBone("ValveBiped.Bip01_Head1"))

		eyepos:Add(Vector(0, 0, 2))	-- Move up slightly

		s.icon:SetLookAt(eyepos)

		s.icon:SetCamPos(eyepos-Vector(-15, 0, 5))	-- Move cam in front of eyes

		s.icon.Entity:SetEyeTarget(eyepos-Vector(-11, 0, 0))

		s.Scroll = vgui.Create( "DScrollPanel", s ) //Create the Scroll panel
		s.Scroll:SetSize( 790-128-20, 400-25-10 )
		s.Scroll:SetPos( 5, 30 )

		
		s.Scroll.VBar.btnUp.Paint = function(self, w, h)
		end
		
		s.Scroll.VBar.btnDown.Paint = function(self, w, h)
		end
		
		s.Scroll.VBar.btnGrip.Paint = function(self, w, h)
			draw.RoundedBox(10, w/2 - 7.5 / 2, 0, 7.5, h, Color(35,35,35,255))
		end
		
		s.Scroll.VBar.Paint = function(self, w, h)
			draw.RoundedBox(10, w/2 - 7.5 / 2, 10, 7.5, h-20, Color(180, 85, 85, 255))
		end

		s.List = vgui.Create( "DIconLayout", s.Scroll )
		s.List:SetSize(790-128-20, 400-25-10 )
		s.List:SetPos( 0, 0 )
		s.List:SetSpaceY( 5 )
		s.List:SetSpaceX( 5 )

		function s.List:LayoutIcons_TOP()

			local x			= self.m_iBorder
			local y			= self.m_iBorder
			local RowHeight = 0;
			local MaxWidth	= self:GetWide() - self.m_iBorder * 2;

			local chld = self:GetChildren()
			for k, v in pairs( chld ) do
				v.index = k
				if ( !v:IsVisible() ) then continue end
			
				local w, h = v:GetSize()
				if ( x + w > MaxWidth || ( v.OwnLine && x > self.m_iBorder ) ) then
				
					x = self.m_iBorder
					y = y + RowHeight + self.m_iSpaceY
					RowHeight = 0;
				
				end
				v:LerpPositions( 5, false )
				v:SetPos( x, y )
				
				x = x + v:GetWide() + self.m_iSpaceX
				RowHeight = math.max( RowHeight, v:GetTall() )
				
				-- Start a new line if this panel is meant to be on its own line
				if ( v.OwnLine ) then
					x = MaxWidth + 1
				end
			
			end
			
		end

		for i,g in pairs(comGroup) do
			if !g["check"](ply) then return end
			s["header"..i] = s.List:Add( "DPanel" )
			s["header"..i]:SetSize( 790-10-128-20, 30 )
			s["header"..i].Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, g["color"]);
				draw.SimpleTextOutlined( g["name"], "F4BTN", w/2, h/2, Color(255,255,255,255), 1, 1, 1, Color(0,0,0,255) )
			end
			if !cmds[g["id"]] then return end

			for k,v in pairs(cmds[g["id"]]) do
				s["btn"..i..k] = s.List:Add( "F4MenuButton" )
				s["btn"..i..k]:SetSize( 790-10-128-20, 25 )
				s["btn"..i..k]:SetLabel(v["name"])
				s["btn"..i..k].OnClick = function()
					v["doClick"](ply)
				end
			end
		end
	end
}
if !F4 then return end
F4:RegisterButton(cmd)