gamesystem = gamesystem or {};

netstream.Hook("gsRuningGame", function(data)
	gamesystem.RuningGame = data
end);

netstream.Hook("gsGameRun", function(data)
	gamesystem.GameRun = data
end);

usermessage.Hook("gsDarkenScreen", function( um, ply )
	local time = um:ReadFloat()
	local CP = um:ReadBool()
	gamesystem:Darken(time, CP)
end)

usermessage.Hook("gsSoundPlay", function( um, ply )
	local sound = um:ReadString()
	LocalPlayer():EmitSound(sound)
end)

function gamesystem:Darken(time, CP)
	local ply = LocalPlayer()
	if CP and team.GetName(ply:Team()) ~= "Guards" then return end
	local ply = LocalPlayer()
	local x, y = ScrW(), ScrH()
	local left = vgui.Create("DPanel")
	left:SetSize(x / 2, y)
	left:SetPos(-x / 2, 0)
	left.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,255));
	end
	local right = vgui.Create("DPanel")
	right:SetSize(x / 2, y)
	right:SetPos(x, 0)
	right.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,255));
	end
	
	right:MoveTo( x / 2, 0, 0.5, 0, 0.5 )
	left:MoveTo( 0, 0, 0.5, 0, 0.5 )
	
	timer.Simple(time, function()
		if IsValid(right) then
			right:MoveTo( x, 0, 0.5, 0, 0.5 )
			timer.Simple(0.5, function() right:Remove() end)
		end
		if IsValid(left) then
			left:MoveTo( -x / 2, 0, 0.5, 0, 0.5 )
			timer.Simple(0.5, function() left:Remove() end)
		end
	end)
	usermessage.Hook("gsDarkenScreenClose", function( um, ply )
		if IsValid(right) then
			right:MoveTo( x, 0, 0.5, 0, 0.5 )
			timer.Simple(0.5, function() right:Remove() end)
		end
		if IsValid(left) then
			left:MoveTo( -x / 2, 0, 0.5, 0, 0.5 )
			timer.Simple(0.5, function() left:Remove() end)
		end
	end)
end

//////////////
local function Fonts()
	surface.CreateFont( "gsFont1", {
		font = "Arial", 
		size = 26, 
		weight = 500, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
	} )
	
	surface.CreateFont( "gsFont1_btn", {
		font = "Arial", 
		size = 20, 
		weight = 500, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
	} )
	
	surface.CreateFont( "gsFont1_small", {
		font = "Arial", 
		size = 20, 
		weight = 500, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
	} )
end

Fonts()

local gsmenu = {
	Init = function( self )
		local x, y = ScrW(), ScrH()
		local ply = LocalPlayer()
		local function DClose()
			self:MoveTo( -445, y / 2 - 125, 0.15, 0, 0.5 )
			timer.Simple(0.15, function() if ( IsValid( self ) ) then self:Remove() end end)
		end
		
		self:SetSize(450, 250)
		self:SetPos(-445, y / 2 - 125)
		self:SetTitle("")
		self:ShowCloseButton(false)
		self:SetDraggable(false)
		self:MakePopup()
		self:MoveTo( 0, y / 2 - 125, 0.1, 0, 0.5 )
		
		self.ButtonExit = vgui.Create("DButton", self)
		self.ButtonExit:SetSize(15, 15)
		self.ButtonExit:SetPos(5, 5)
		self.ButtonExit:SetText("")
		self.ButtonExit.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0,200,255,255))
			draw.SimpleText( "X", "gsFont1_small", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
		end
		self.ButtonExit.OnCursorEntered = function()
			surface.PlaySound("items/nvg_off.wav")	
		end
		self.ButtonExit.DoClick = function()
			surface.PlaySound("garrysmod/content_downloaded.wav")
			DClose()
		end
		
		
		self.list = vgui.Create( "DPanelList", self )
		self.list:SetPos( 0,25 )
		self.list:SetSize( 445, 220 )
		self.list:SetSpacing( 2 )
		self.list:SetPadding( 2 )
		self.list:EnableHorizontal( true )
		self.list:EnableVerticalScrollbar( true ) 
		self.list.Paint = function(self, w, h)
		end
		
		self.list.VBar.btnUp.Paint = function(self, w, h)
			draw.RoundedBox(2, w/2 - 7.5 / 2, h/2 - 7.5 / 2, 7.5, 7.5, Color(0,200,255,255))
		end
		
		self.list.VBar.btnDown.Paint = function(self, w, h)
			draw.RoundedBox(2, w/2 - 7.5 / 2, h/2 - 7.5 / 2, 7.5, 7.5, Color(0,200,255,255))
		end
		
		self.list.VBar.btnGrip.Paint = function(self, w, h)
			draw.RoundedBox(2, w/2 - 7.5 / 2, 0, 7.5, h, Color(0,200,255,255))
		end
		
		self.list.VBar.Paint = function(self, w, h)
		end
		
		for k, v in pairs(gamesystem.store) do
			local nm = "gmbuttno"
			
			self[nm..k] = vgui.Create("DButton", self.list)
			self[nm..k]:SetSize(445 / 2 - 4, 25) 
			self[nm..k]:SetText("")
			self[nm..k].Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
				draw.SimpleText( v.name, "gsFont1_btn", w / 2, h / 2, Color(25, 25, 25), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
			end
			self[nm..k].OnCursorEntered = function()
				surface.PlaySound("items/nvg_off.wav")	
				self[nm..k].Paint = function(self, w, h)
					draw.RoundedBox(0, 0 + math.sin(CurTime()*5) * 10, 0, w - math.sin(CurTime()*5) * 20, h, Color(0,200,255,255))
					draw.SimpleText( v.name, "gsFont1_btn", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
				end
			end
			self[nm..k].OnCursorExited = function()
				self[nm..k].Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
					draw.SimpleText( v.name, "gsFont1_btn", w / 2, h / 2, Color(25, 25, 25), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
				end
			end
			self[nm..k].DoClick = function()
				surface.PlaySound("garrysmod/content_downloaded.wav")
				ply:ConCommand(v.concmd)
				DClose()
			end
			self.list:AddItem( self[nm..k] )
		end

	end,
	Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w-5, h, Color(0, 0, 0, 225))	
		draw.RoundedBox(0, w-5, 0, 5, h, Color(0,200,255,255))
		draw.SimpleText( "Games Menu", "gsFont1", w / 2, 12, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
	end
}

GSMENU = vgui.RegisterTable( gsmenu, "DFrame" )

concommand.Add("openGameMenu", function(ply)
	if not IsValid(ply) or not (ply.GetWarden and ply:GetWarden()) then return end
	
	local x, y = ScrW(), ScrH()
	if ( IsValid( gs_menu ) ) then
		gs_menu:MoveTo( -445, y / 2 - 125, 0.15, 0, 0.5 )
		timer.Simple(0.15, function() if ( IsValid( gs_menu ) ) then gs_menu:Remove()
		gs_menu = vgui.CreateFromTable( GSMENU ) end end)
	else
		gs_menu = vgui.CreateFromTable( GSMENU )
	end
end)

concommand.Add("GetClass", function(ply)
end)
