LOGSYS = {}
LOGSYS.Groups = {
	"Prop",
	"Damage",
	"Action",
	"Player",
	"Manipulation"
}
LOGSYS.cfg = {
	SaveDir = "advlogs",
	ErrorFolder = "Errors",
}

/* === by Men232 === */
local function TimeEnding( time, format )
	time = tostring(time)
	local temp = tonumber( string.Right(time, 1) )
	local ending = ""
	
	if format == "day" then
		if tonumber(time) < 20 and tonumber(time) > 10 then											ending = "days"
		elseif temp == 1 then																		ending = "day"
		elseif temp == 2 or temp == 3 or temp == 4 then												ending = "day"
		elseif temp == 5 or temp == 6 or temp == 7 or temp == 8 or temp == 9 or temp == 0 then		ending = "days"
		end
	elseif format == "year" then
		if tonumber(time) < 20 and tonumber(time) > 10 then											ending = "years"
		elseif temp == 1 then																		ending = "year"
		elseif temp == 2 or temp == 3 or temp == 4 then												ending = "year"
		elseif temp == 5 or temp == 6 or temp == 7 or temp == 8 or temp == 9 or temp == 0 then		ending = "years"
		end
	end
	return " " .. ending .. " "
end

local function ConvertTime( seconds )
	--Convert number of seconds remaining to something more legible (Thanks JamminR!) (Get in ULX)
	if seconds < 0 then seconds = 0 end
	local years = math.floor( seconds / 31536000 )
	seconds = seconds - ( years * 31536000 )
	local days = math.floor( seconds / 86400 )
	seconds = seconds - ( days * 86400 )
	local hours = math.floor( seconds/3600 )
	seconds = seconds - ( hours * 3600 )
	local minutes = math.floor( seconds/60 )
	seconds = seconds - ( minutes * 60 )
	local temp = ""
	--if years ~= 0 then temp = temp .. years .. TimeEnding( years, "year" ) end
	--if days ~= 0 then temp = temp .. days .. TimeEnding( days, "day" ) end
	temp = temp .. ( ( hours < 10 ) and "0" or "" ) .. hours .. ":"
	temp = temp .. ( ( minutes < 10 ) and "0" or "" ) .. minutes .. ":"
	return temp .. ( ( seconds < 10 and "0" or "" ) .. seconds )
end
/* === by Men232 === */

function LOGSYS:GetTime()
	local time = ConvertTime(os.time());
	return time
end

function LOGSYS:ERROR(prefix, msg)
	print(self:GetTime())
end
LOGSYS:ERROR() 
function LOGSYS:AddLine(prefix, msg, group)
	if (!table.HasValue(self.Groups, group)) then self:ERROR("[AddLine]", "Cloudn't to add new line, with: "..prefix.." | "..group) return end
end