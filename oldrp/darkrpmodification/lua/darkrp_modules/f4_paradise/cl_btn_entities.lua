local ents = {
	name = "Ентити",
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
		end
		s:SetTitle("Ентити")
		s:SetDraggable(false)
		s:ShowCloseButton(false)
		/* --- BASE END --- */

		s.Scroll = vgui.Create( "DScrollPanel", s ) //Create the Scroll panel
		s.Scroll:SetSize( 790, 400-25-10 )
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
		s.List:SetSize(790, 400-25-10 )
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

		s["header1"] = s.List:Add( "DPanel" )
		s["header1"]:SetSize( 790-10, 30 )
		s["header1"].Paint = function(self,w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(65,165,85));
			draw.SimpleTextOutlined( "Предметы", "F4BTN", w/2, h/2, Color(255,255,255,255), 1, 1, 1, Color(0,0,0,255) )
		end

		local stat = 0
		for k,v in pairs(DarkRPEntities) do
		 	local name = "entities"

		 	if istable(v.allowed) and table.HasValue(v.allowed, ply:Team()) or !istable(v.allowed) and ply:Team() == v.allowed or v.allowed == nil then
		 		stat = 1
				s[name..k] = s.List:Add( "F4MenuButton" )
				s[name..k]:SetLabel( v.name..", Price: "..v.price.."$" )
				s[name..k]:SetPos( 0, 0 )
				s[name..k]:SetSize(790-10, 32)
				s[name..k].OnClick = function()
					ply:ConCommand("DarkRP "..v.cmd)
				end

				if not ply:canAfford(v.price) then s[name..k]:SetDisabled(true) end

				s[name..k.."icon"] = vgui.Create( "SpawnIcon" , s[name..k] ) -- SpawnIcon
				s[name..k.."icon"]:SetPos( 2, 2 )
				s[name..k.."icon"]:SetSize( 32, 32 )
				s[name..k.."icon"]:SetModel(v.model, 1, "000000000")
			elseif #DarkRPEntities == k and stat == 0 then
				s["header1"]:Remove()
			end

		end

		/*s["header4"] = s.List:Add( "DPanel" )
		s["header4"]:SetSize( 790-10, 30 )
		s["header4"].Paint = function(self,w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(165,0,85));
			draw.SimpleTextOutlined( "Еда", "F4BTN", w/2, h/2, Color(255,255,255,255), 1, 1, 1, Color(0,0,0,255) )
		end

		for k,v in pairs(DarkRP.Foods) do
		 	local name = "food"

			s[name..k] = s.List:Add( "F4MenuButton" )
			s[name..k]:SetLabel( v.name..", Price: "..v.price.."$" )
			s[name..k]:SetPos( 0, 0 )
			s[name..k]:SetSize(790-10, 32)
			s[name..k].OnClick = function()
				ply:ConCommand("DarkRP buyfood "..'"'..v.name..'"')
			end

			if not ply:canAfford(v.price) then s[name..k]:SetDisabled(true) end

			s[name..k.."icon"] = vgui.Create( "SpawnIcon" , s[name..k] ) -- SpawnIcon
			s[name..k.."icon"]:SetPos( 2, 2 )
			s[name..k.."icon"]:SetSize( 32, 32 )
			s[name..k.."icon"]:SetModel(v.model, 1, "000000000")

		end*/
	end

}
if !F4 then return end
F4:RegisterButton(ents)