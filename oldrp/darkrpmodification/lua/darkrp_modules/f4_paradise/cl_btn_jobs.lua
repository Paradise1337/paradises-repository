local jobs = {
	name = "Работы",
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
		s:SetTitle("Работы")
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
		for k,v in pairs(RPExtraTeams) do
		 	local name = "jobs"
				s[name..k.."main"] = s.List:Add( "DPanel" )
				s[name..k.."main"]:SetSize(790-10,32+4)
				s[name..k.."main"].Paint = function()

				end
			
				s[name..k] = vgui.Create( "F4MenuButton", s[name..k.."main"] )
				s[name..k]:SetLabel( v.name..' - Зар-плата: '..v.salary.."$" )
				s[name..k]:SetPos( 0, 0 )
				s[name..k]:SetSize(790-10, 32+4)
				s[name..k].OnClick = function()
					if v.vote then
	                    ply:ConCommand("say /vote"..v.command)
	                else
	                    ply:ConCommand("say /"..v.command)
	                end
				end
				s[name..k]:setColor(v.color)
			
				s[name..k.."icon"] = vgui.Create( "SpawnIcon" , s[name..k] ) -- SpawnIcon
				s[name..k.."icon"]:SetPos( 2, 2 )
				s[name..k.."icon"]:SetSize( 32, 32 )
				if istable(v.model) then
					for r, m in pairs(v.model) do
						if r == #v.model then
							s[name..k.."icon"]:SetModel(m, 1, "000000000")
						end
					end
				else
					s[name..k.."icon"]:SetModel(v.model, 1, "000000000")
				end

				if v.name == team.GetName(ply:Team()) then
	                s[name..k.."main"]:Remove()
	            end
	            if type(v.NeedToChangeFrom) == "number" and ply:Team() ~= v.NeedToChangeFrom then
					s[name..k.."main"]:Remove()
	            elseif type(v.NeedToChangeFrom) == "table" and not table.HasValue(v.NeedToChangeFrom, ply:Team()) then
					s[name..k.."main"]:Remove()
	            end
	            if v.customCheck and not v.customCheck(ply) then
	                s[name..k.."main"]:Remove()
	            end
		end
	end
}
if !F4 then return end
F4:RegisterButton(jobs)