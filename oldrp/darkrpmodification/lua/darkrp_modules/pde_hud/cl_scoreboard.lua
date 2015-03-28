local FRAME = {}

surface.CreateFont("SC1", {
		font = "Roboto", 
		size = 64, 
		weight = 1000, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

surface.CreateFont("SC2", {
		font = "Roboto", 
		size = 20, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

surface.CreateFont("SC3", {
		font = "Tahoma", 
		size = 20, 
		weight = 1000, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
});

function FRAME:Init()
	local x, y, ply = ScrW(), ScrH(), LocalPlayer()

	self:SetSize(1000, 650)
	self:SetPos(x/2-1000/2, y/2-650/2)
	self:MakePopup()
	self.startTime = SysTime()
	self:SetTitle("")
	self:SetDraggable(false)
	self:ShowCloseButton(false)

	do
		self.Scroll = vgui.Create( "DScrollPanel", self ) //Create the Scroll panel
		self.Scroll:SetSize( 1000-10, 650-65-10 )
		self.Scroll:SetPos( 5, 65+5 )

		
		self.Scroll.VBar.btnUp.Paint = function(self, w, h)
		end
		
		self.Scroll.VBar.btnDown.Paint = function(self, w, h)
		end
		
		self.Scroll.VBar.btnGrip.Paint = function(self, w, h)
			draw.RoundedBox(10, w/2 - 7.5 / 2, 0, 7.5, h, Color(35,35,35,255))
		end
		
		self.Scroll.VBar.Paint = function(self, w, h)
			draw.RoundedBox(10, w/2 - 7.5 / 2, 10, 7.5, h-20, Color(180, 85, 85, 255))
		end

		self.List = vgui.Create( "DIconLayout", self.Scroll )
		self.List:SetSize(1000-10, 650-65-10 )
		self.List:SetPos( 0, 0 )
		self.List:SetSpaceY( 5 )
		self.List:SetSpaceX( 5 )

		function self.List:LayoutIcons_TOP()

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

		self["header"] = self.List:Add( "DPanel" )
		self["header"]:SetSize(1000-10, 36)
		self["header"].Paint = function(self,w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(85,65,165));
			draw.SimpleTextOutlined( "Имя:", "SC3", 40, h/2, Color(255,255,255,255), 0, 1, 1, Color(0,0,0,200) )
			draw.SimpleTextOutlined( "Профессия:", "SC3", w/2, h/2, Color(255,255,255,255), 1, 1, 1, Color(0,0,0,200) )
			draw.SimpleTextOutlined( "Фраги".." / ".."Смерти", "SC3", w-250, h/2, Color(255,255,255,255), 1, 1, 1, Color(0,0,0,200) )
			draw.SimpleTextOutlined( "Пинг", "SC3", w-5, h/2, Color(255,255,255,255), 2, 1, 1, Color(0,0,0,200) )
		end
		--local players = table.SortByMember(player.GetAll(), "team")
		--PrintTable(ply)
		for k,v in pairs(player.GetAll()) do
		 	local name = "players"
		 		if !IsValid(v) and IsValid(self[name..k]) then self[name..k]:Remove() end
		 		if !IsValid(v) then return end
		 		
				self[name..k] = self.List:Add( "DPanel" )
				self[name..k]:SetPos( 0, 0 )
				self[name..k]:SetSize(1000-10, 36)
				self[name..k].Paint = function(self, w, h)
					col = Color(150-math.sin(CurTime())*50,100+math.sin(CurTime())*50,200+math.sin(CurTime())*50)
					self['C1'] = Lerp( 1 * FrameTime(), self['C1'] or 255, col.r)
					self['C2'] = Lerp( 1 * FrameTime(), self['C2'] or 255, col.g)
					self['C3'] = Lerp( 1 * FrameTime(), self['C3'] or 255, col.b)
					col = Color(self['C1'], self['C2'], self['C3'], self['h3'])
					draw.RoundedBox(0, 0, 0, w, h, RPExtraTeams[v:Team()].color);
					draw.RoundedBox(0, 0, 0, 36, h, Color(35,35,35));
					draw.SimpleTextOutlined( v:GetName(), "SC3", 40, h/2, Color(255,255,255,255), 0, 1, 1, Color(0,0,0,200) )
					if v:IsVIP() and !v:IsSuperVIP() then
						draw.SimpleTextOutlined( "VIP", "SC3", 250, h/2, Color(255,255,255,255), 0, 1, 1, Color(0,0,0,200) )
					elseif v:IsSuperVIP() then
						draw.SimpleTextOutlined( "Супер VIP", "SC3", 250, h/2, col, 0, 1, 1, Color(0,0,0,200) )
					end
					draw.SimpleTextOutlined( team.GetName(v:Team()), "SC3", w/2, h/2, Color(255,255,255,255), 1, 1, 1, Color(0,0,0,200) )
					draw.SimpleTextOutlined( v:Frags().." / "..v:Deaths(), "SC3", w-250, h/2, Color(255,255,255,255), 1, 1, 1, Color(0,0,0,200) )
					draw.SimpleTextOutlined( v:Ping(), "SC3", w-5, h/2, Color(255,255,255,255), 2, 1, 1, Color(0,0,0,200) )
				end
			
				self[name..k.."icon"] = vgui.Create( "SpawnIcon" , self[name..k] ) -- SpawnIcon
				self[name..k.."icon"]:SetPos( 2, 2 )
				self[name..k.."icon"]:SetSize( 32, 32 )
				self[name..k.."icon"]:SetModel(v:GetModel(), 1, "000000000")
		end
	end
end


function FRAME:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200));

	/*---------------------------------------------------------------------------
	Header
	---------------------------------------------------------------------------*/
	draw.RoundedBox(0, 1, 1, w-2, 64-2, Color(70, 115, 180, 255));
	surface.SetFont("SC1")
	local text = "ExpanisveWorld"
	local TextWidth = surface.GetTextSize(text)
	draw.SimpleTextOutlined( text, "SC1", 10, 0, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,200) )
	draw.SimpleTextOutlined( "- The best gaming community", "SC2", TextWidth+20, 64-30, Color(255,255,255,255), 0, 0, 1, Color(0,0,0,200) )
	draw.SimpleTextOutlined( "Карта: "..game.GetMap()..", игроков: "..#player.GetAll().."/"..game.MaxPlayers(), "SC3", TextWidth+20, 8, Color(255,255,255,150), 0, 0, 1, Color(0,0,0,50) )

	/*---------------------------------------------------------------------------
	END
	---------------------------------------------------------------------------*/

end

vgui.Register('adv_ScoreBoard', FRAME, 'DFrame')

timer.Simple(1, function()
	local scoreboard 
	function GAMEMODE:ScoreboardShow()
		if IsValid(g_Scoreboard) then g_Scoreboard:Remove() end
		if IsValid(scoreboard) then
			scoreboard:Remove()
			scoreboard = vgui.Create("adv_ScoreBoard")
		else
			scoreboard = vgui.Create("adv_ScoreBoard")
		end
	end

	function GAMEMODE:ScoreboardHide()
		if IsValid(g_Scoreboard) then g_Scoreboard:Remove() end
		if IsValid(scoreboard) then
			scoreboard:Remove()
		end
	end
end)
